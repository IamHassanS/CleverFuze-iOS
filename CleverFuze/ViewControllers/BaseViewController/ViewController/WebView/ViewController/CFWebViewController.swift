//
//  CFWebViewController.swift
//  CleverFuze
//
//  Created by SivanSakthi on 22/11/23.
//

import UIKit
import WebKit

class CFWebViewController: UIViewController {
    
    var url: URL?
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self 
        webView.scrollView.delegate = self
        webView.scrollView.maximumZoomScale = 5.0
        webView.showsLargeContentViewer = true
        return webView
    }()
    
    lazy var containerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
        
    }()
    
    override func loadView() {
        super.loadView()
        
        self.getUrl()
        self.setViewAndConstraints()
    }
    
    
    func setViewAndConstraints(){
        
        self.view.backgroundColor = .white
        self.view.addSubview(containerView)
        self.containerView.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            webView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            webView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            webView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            webView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
            
        ])
    }
    
    func getUrl(){
        
        if let url = url {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }
}

extension CFWebViewController: WKNavigationDelegate, UIScrollViewDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web view did finish loading")
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.webView
    }
}
