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
    
    //Delegate
    var selectionDelegate: FriendSelectionDelegate = PhotoCollectionVC()
    
    //Data source
    var friendList = [User(userName: "Ivan Ivanov", userProfilePicture: "random-dude"),
                      User(userName: "Gayl Ord", userProfilePicture: "random-dude-2"),
                      User(userName: "Joe Mama", userProfilePicture: "random-woman")]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectionDelegate.didSelectFriend(profilePic: friendList[indexPath.row].userProfilePicture)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 5, right: 8)
        let photoCollectionVC = PhotoCollectionVC(collectionViewLayout: layout)
        navigationController?.pushViewController(photoCollectionVC, animated: true)
    }
}
