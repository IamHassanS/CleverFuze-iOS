//
//  CFRecordView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFRecordView: CFBaseRecordView {
    
    lazy var searchBar: CFSearchTextField! = {
        
        let searchBar = CFSearchTextField()
        searchBar.searchDelegate = self.delegate
        return searchBar
        
    }()
    
    lazy var pageView: CFPageNumberView! = {
        
        let pageView = CFPageNumberView()
        pageView.setHeightConstraint(.ratioHeightBasedOniPhoneX(45))
        pageView.pageDelegate = self
        return pageView
        
    }()
    
    override var delegate: CFRecordDataHandlerDelegate?{
        didSet{
            self.pageView.delegate = self.delegate
            self.searchBar.searchDelegate = self.delegate
            self.pageView.collectionView.reloadData()
        }
    }
    
    lazy var constraintPageViewBottom: NSLayoutConstraint! = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func currentPage() -> Int {
        return self.pageView.currentPage()
    }
    
    override func hideTheAllView(){
        super.hideTheAllView()
        self.tableView.isHidden = true
        self.pageView.isHidden = true
        self.noRecordFoundLabel.isHidden = true
    }
    
    override func setValueView() {
        super.setValueView()
        self.hideTheAllView()
        self.tableView.isHidden = false
        self.pageView.isHidden = false
        self.constraintPageViewBottom.isActive = true
        self.noRecordFoundLabelBottomConstraint.isActive = false
   }
    
    override func moveToPreviousPage() {
        super.moveToPreviousPage()
        self.pageView.moveToPreviousPage()
    }
    
    override func setConstraint() {
        super.setConstraint()
        self.noRecordFoundLabel.removeFromSuperview()
        
        self.addSubview(self.searchBar)
        self.addSubview(self.tableView)
        self.addSubview(self.pageView)
        self.addSubview(self.noRecordFoundLabel)
        
        self.tableViewHeightConstraint = self.tableView.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(565))
        self.constraintPageViewBottom = self.pageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(35))
        self.noRecordFoundLabelBottomConstraint = self.noRecordFoundLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(10))

        NSLayoutConstraint.activate([
            
            self.searchBar.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(302)),
            self.searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(55)),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -.ratioWidthBasedOniPhoneX(20)),
            self.tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tableViewHeightConstraint,
            
            self.pageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.pageView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(30)),
            self.constraintPageViewBottom!,
            self.pageView.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(225)),
            
            self.noRecordFoundLabel.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(10)),
            self.noRecordFoundLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioHeightBasedOniPhoneX(10)),
            self.noRecordFoundLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.ratioHeightBasedOniPhoneX(10)),
            
        ])
                
    }
    
    override func setConstraintForEmptyLabel() {
        super.setConstraintForEmptyLabel()
        self.hideTheAllView()
        self.noRecordFoundLabel.isHidden = false
        self.searchBar.isHidden = false
        self.constraintPageViewBottom.isActive = false
        self.noRecordFoundLabelBottomConstraint.isActive = true
    }
}

extension CFRecordView{
    
    @objc func reloadData(){
        self.tableView.reloadData()
        self.pageView.reloadCollectionView()
    }
    
}

extension CFRecordView{
    
    func setView(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
}

extension CFRecordView: CFPageNumberChangeDelegate{
    
    func pageNumberDidChange() {
        self.tableView.reloadData()
        self.delegate?.reloadTheData()
    }
    
}
