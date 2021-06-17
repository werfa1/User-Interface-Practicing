//
//  TabBarController.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.viewControllers?.append(loginVC)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
