//
//  CFHomeDashBaordViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 02/08/22.
//

import UIKit


class CFHomeDashBaordViewController: CFBaseViewController {
  
  let refreshControl = UIRefreshControl()
    lazy var tableView: UITableView! = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CFHomeDashboardTableViewCell.self, forCellReuseIdentifier: String(describing: CFHomeDashboardTableViewCell.self))
        tableView.contentInset.top = .ratioHeightBasedOniPhoneX(24)
        return tableView
        
    }()
    
    lazy var dashboardController: CFDashBoardController! = CFDashBoardController()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingView.setLoadingScreen(view: self.view)
        self.dashboardController.callAPI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addConstraint()
        self.headerView.labelTitle.text = "Dashboard"
        self.dashboardController.delegate = self
        self.dashboardController.callAPI()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    
         }
    }


extension CFHomeDashBaordViewController{
    
    func addConstraint(){
        
        self.view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
    }
    
}

extension CFHomeDashBaordViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CFDashBoardList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFHomeDashboardTableViewCell.self), for: indexPath) as! CFHomeDashboardTableViewCell
        cell.recordsTitleLabel.text = CFDashBoardList.allCases[indexPath.row].rawValue
        cell.recordsCountLabel.text = String(self.dashboardController.dashBoardData(CFDashBoardList.allCases[indexPath.row]) ?? 0)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .ratioHeightBasedOniPhoneX(136)
    }
}

extension CFHomeDashBaordViewController: CFDashboardDelegate{

    override func apiSucess() {
        super.apiSucess()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
        
}

extension CFHomeDashBaordViewController: CFDashboardMoreActionDelegate{
    
    func didMoreSelected(_ index: Int) {
        debugPrint(index, "-------------------")
        let push = CFRecordViewController()
        push.controller?.dashBoardType = CFDashBoardList.allCases[index]
        self.navigationController?.pushViewController(push, animated: true)
  
    }
  @objc func refresh(_ sender: AnyObject) {
      self.loadData()
  }
 func loadData() {
               dashboardController.callAPI()
                 self.refreshControl.endRefreshing()
           }
}
