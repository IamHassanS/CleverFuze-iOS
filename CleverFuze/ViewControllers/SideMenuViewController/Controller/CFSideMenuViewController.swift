//
//  CFSideMenuViewController.swift
//  CleverFuze
//
//  Created by Ajith  on 23/05/22.
//

import UIKit

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
        return tableView
        
    }()
    
    lazy var imageViewBackground: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "sidemenuBg")
        return imageView
        
    }()
  lazy var imageViewLogo: UIImageView = {

      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFill
      imageView.image = #imageLiteral(resourceName: "launchScreenLogo")
      return imageView

  }()
  
    
    lazy var buttonClose: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    lazy var leftMenuController: CFSideMenuController! = CFSideMenuController()
    
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
        self.imageViewBackground.addSubview(self.imageViewLogo)

        NSLayoutConstraint.activate([
        
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor ,constant:.factionHeightBasedOnScreen(0.28)),
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
            
            self.imageViewLogo.topAnchor.constraint(equalTo: self.imageViewBackground.topAnchor, constant: .ratioHeightBasedOniPhoneX(56)),
            self.imageViewLogo.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.imageViewLogo.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(103)),
            self.imageViewLogo.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(66)),

        ])
    }
    
}

extension CFSideMenuViewController{
    
    func updateTableView(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
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
        cell.selectView.backgroundColor = UIColor.white.withAlphaComponent(self.leftMenuController.selectedIndexPath == indexPath ? 0.35 : 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .ratioHeightBasedOniPhoneX(70)
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.slideMenuViewController()?.toggleLeft()
        let controller = self.leftMenuController.viewController(self.leftMenuController.arrayOfList[indexPath.row])
        
        guard let bool = (self.navigationController?.viewControllers.last as? ExSlideMenuController)?.mainViewController?.isKind(of: controller), !bool else{
            return
        }
        
        for viewController in (self.navigationController?.viewControllers ?? []) {
            if (viewController as? ExSlideMenuController)?.mainViewController?.isKind(of: controller) ?? false{
                self.navigationController?.popToViewController(viewController, animated: false)
                return
            }
        }
        
        switch self.leftMenuController.arrayOfList[indexPath.row]{
        case .dashBoard:
            return
        case .customer:
            self.navigationController?.pushViewController(CFViewCustomerViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .customertype:
            self.navigationController?.pushViewController(CFCustomerTypeViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .wareHouse:
            self.navigationController?.pushViewController(CFViewWareHouseViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .zone:
            self.navigationController?.pushViewController(CFAddZoneViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .company:
            self.navigationController?.pushViewController(CFCompanyViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .customerReleaseDock:
            self.navigationController?.pushViewController(CFDockViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .customerReleaseDelivery:
            self.navigationController?.pushViewController(CFDeliveryViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .user:
            self.navigationController?.pushViewController(CFUsersViewController().embeddedSideMenuViewController(indexPath), animated: false)
        case .reports:
            self.navigationController?.pushViewController(CFReportViewController().embeddedSideMenuViewController(indexPath), animated: false)
            return
        }
        
    }
}

extension CFSideMenuViewController{

    @objc
    func closeButtonTapped(){
        self.slideMenuViewController()?.toggleLeft()
    }
    
}
