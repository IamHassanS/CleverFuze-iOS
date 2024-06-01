//
//  CFBaseFieldEntryViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFBaseFieldEntryViewController: CFBaseViewController {

    lazy var tableView: UITableView! = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CFHomeDashboardTableViewCell.self, forCellReuseIdentifier: String(describing: CFHomeDashboardTableViewCell.self))
        tableView.contentInset.top = .ratioHeightBasedOniPhoneX(24)
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension CFBaseFieldEntryViewController{
    
    
    
}
