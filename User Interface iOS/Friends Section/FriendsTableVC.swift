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
    
    var allPhotos = ["random-dude", "random-dude-2", "random-woman", "random-woman-2", "jason", "lilly", "jack"]
    
    private var firstLettersForHeaders = [String]()
    
    //Data source
    private var friendList = [Friend(friendName: "Ivan Ivanov", friendProfilePicture: "random-dude"),
                      Friend(friendName: "Gayl Ord", friendProfilePicture: "random-dude-2"),
                      Friend(friendName: "Joe Mama", friendProfilePicture: "random-woman"),
                      Friend(friendName: "Dagny Taghart", friendProfilePicture: "random-woman-2"),
                      Friend(friendName: "Jason Statham", friendProfilePicture: "jason"),
                      Friend(friendName: "Lilly Collins", friendProfilePicture: "lilly"),
                      Friend(friendName: "Jack Black", friendProfilePicture: "jack")]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.15
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Functions
    
    // Creating custom unfriend swipe
    private func deleteRow(rowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Unfriend") { [weak self] (_, _, _) in
            guard let self = self else {return}
            self.friendList.remove(at: indexPath.row)
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
    
    private func returnNumberOfSections() -> Int {
        friendList.forEach { [weak self] item in
            guard let self = self else { return }
            guard let letter = item.friendName.first else { return }
            let firstLetter = String(letter)
            if !self.firstLettersForHeaders.contains(firstLetter) {
                self.firstLettersForHeaders.append(firstLetter)
            }
        }
        firstLettersForHeaders = firstLettersForHeaders.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        return self.firstLettersForHeaders.count
    }
    
    private func returnNumberOfRowsInSection (forSection section: Int) -> Int {
        var counter = 0
        for friend in friendList {
            if friend.friendName.firstLetter() == firstLettersForHeaders[section] {
                counter += 1
            }
        }
        return counter
    }
}

//MARK: - Extensions

extension FriendsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return returnNumberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnNumberOfRowsInSection(forSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as! FriendCell
        
        let sortedArray = friendList.filter { friend in
            friend.friendName.firstLetter() == firstLettersForHeaders[indexPath.section]
        }
        
        cell.configureCell(WithUser: sortedArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 5, right: 8)
        
        let photoCollectionVC = PhotoCollectionVC(collectionViewLayout: layout)
        photoCollectionVC.selectedFriendProfilePic = allPhotos
        photoCollectionVC.newProfilePicDelegate = self
        photoCollectionVC.pickedFriend = indexPath.row
        navigationController?.pushViewController(photoCollectionVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstLettersForHeaders[section]
    }
}

extension FriendsTableVC: NewProfilePicDelegate {
    func setNewProfilePic(withImage image: String, forUser user: Int) {
        friendList[user].friendProfilePicture = image
        tableView.reloadData()
    }
}

extension String {
    func firstLetter () -> String {
        let firstLetter = self.prefix(1)
        return String(firstLetter)
    }
}
