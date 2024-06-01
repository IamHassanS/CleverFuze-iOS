//
//  CFLoadingView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFLoadingView {
    
    private lazy var viewBG: UIView! = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
       return view
        
    }()
    private lazy var loadingView: UIView! = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.black
        view.alpha = 0.85
        return view
        
    }()
    private lazy var spinner: UIActivityIndicatorView! = {
        
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.color = .white
        view.backgroundColor = .clear
        view.startAnimating()
        return view
        
    }()
    
    private lazy var loadingLabel: UILabel! = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(12))
        label.text = "Loading"
        label.textColor = .white
        label.textAlignment = .center
        return label
        
    }()
    
    func setLoadingScreen(view: UIView) {
        viewBG.frame = view.frame
        (UIApplication.shared.delegate as? AppDelegate)?.navigationController?.visibleViewController?.view.isUserInteractionEnabled = false
        loadingView.addSubview(spinner)
        viewBG.addSubview(loadingView)
        viewBG.addSubview(self.loadingLabel)
        view.addSubview(viewBG)
        
        NSLayoutConstraint.activate([
        
            self.loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.loadingView.widthAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(125)),
            self.loadingView.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(130)),

            self.spinner.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor),
            self.spinner.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor),
            self.spinner.widthAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(30)),
            self.spinner.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(30)),

            self.loadingLabel.topAnchor.constraint(equalTo: self.spinner.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(13)),
            self.loadingLabel.leadingAnchor.constraint(equalTo: self.loadingView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(13)),
            self.loadingLabel.trailingAnchor.constraint(equalTo: self.loadingView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(13)),
            self.loadingLabel.bottomAnchor.constraint(equalTo: self.loadingView.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(13)),

        ])
        
    }
    
    func removeLoadingScreen() {
        (UIApplication.shared.delegate as? AppDelegate)?.navigationController?.visibleViewController?.view.isUserInteractionEnabled = true
        spinner.removeFromSuperview()
        loadingView.removeFromSuperview()
        loadingLabel.removeFromSuperview()
        viewBG.removeFromSuperview()
    }
}
