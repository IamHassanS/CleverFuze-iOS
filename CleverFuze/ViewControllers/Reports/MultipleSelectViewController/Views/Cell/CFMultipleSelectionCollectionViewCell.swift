//
//  CFMultipleSelectionCollectionViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 17/10/22.
//

import UIKit

class CFMultipleSelectionCollectionViewCell: CFBaseMultipleSelectionBaseCollectionViewCell {
    
    lazy var imageView: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "UncheckBox")
        return imageView
        
    }()
    
    override var isSelectedData: Bool!{
        didSet{
            self.imageView.image = self.isSelectedData ? #imageLiteral(resourceName: "icons8-checked-checkbox-25") : #imageLiteral(resourceName: "UncheckBox")
        }
    }
    
    override func setConstraint() {
        super.setConstraint()
        
        self.contentView.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
        
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(5)),
            self.imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(25)),
            self.imageView.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(25)),

        ])
        
    }
    
}
