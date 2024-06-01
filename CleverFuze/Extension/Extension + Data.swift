//
//  Extension + Data.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/09/22.
//

import Foundation

extension Data{
    
    func convertToCodable<T: Codable>(_ type: T.Type) -> T?{
        
        guard let response = try? JSONDecoder().decode(T.self, from: self) else {
            return nil
        }
        return response
        
    }
    
}

extension Data {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.jsonObject(with: self, options: []) as? NSDictionary {
            var swiftDict: [String: Any] = [:]
            for key in theJSONData.allKeys {
                let stringKey = key as? String
                if let key = stringKey, let keyValue = theJSONData.value(forKey: key) {
                    swiftDict[key] = keyValue
                }
            }
            swiftDict.printAsJSON()
        }
    }
}

public extension Dictionary {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
}

public extension Collection {
    /// Convert self to JSON String.
    /// Returns: the pretty printed JSON string or an empty string if any error occur.
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

//Usage:-
extension Data {
    func printResponse(with endpoint: String, and params: [String : Any]) {
        print("<========================================================================>")
        print("\nHTTP request: \(endpoint)\nParams: \(params.json())\n")
        print("ResponseData:")
        self.printAsJSON()
    }
}

extension Data {
    
    static func base64EncodedStringFromFile(atPath path: String) -> String? {
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: path))
            return fileData.base64EncodedString()
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}
