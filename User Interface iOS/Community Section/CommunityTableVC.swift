//
//  CommunityTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class CommunityTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CommunityCell.self, forCellReuseIdentifier: CommunityCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let barButton = UIButton(type: .custom)
        barButton.setTitle("Search", for: .normal)
        barButton.setTitleColor(.systemBlue, for: .normal)
        barButton.addTarget(self, action: #selector(handleBarButtonTap(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)
    }
    
    @objc
    func handleBarButtonTap (_ sender: UIBarButtonItem) {
        let globalSearchVC = GlobalSearchCommunityVC()
        navigationController?.pushViewController(globalSearchVC, animated: true)
    
    }

}

extension CommunityTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.identifier, for: indexPath) as! CommunityCell
        cell.textLabel?.text = "'sup bitch"
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
