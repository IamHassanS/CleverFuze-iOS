//
//  CFPageNumberView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import UIKit

class CFPageNumberView: UIView {

    lazy var buttonPrevious: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "chevron-left"), for: [.normal])
        button.addTarget(self, action: #selector(self.buttonaAction(_:)), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .clear
        return button
        
    }()
            
    lazy var buttonNext: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "chevron-right"), for: [.normal])
        button.addTarget(self, action: #selector(self.buttonaAction(_:)), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .clear
        return button
        
    }()
    
    lazy var collectionView: UICollectionView! = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CFPageNumberCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CFPageNumberCollectionViewCell.self))
        collectionView.isScrollEnabled = false
        return collectionView
        
    }()
    
    lazy var layout: UICollectionViewCompositionalLayout! = {

        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
        
    }()
    
    weak var delegate: CFRecordDataHandlerDelegate?{
        didSet{
            self.setButtonChange()
            self.reloadCollectionView()
        }
    }
    weak var pageDelegate: CFPageNumberChangeDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set
        self.setView()
        self.setConstraint()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.buttonPrevious.layer.cornerRadius = self.buttonPrevious.frame.height / 2
        self.buttonNext.layer.cornerRadius = self.buttonNext.frame.height / 2
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFPageNumberView{
    
    func setView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }
    
    func setConstraint(){
        
        self.addSubview(self.collectionView)
        self.addSubview(self.buttonNext)
        self.addSubview(self.buttonPrevious)

        NSLayoutConstraint.activate([

            self.buttonPrevious.topAnchor.constraint(equalTo: self.topAnchor, constant: .ratioWidthBasedOniPhoneX(5)),
            self.buttonPrevious.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            self.buttonPrevious.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(5)),
            NSLayoutConstraint(item: self.buttonPrevious as Any, attribute: .height, relatedBy: .equal, toItem: self.buttonPrevious, attribute: .width, multiplier: 1, constant: 0),

            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.buttonPrevious.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            self.collectionView.trailingAnchor.constraint(equalTo: self.buttonNext.leadingAnchor, constant: -.ratioWidthBasedOniPhoneX(10)),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.buttonNext.topAnchor.constraint(equalTo: self.topAnchor, constant: .ratioWidthBasedOniPhoneX(5)),
            self.buttonNext.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(10)),
            self.buttonNext.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(5)),
            NSLayoutConstraint(item: self.buttonNext as Any, attribute: .height, relatedBy: .equal, toItem: self.buttonNext, attribute: .width, multiplier: 1, constant: 0),

        ])
        
    }

}

//#MARK: Config the collection

extension CFPageNumberView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.isHidden = self.totalPage() <= 1
        return self.totalPage()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CFPageNumberCollectionViewCell.self), for: indexPath) as! CFPageNumberCollectionViewCell
        let currentPage = self.delegate?.currentPageIndex() ?? 0
        cell.pageNumberLabel.text = "\(indexPath.row + 1)"
        cell.gradientLayerView.isHidden = !(indexPath.row == currentPage)
        cell.pageNumberLabel.textColor = (indexPath.row == currentPage) ? .white : .black
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastIndexPath = IndexPath(item: self.currentPage(), section: 0)
        self.delegate?.didSetCurrentPageIndex(indexPath.row)
        self.setButtonChange()
        self.pageDelegate?.pageNumberDidChange()
        self.collectionView.reloadItems(at: [lastIndexPath, indexPath])
    }
    
}

extension CFPageNumberView{
    
    @objc
    func buttonaAction(_ button: UIButton){

        let lastIndexPath = IndexPath(item: self.currentPage(), section: 0)
        if button == self.buttonPrevious, self.currentPage() > 0  {
            self.delegate?.didSetCurrentPageIndex(self.currentPage() - 1)
        }
        
        if button == self.buttonNext, self.currentPage() < (self.totalPage() - 1)  {
            self.delegate?.didSetCurrentPageIndex(self.currentPage() + 1)
        }
        
        self.setButtonChange()
        self.collectionView.reloadItems(at: [lastIndexPath, IndexPath(item: self.currentPage(), section: 0)])
        self.collectionView.scrollToItem(at: IndexPath(item: self.currentPage(), section: 0), at: .centeredHorizontally, animated: true)
        self.pageDelegate?.pageNumberDidChange()
    }
    
    func setButtonChange(){
        
        self.buttonPrevious.isEnabled = self.currentPage() > 0
        self.buttonNext.isEnabled = self.currentPage() < (self.totalPage() - 1)

        self.buttonPrevious.backgroundColor = (self.currentPage() > 0) ? .pageGradientFirstColor : .clear
        self.buttonNext.backgroundColor = (self.currentPage() < (self.totalPage() - 1)) ? .pageGradientFirstColor : .clear

    }

}

extension CFPageNumberView{
    
    func currentPage() -> Int{
        return self.delegate?.currentPageIndex() ?? 0
    }
    
    func totalPage() -> Int{
        return self.delegate?.totalPage() ?? 0
    }
    
}

extension CFPageNumberView{
    
  func moveToPreviousPage(){
    
    self.buttonaAction(self.buttonPrevious)
    
  }
  
}

extension CFPageNumberView{
    
    func reloadCollectionView(){
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.setCollectionViewLayout(self.layout, animated: true)
        self.collectionView.reloadData()
    }
    
}
