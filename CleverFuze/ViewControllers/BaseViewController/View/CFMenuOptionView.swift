//
//  CFMenuOptionView.swift
//  CleverFuze
//
//  Created by venkat subramaian on 05/09/22.
//

import UIKit

class CFMenuOptionView: UITableView {
     
    weak var menuDelegate: CFMenuOptionDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
      
extension CFMenuOptionView {
    
    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        self.rowHeight = .ratioHeightBasedOniPhoneX(55)
        self.heightAnchor.constraint(equalToConstant: CGFloat(CFMenuOption.allCases.count) * .ratioHeightBasedOniPhoneX(55)).isActive = true
        self.layer.cornerRadius = .ratioHeightBasedOniPhoneX(15)
        self.clipsToBounds = true
    }
}
      
extension CFMenuOptionView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CFMenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        if #available(iOS 14.0, *) {
            var config = UIListContentConfiguration.cell()
            config.text = CFMenuOption.allCases[indexPath.row].rawValue
            config.textProperties.color = .black
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = CFMenuOption.allCases[indexPath.row].rawValue
            cell.textLabel?.textColor = .black
        }
        cell.selectionStyle = .none
        return cell
        
    }
}
      
extension CFMenuOptionView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        self.menuDelegate?.optionDidSelected(CFMenuOption.allCases[indexPath.row])
    }

}
 
                                                            
