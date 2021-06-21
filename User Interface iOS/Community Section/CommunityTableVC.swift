//
//  CommunityTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class CommunityTableVC: UITableViewController {
    
    //MARK: - Variables
    
    var communitiesList = [Group(groupName: "Weeb shit", groupProfilePic: "group1"),
                           Group(groupName: "FairWind", groupProfilePic: "group2"),
                           Group(groupName: "Hmmm", groupProfilePic: "group3")]
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CommunityCell.self, forCellReuseIdentifier: CommunityCell.identifier)
        tableView.rowHeight = 120
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
        let globalSearchVC = GlobalSearchCommunityVC()
        navigationController?.pushViewController(globalSearchVC, animated: true)
    }
}

    //MARK: - Extensions

extension CommunityTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communitiesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.identifier, for: indexPath) as! CommunityCell
        
        cell.configureCell(WithGroup: communitiesList[indexPath.row])
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
