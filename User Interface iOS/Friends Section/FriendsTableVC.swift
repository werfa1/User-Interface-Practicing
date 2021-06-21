//
//  FriendsTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

//MARK: - Protocols
protocol FriendSelectionDelegate {
    func didSelectFriend (profilePic: String)
}


class FriendsTableVC: UITableViewController {
    
    //MARK: - Variables
    
    //Data source
    var friendList = [User(userName: "Ivan Ivanov", userProfilePicture: "random-dude"),
                      User(userName: "Gayl Ord", userProfilePicture: "random-dude-2"),
                      User(userName: "Joe Mama", userProfilePicture: "random-woman"),
                      User(userName: "Dagny Taghart", userProfilePicture: "random-woman-2")]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Functions
    
    // Creating custom delete swipe
    private func deleteRow(rowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Unfriend") { [weak self] (_, _, _) in
            guard let self = self else {return}
            self.friendList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
        action.backgroundColor = .purple
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.deleteRow(rowAtIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

//MARK: - Extensions

extension FriendsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as! FriendCell
        
        cell.configureCell(WithUser: friendList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 5, right: 8)
        let photoCollectionVC = PhotoCollectionVC(collectionViewLayout: layout)
        photoCollectionVC.selectedFriendProfilePic = friendList[indexPath.row].userProfilePicture
        navigationController?.pushViewController(photoCollectionVC, animated: true)
    }
}
