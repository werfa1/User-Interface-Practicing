//
//  GlobalSearchGroupVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 18.06.2021.
//

import UIKit

protocol SubscriptionDelegate: AnyObject {
    func didSubscribeToGroup(_ group: Group, atIndex index: Int)
}

class GlobalSearchGroupVC: UITableViewController {
    
    //MARK: - Variables
    
    weak var subcribeDelegate: SubscriptionDelegate?
    
    var globalGroupList = [Group]()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GlobalSearchCell.self, forCellReuseIdentifier: GlobalSearchCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.15

    }
}
    //MARK: - Extensions

extension GlobalSearchGroupVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalGroupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalSearchCell.identifier, for: indexPath) as! GlobalSearchCell

        cell.configureCell(WithGroup: globalGroupList[indexPath.row])

        return cell
    }
    
    private func followGroup(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Follow") { [weak self] (_, _, _) in
            guard let self = self else {return}
            
            //Update model
            let subscribedGroup = self.globalGroupList.remove(at: indexPath.row)
            self.subcribeDelegate?.didSubscribeToGroup(subscribedGroup, atIndex: indexPath.row)
            
            //Update view
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.tableView.reloadData()
        }
        action.backgroundColor = .systemGreen
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.followGroup(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
    }
}
