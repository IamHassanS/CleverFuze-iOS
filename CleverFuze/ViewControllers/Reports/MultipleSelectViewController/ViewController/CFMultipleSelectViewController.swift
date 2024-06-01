//
//  CFMultipleSelectViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 17/10/22.
//

import UIKit

class CFMultipleSelectViewController: UIViewController {

    lazy var selectionView: CFMultipleSelectionFieldView! = {
         
        let view = CFMultipleSelectionFieldView()
        view.dataSource = self.controller
        view.delegate = self.controller
        return view
        
    }()
    
    lazy var button: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(self.didTapBackground), for: .touchUpInside)
        return button
        
    }()
    
    lazy var controller: CFMultipleSelectController! = CFMultipleSelectController()

    override func loadView() {
        super.loadView()
        
        self.setView()
        self.setConstraint()
        
    }
    
}

extension CFMultipleSelectViewController{
    
    func setView(){
        
        self.controller.delegate = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
    }
    
    func setConstraint(){
        
        self.view.addSubview(self.button)
        self.view.addSubview(self.selectionView)

        let defaultHeight: CGFloat = .factionHeightBasedOnScreen(0.75)
        let calculateHeight: CGFloat = .ratioHeightBasedOniPhoneX(50) + CGFloat((self.controller.dataCount() * 60))
        let finalHeight = defaultHeight > calculateHeight ? calculateHeight : defaultHeight
        
        NSLayoutConstraint.activate([
        
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.selectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.selectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.selectionView.heightAnchor.constraint(equalToConstant: finalHeight),
            self.selectionView.widthAnchor.constraint(equalToConstant: .factionWidthBasedOnScreen(0.8))

        ])
        
    }
    
}

extension CFMultipleSelectViewController: CFMultipleSelectViewDelegate{
    
    func closeButtonClicked() {
        self.didTapBackground()
    }
    
    func doneButtonClicked() {
        self.controller.passData()
        self.dismiss(animated: true)
    }
    
}

extension CFMultipleSelectViewController{
    
    @objc func didTapBackground(){
        self.dismiss(animated: true)
    }
    
}
