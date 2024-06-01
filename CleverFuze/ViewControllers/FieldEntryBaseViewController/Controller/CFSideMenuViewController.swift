//
//  CFSideMenuViewController.swift
//  CleverFuze
//
//  Created by Ajith  on 23/05/22.
//

import UIKit
import DropDown

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class CFSideMenuViewController: UIViewController {
    
    lazy var tableView : UITableView! = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CFSideMenuTableViewCell.self, forCellReuseIdentifier: String(describing: CFSideMenuTableViewCell.self))
        tableView.contentInset.top = .ratioHeightBasedOniPhoneX(263)
        return tableView
        
    }()
    
    lazy var imageViewBackground: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "sidemenuBg")
        return imageView
        
    }()
    
    lazy var buttonClose: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    var leftMenuController: CFSideMenuController! = CFSideMenuController()
    
    deinit {
        self.leftMenuController = nil
        self.tableView = nil
    }
    
    override func loadView() {
        super.loadView()
        self.addConstraint()
        
    }
    
}

extension CFSideMenuViewController{
    
    func addConstraint(){
        
        self.view.addSubview(self.imageViewBackground)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.buttonClose)

        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.widthAnchor.constraint(equalToConstant: .factionWidthBasedOnScreen(0.8)),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.buttonClose.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.buttonClose.leadingAnchor.constraint(equalTo: self.tableView.trailingAnchor),
            self.buttonClose.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.buttonClose.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.imageViewBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.imageViewBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.imageViewBackground.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor),
            self.imageViewBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
    }
    
}

extension CFSideMenuViewController{
    
    func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
}

extension CFSideMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leftMenuController.arrayOfList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFSideMenuTableViewCell.self), for: indexPath) as! CFSideMenuTableViewCell
        cell.sideMenu = self.leftMenuController.arrayOfList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .ratioHeightBasedOniPhoneX(70)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.slideMenuViewController()?.toggleLeft()
        switch self.leftMenuController.arrayOfList[indexPath.row]{
        case .dashBoard:
            return
        case .customer:
            self.navigationController?.pushViewController(CFBaseFieldEntryViewController().embeddedSideMenuViewController(), animated: true)
        case .wareHouse:
            return
        case .company:
            return
        case .zone:
            return
        case .customerReleaseDelivery:
            return
        case .customerReleaseDock:
            return
        case .user:
            return
        case .reports:
            return
        }
        
    }
}

extension CFSideMenuViewController: CFLogoutDelegate{
    
    func loggedOut() {

    }
    
    @objc
    func closeButtonTapped(){
        self.slideMenuViewController()?.toggleLeft()
    }
    
}
