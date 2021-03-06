//
//  GroupTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit
import ViewAnimator

class GroupTableVC: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Variables
    
    private var groupTitleLabel = UILabel()
    private var globalGroupBarButton = UIBarButtonItem()
    private var groupSearchBar = UISearchBar()
    
    /// Checks if the user is started searching
    private var isSearching = false
    
    /// Checks if the view appears for the first time in the app lifetime
    private var isAppearingFirstTime = true
    
    /// DataSource of user's groups
    private var groupsList = [Group(groupName: "Dark Souls", groupProfilePic: "darkSouls"),
                           Group(groupName: "Fairwind", groupProfilePic: "fairWind"),
                           Group(groupName: "Hmmm", groupProfilePic: "hmmm")]
    
    /// DataSource of global list of groups
    private var globalGroupListSource = [Group(groupName: "Grand Orient", groupProfilePic: "orient"),
                                 Group(groupName: "Gothic Architecture", groupProfilePic: "gothic"),
                                 Group(groupName: "Realist Art", groupProfilePic: "realArt"),
                                 Group(groupName: "Scotlands", groupProfilePic: "scotland"),
                                 Group(groupName: "Boxing", groupProfilePic: "box"),
                                 Group(groupName: "Borderlands", groupProfilePic: "borderlands"),
                                 Group(groupName: "Academic architecture", groupProfilePic: "academic"),
                                 Group(groupName: "Christianity", groupProfilePic: "orthodox"),
                                 Group(groupName: "Orbis Europae", groupProfilePic: "orbis"),
                                 Group(groupName: "MacOS features", groupProfilePic: "macOS")
    ]
    
    private var sortedGroupList: [Group]!
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        tableView.rowHeight = UIScreen.main.bounds.height * 0.15
        sortedGroupList = groupsList
        
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.leftBarButtonItem = configureGlobalGroupButton()
        configureSearchBar()
        groupSearchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isAppearingFirstTime {
            UITableView.animate(views: tableView.visibleCells, animations: [AnimationType.from(direction: .top, offset: 100)])
            isAppearingFirstTime.toggle()
        }
    }
    
    //MARK: - Functions
    
    private func configureGlobalGroupButton () -> UIBarButtonItem{
        let barButton = UIButton(type: .custom)
        barButton.setTitle("Global", for: .normal)
        barButton.setTitleColor(.systemBlue, for: .normal)
        barButton.addTarget(self, action: #selector(handleBarButtonTap(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: barButton)
    }
    
    private func configureSearchBar () {
        
        groupTitleLabel             = UILabel()
        groupTitleLabel.text        = title
        
        groupSearchBar              = UISearchBar()
        groupSearchBar.placeholder  = "Search"
        groupSearchBar.isHidden     = true
        
        let screenWidth             = UIScreen.main.bounds.width
        
        groupSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupSearchBar.widthAnchor.constraint(equalToConstant: screenWidth - 50),
        ])
        
        let hStack                  = UIStackView(arrangedSubviews: [groupTitleLabel, groupSearchBar])
        hStack.axis                 = .horizontal
        
        navigationItem.titleView    = hStack
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchButtonTap))
    
    }
    
    //Opens a VC with all the groups
    @objc
    func handleBarButtonTap (_ sender: UIBarButtonItem) {
        let globalSearchVC = GlobalSearchGroupVC()
        globalSearchVC.globalGroupList  = globalGroupListSource
        globalSearchVC.subcribeDelegate = self
        navigationController?.pushViewController(globalSearchVC, animated: true)
    }
    
    //Hides or shows the search bar whether user is searrching or not
    @objc
    private func handleSearchButtonTap() {
        isSearching.toggle()
        UIView.animate(withDuration: 0.3) {
            self.groupTitleLabel.isHidden           = self.isSearching
            self.groupSearchBar.isHidden            = !self.isSearching
            self.navigationItem.leftBarButtonItem   = self.isSearching ? nil : self.configureGlobalGroupButton()
        }
    }
    
    //Refreshes the list of groups while searching
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortedGroupList = []
        self.tableView.reloadData()
        if searchText == "" {
            sortedGroupList = groupsList
        } else {
            for group in groupsList {
                if group.groupName.lowercased().contains(searchText.lowercased()) {
                    sortedGroupList.append(group)
                }
            }
        }
        self.tableView.reloadData()
    }
}

    //MARK: - Extensions

extension GroupTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        
        cell.configureCell(WithGroup: sortedGroupList[indexPath.row])
        
        return cell
    }
    
    // Creating custom "unfriend" swipe
    private func deleteRow(rowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Unfollow") { [weak self] (_, _, _) in
            guard let self = self else {return}
            
            let unsubscribedGroup = self.sortedGroupList.remove(at: indexPath.row)
            self.globalGroupListSource.append(unsubscribedGroup)
            self.groupsList.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
        action.backgroundColor = .systemIndigo
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete  = self.deleteRow(rowAtIndexPath: indexPath)
        let swipe   = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GroupTableVC: SubscriptionDelegate {
    func didSubscribeToGroup(_ group: Group, atIndex: Int) {
        groupsList.append(group)
        sortedGroupList.append(group)
        globalGroupListSource.remove(at: atIndex)
        tableView.reloadData()
    }
}
