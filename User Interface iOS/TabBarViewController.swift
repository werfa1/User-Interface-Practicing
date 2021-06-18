//
//  TabBarController.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UITabBar.appearance().tintColor = .systemPurple
        self.viewControllers = [createFriedsNC(), createCommunityNC()]
    }
    
    //MARK: - Functions
    
    /// Creates a navigation controller with a FriendTableView
    private func createFriedsNC() -> UINavigationController {
        let friendsTableVC = FriendsTableVC()
        friendsTableVC.title = "Friends"
        friendsTableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        return UINavigationController(rootViewController: friendsTableVC)
    }
    
    /// Creates a navigation controller with a CommunityTableView
    private func createCommunityNC() -> UINavigationController {
        let communityTableVC = CommunityTableVC()
        communityTableVC.title = "Communities"
        communityTableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        
        return UINavigationController(rootViewController: communityTableVC)
    }
}
