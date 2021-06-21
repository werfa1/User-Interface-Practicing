//
//  GroupTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class GroupTableVC: UITableViewController {
    
    //MARK: - Variables
    
    var groupsList = [Group(groupName: "Weeb shit", groupProfilePic: "darkSouls"),
                           Group(groupName: "FairWind", groupProfilePic: "fairWind"),
                           Group(groupName: "Hmmm", groupProfilePic: "hmmm")]
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let barButton = UIButton(type: .custom)
        barButton.setTitle("Search", for: .normal)
        barButton.setTitleColor(.systemBlue, for: .normal)
        barButton.addTarget(self, action: #selector(handleBarButtonTap(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)
    }
    
    //MARK: - Functions
    
    @objc
    func handleBarButtonTap (_ sender: UIBarButtonItem) {
        let globalSearchVC = GlobalSearchGroupVC()
        navigationController?.pushViewController(globalSearchVC, animated: true)
    }
    
    // Creating custom unfriend swipe
    private func deleteRow(rowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Unfollow") { [weak self] (_, _, _) in
            guard let self = self else {return}
            self.groupsList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
        action.backgroundColor = .systemIndigo
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.deleteRow(rowAtIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

    //MARK: - Extensions

extension GroupTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        
        cell.configureCell(WithGroup: groupsList[indexPath.row])
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
