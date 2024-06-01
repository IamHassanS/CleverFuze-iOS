//
//  CFCommunicationController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 25/08/22.
//

import Alamofire
import UIKit

typealias CFResponse = (data: Data?, error: String?, status: CFHTTPStatusCode?)

struct CFCommunicationController {
    
    private static var lastNetworkRequest: (() -> Void)?
    
    private static var isAlertShown = false

    
    static let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "queue.app.cf.main", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global(qos: .userInitiated))
    
    public static var operationQueue: OperationQueue = {
        let operation = OperationQueue()
        operation.qualityOfService = .background
        operation.maxConcurrentOperationCount = 1
        operation.name = Bundle.main.bundleIdentifier
        return operation
    }()
    
    public static let customSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        // timeoutIntervalForRequest is 60 for reducing the request time out error while hitting the api.
        configuration.timeoutIntervalForRequest = 60
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: operationQueue)
        return session
    }()
    
    
    static func networkRequest(endPoint: CFEndPoint, requestMethod:HTTPMethod = .post , params: [String: String]? = nil, postBody: [String: Any]? = nil, completionHandler: @escaping (CFResponse) -> (), retry retryAPI: (() -> Void?)? = nil) {
        
        lastNetworkRequest = {
            self.networkRequest(endPoint: endPoint, requestMethod: requestMethod, params: params, postBody: postBody, completionHandler: completionHandler, retry: retryAPI)
        }
        
        guard Reachability.isConnectedToNetwork() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.callRetryOption()
            }
            return
        }
        CFCommunicationController.operationQueue.isSuspended = false
        let urlComponend = CFCommunicationController.urlComponentsHandler(params: params, endPoint: endPoint.url)
        
        guard let url = urlComponend?.url else {
            return
        }
        
        debugPrint("------------------------->url", url)
        print("The request payload, \(String(describing: postBody))")
        
        debugPrint("------------------------->Authorization", "Bearer \(StrongboxController.userData?.token ?? "")" )

        let needMultiPart = postBody?.filter{($0.value as? Data) != nil} ?? []
        
        guard needMultiPart.isEmpty else{
            self.imageUpload(endPoint, method: requestMethod, parameter: postBody ?? [:], success: completionHandler, retry: retryAPI)

            return
        }
 
        // timeoutIntervalForRequest is 60 for reducing the request time out error while hitting the api.
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        request.httpMethod = requestMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + (StrongboxController.userData?.token ?? ""), forHTTPHeaderField: "Authorization")

        if let body = postBody{
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                request.httpBody = data
            } catch let errorMsg {
                completionHandler((nil, errorMsg.localizedDescription , .some(.badRequest)))
                return
            }
        }
        self.apiCall(request: request) { data, error, statusCode in
            if error != nil{
                var string: NSString = ""
                if let data = data{
                    string = NSString(data: data , encoding: String.Encoding.utf8.rawValue) ?? ""
                    completionHandler((data, string.localizedCapitalized , statusCode))
                    return
                }
            }
            completionHandler((data, error, statusCode))
        } retryAPI: {
            retryAPI?()
        }
        
    }
    
    static func callRetryOption() {

        if let topViewController = UIApplication.topViewController(), topViewController.presentedViewController == nil {
            let alertController = UIAlertController(
                title: "No Internet Connection",
                message: "Please check your internet connection and try again.",
                preferredStyle: .alert
            )
            
            alertController.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                showLoader()
                self.lastNetworkRequest?()
                isAlertShown = false
            })
            
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                dismissLoader()
                isAlertShown = false
            })
            
            if !isAlertShown {
                isAlertShown = true
                DispatchQueue.main.async {
                    topViewController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    private static func dismissLoader() {
        if let topViewController = UIApplication.topViewController() as? CFBaseViewController {
            topViewController.loadingView.removeLoadingScreen()
        }
    }
    
    private static func showLoader() {
        if let topViewController = UIApplication.topViewController() as? CFBaseViewController {
            topViewController.loadingView.setLoadingScreen(view: topViewController.view)
        }
    }
    
    private static func apiCall(request: URLRequest, completionHandler: @escaping (CFResponse) -> (), retryAPI: (() -> Void?)?){
        queue.async {
            self.customSession.dataTask(with: request) { (data, response, error) in
                data?.printAsJSON()
                print(response as Any)
                print(error as Any)
                guard let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        self.callRetryOption()
                    }
                    return
                }
                if response.statusCode == 503{
                    completionHandler((nil, CFErrorMessage.underMaintance, response.status))
                    return
                }
                if response.statusCode == 401, response.url?.absoluteString != CFEndPoint.dropdown.url{
                    DispatchQueue.main.async {
                        StrongboxController.clearSecureEnclave()
                        (UIApplication.shared.delegate as? AppDelegate)?.setAsRootViewController([CFLoginViewController()])
                    }
                    return
                }
                guard let data = data else{
                    completionHandler((nil, nil, response.status))
                    return
                }
                completionHandler((data, nil, response.status))
                
            }.resume()
        }
    }
    
    static func urlComponentsHandler(params: [String: String]?, endPoint: String) -> URLComponents? {
        var urlComponend = URLComponents(string: endPoint)
        
        if let urlParams = params{
            var item = [URLQueryItem]()
            for (_, (key, value)) in urlParams.enumerated(){
                item.append(URLQueryItem(name: key, value: value))
            }
            urlComponend?.queryItems = item
        }
        return urlComponend
    }
    
}

extension CFCommunicationController{
    
    static func imageUpload(_ endPoint: CFEndPoint, method: HTTPMethod, parameter:[String:Any], success:@escaping (CFResponse) -> () ,retry retryAPI: (() -> Void?)? = nil){
        var headers: HTTPHeaders = [.accept("application/json")]
        if let token = StrongboxController.userData?.token, !token.isEmpty{
            headers = [.contentType("application/json") ,.authorization("Bearer " + token)]
        }
        AF.upload(multipartFormData: { (mulitpart) in
            for (key, value) in parameter {
                if let data = parameter["\(key)"] as? Data {
                    mulitpart.append(data, withName:key, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    
                }else{
                    mulitpart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, to: endPoint.url, method: method, headers: headers).uploadProgress(queue: .global(qos: .background)) { (progress) in
            debugPrint("Progress \(progress.completedUnitCount)")
        }.responseString { (string) in
            debugPrint(string.result)
        }.responseJSON { (data) in
            debugPrint(data.data != nil)
            data.data?.printAsJSON()
        
            guard let response = data.response else {
                self.callRetryOption()
                return
            }
            if response.statusCode == 503{
                success((nil, CFErrorMessage.underMaintance, response.status))
                return
            }
            if response.statusCode == 401{
                DispatchQueue.main.async {
//                    StrongboxController.clearSecureEnclave()
                    (UIApplication.shared.delegate as? AppDelegate)?.setAsRootViewController([CFLoginViewController()])
                }
                return
            }
            guard let data = data.data else{
                success((nil, nil, response.status))
                return
            }
            success((data, nil, response.status))
        }
    }
}

    
