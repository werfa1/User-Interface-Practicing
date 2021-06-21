//
//  GlobalSearchGroupVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 18.06.2021.
//

import UIKit

class GlobalSearchGroupVC: UITableViewController {
    
    //MARK: - Variables
    
    var globalGroupList = [Group(groupName: "Grand Orient", groupProfilePic: "orient"),
                           Group(groupName: "Gothic Architecture", groupProfilePic: "gothic"),
                           Group(groupName: "Realist Art", groupProfilePic: "realArt"),
                           Group(groupName: "Scotlands", groupProfilePic: "scotland"),
                           Group(groupName: "Boxing", groupProfilePic: "box"),
                           Group(groupName: "Borderlands", groupProfilePic: "borderlands"),
                           Group(groupName: "Academic architecture", groupProfilePic: "academic")
    ]
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
