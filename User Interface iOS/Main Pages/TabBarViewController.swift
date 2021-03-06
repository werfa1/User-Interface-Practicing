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
        self.viewControllers            = [createNewsNC(), createFriedsNC(), createGroupNC(), createPersonalPageNC()]
        UITabBar.appearance().tintColor = .systemPurple
        
        guard let items = tabBar.items else { return }
        
        items[0].image  = UIImage(systemName: "books.vertical")
        items[1].image  = UIImage(systemName: "person.circle")
        items[2].image  = UIImage(systemName: "person.3.fill")
        items[3].image  = UIImage(systemName: "person.fill")
    }
    
    //MARK: - Functions
    
    /// Creates a navigation controller with a FriendTableView
    private func createFriedsNC() -> UINavigationController {
        let friendsTableVC      = FriendsTableVC()
        friendsTableVC.title    = "Friends"
        return UINavigationController(rootViewController: friendsTableVC)
    }
    
    /// Creates a navigation controller with a GroupTableVC
    private func createGroupNC() -> UINavigationController {
        let groupTableVC        = GroupTableVC()
        groupTableVC.title      = "Groups"
        return UINavigationController(rootViewController: groupTableVC)
    }
    
    /// Creates a navigation controller with a PersonalPageVC
    private func createPersonalPageNC() -> UINavigationController {
        let personalPageVC      = PersonalPageVC()
        personalPageVC.title    = "Profile"
        return UINavigationController(rootViewController: personalPageVC)
    }
    
    /// Creates a navigation controller with a NewsTableVC
    private func createNewsNC () -> UINavigationController {
        let newsVC              = NewsTableVC()
        newsVC.title            = "News"
        return UINavigationController(rootViewController: newsVC)
    }
}
