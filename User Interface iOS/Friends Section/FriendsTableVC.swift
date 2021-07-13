//
//  FriendsTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit
import ViewAnimator

//MARK: - Delegate
protocol FriendSelectionDelegate {
    func didSelectFriend (profilePic: String)
}

class FriendsTableVC: UITableViewController, UISearchBarDelegate {
    
    // MARK: - UI Components -
    
    var titleLabel: UILabel!
    var searchBar: UISearchBar!
    
    //MARK: - Variables
    
    private let interactiveTransition = CustomInteractivrTransition()
    
    /// Checks if the user is started searching
    private var isSearching = false
    
    /// Checks if the view appears for the first time in the app lifetime
    private var isAppearingFirstTime = true
    
    private var allPhotos = ["random-dude", "random-dude-2", "emma", "random-woman-2", "jason", "lilly", "jack"]
    
    private var firstLettersForHeaders = [String]()
    
    //Data source
    private var friendList = [Friend(friendName: "Ivan Ivanov", friendProfilePicture: "random-dude"),
                      Friend(friendName: "Gayl Ord", friendProfilePicture: "random-dude-2"),
                      Friend(friendName: "Emma Watson", friendProfilePicture: "emma"),
                      Friend(friendName: "Dagny Taghart", friendProfilePicture: "random-woman-2"),
                      Friend(friendName: "Jason Statham", friendProfilePicture: "jason"),
                      Friend(friendName: "Lilly Collins", friendProfilePicture: "lilly"),
                      Friend(friendName: "Jack Black", friendProfilePicture: "jack")]
    
    private var sortedFriendList = [Friend]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.15
        tableView.delegate = self
        tableView.dataSource = self
        configureSearchBar()
        searchBar.delegate = self
        
        self.tableView.keyboardDismissMode = .onDrag
        
        //Sorting list of friends
        friendList = friendList.sorted { $0.friendName.localizedCaseInsensitiveCompare($1.friendName) == ComparisonResult.orderedAscending }
        sortedFriendList = friendList
        
        //Custom transitioning delegate
        navigationController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isAppearingFirstTime {
            UITableView.animate(views: tableView.visibleCells, animations: [AnimationType.from(direction: .top, offset: 100)])
            isAppearingFirstTime.toggle()
        }
    }
    
    //MARK: - Functions
    
    // Creating custom unfriend swipe
    private func deleteRow(rowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Unfriend") { [weak self] (_, _, _) in
            guard let self = self else {return}
            self.sortedFriendList.remove(at: indexPath.row)
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
    
    //MARK: - Configuring UI
    private func configureSearchBar () {
        
        titleLabel = UILabel()
        titleLabel.text = title
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.isHidden = true
        
        let screenWidth = UIScreen.main.bounds.width
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: screenWidth - 50),
        ])
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel, searchBar])
        hStack.axis = .horizontal
        
        navigationItem.titleView = hStack
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchButtonTap))
    
    }
    
    @objc
    private func handleSearchButtonTap() {
        isSearching.toggle()
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.isHidden = self.isSearching
            self.searchBar.isHidden = !self.isSearching
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortedFriendList = []
        self.tableView.reloadData()
        if searchText == "" {
            sortedFriendList = friendList
        } else {
            for friend in friendList {
                if friend.friendName.lowercased().contains(searchText.lowercased()) {
                    sortedFriendList.append(friend)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    //MARK: - TableView assistant functions
    
    private func returnNumberOfSections() -> Int {
        
        //Getting first letters of each name in friend list
        firstLettersForHeaders = []
        sortedFriendList.forEach { [weak self] item in
            guard let self = self else { return }
            guard let letter = item.friendName.first else { return }
            let firstLetter = String(letter)
            if !self.firstLettersForHeaders.contains(firstLetter) {
                self.firstLettersForHeaders.append(firstLetter)
            }
        }
        
        //Sorting letters in alphabetical order
        firstLettersForHeaders = firstLettersForHeaders.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        return self.firstLettersForHeaders.count
    }
    
    private func returnNumberOfRowsInSection (forSection section: Int) -> Int {
        var counter = 0
        for friend in sortedFriendList {
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
        
        let sortedArray = sortedFriendList.filter { friend in
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
        photoCollectionVC.pickedFriend[0] = indexPath.section
        photoCollectionVC.pickedFriend[1] = indexPath.row
        navigationController?.pushViewController(photoCollectionVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstLettersForHeaders[section]
    }
}

extension FriendsTableVC: NewProfilePicDelegate {
    func setNewProfilePic(withImage image: String, inSection section: Int, forUser user: Int) {
        
        //Getting a sorted array of friends with the same first letter in name
        let sortedArray = sortedFriendList.filter { friend in
            friend.friendName.firstLetter() == firstLettersForHeaders[section]
        }
        
        for userInTotalListOfFriends in friendList.indices {
            if sortedFriendList[userInTotalListOfFriends] == sortedArray[user] {
                sortedFriendList[userInTotalListOfFriends].friendProfilePicture = image
                break
            }
        }
        tableView.reloadData()
    }
}

extension String {
    func firstLetter () -> String {
        let firstLetter = self.prefix(1)
        return String(firstLetter)
    }
}

extension FriendsTableVC: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        default:
            return nil
        } 
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

