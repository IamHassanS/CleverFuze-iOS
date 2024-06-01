//
//  CFMultipleSelectionFieldView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 17/10/22.
//

import Foundation
import UIKit

class CFMultipleSelectionFieldView: UIView {
    
    lazy var labelTitle: UILabel! = {
        
        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = .setFont(.semiBold, size: 20)
        labelTitle.backgroundColor = .clear
        labelTitle.textColor = .black
        labelTitle.text = "Select"
        return labelTitle
        
    }()
    
    lazy var rightButton: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.primaryColor, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.maskBounds = true
        button.addTarget(self, action: #selector(self.doneButtonAction), for: .touchUpInside)
        return button
        
    }()
    
    lazy var leftButton: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "CloseIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.maskBounds = true
        button.addTarget(self, action: #selector(self.closeButtonAction), for: .touchUpInside)
        return button
        
    }()
    
    lazy var collectionView: UICollectionView! = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CFBaseMultipleSelectionBaseCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CFBaseMultipleSelectionBaseCollectionViewCell.self))
        collectionView.register(CFMultipleSelectionCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CFMultipleSelectionCollectionViewCell.self))
        return collectionView
        
    }()
    
    lazy var layout: UICollectionViewCompositionalLayout! = {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (section, enviroment) -> NSCollectionLayoutSection in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            let orthogonallyScrolls: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(60)),
                subitems: [leadingItem])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = orthogonallyScrolls
            return section
            
        }, configuration: config)
        return layout
        
    }()
    
    weak var dataSource: CFMultipleSelectionDataSource?
    weak var delegate: CFMultipleSelectionDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setView()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFMultipleSelectionFieldView{
    
    func setView(){
        
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.maskBounds = true
        self.viewCornerRadius = .ratioWidthBasedOniPhoneX(20)
        
    }
    
    func setConstraint(){
        
        self.addSubview(self.rightButton)
        self.addSubview(self.leftButton)
        self.addSubview(self.labelTitle)
        self.addSubview(self.collectionView)

        NSLayoutConstraint.activate([
        
            self.rightButton.centerYAnchor.constraint(equalTo: self.labelTitle.centerYAnchor),
            self.rightButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),

            self.leftButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.leftButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.leftButton.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(50)),
            self.leftButton.widthAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(50)),

            self.labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: .ratioHeightBasedOniPhoneX(10)),
            self.labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.collectionView.topAnchor.constraint(equalTo: self.leftButton.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        ])
        
    }
}

extension CFMultipleSelectionFieldView{
    
    @objc func doneButtonAction(){
        self.delegate?.doneButtonClicked()
    }
    
    @objc func closeButtonAction(){
        self.delegate?.closeButtonClicked()
    }
    
}

extension CFMultipleSelectionFieldView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.dataCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CFMultipleSelectionCollectionViewCell.self), for: indexPath) as! CFBaseMultipleSelectionBaseCollectionViewCell
        cell.isSelectedData = self.dataSource?.isSelected(indexPath.row)
        cell.data = self.dataSource?.dataForIndex(indexPath.row)
        return cell
        
    }
    
}

extension CFMultipleSelectionFieldView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectedTheValue(indexPath.row)
        self.collectionView.reloadData()
        let count = self.dataSource?.dataSelectedCount() ?? 0
        self.labelTitle.text = "Select \(count == 0 ? "" : "(\(count))")"
    }
    
}
