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
        self.viewControllers = [createFriedsNC(), createCommunityNC()]
        UITabBar.appearance().tintColor = .systemPurple
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "person.circle")
        items[1].image = UIImage(systemName: "person.3.fill")
    }
    
    //MARK: - Functions
    
    /// Creates a navigation controller with a FriendTableView
    private func createFriedsNC() -> UINavigationController {
        let friendsTableVC = FriendsTableVC()
        //friendsTableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
//        friendsTableVC.tabBarItem = UITabBarItem(
//        friendsTableVC.tabBarItem.titl
        
        friendsTableVC.title = "Friends"
        //friendsTableVC.tabBarItem.image = UIImage(named: "person.2.fill")
        
        return UINavigationController(rootViewController: friendsTableVC)
    }
    
    /// Creates a navigation controller with a CommunityTableView
    private func createCommunityNC() -> UINavigationController {
        let communityTableVC = CommunityTableVC()
        communityTableVC.title = "Communities"
        //communityTableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        return UINavigationController(rootViewController: communityTableVC)
    }
}
