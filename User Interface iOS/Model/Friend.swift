//
//  User.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 18.06.2021.
//

import Foundation

struct Friend {
    
    //MARK: - Variables
    
    var friendName: String
    
    //Passing the name of the image in Assets
    var friendProfilePicture: String
    
}

extension Friend: Equatable {
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        if (lhs.friendName == rhs.friendName) && (lhs.friendProfilePicture == rhs.friendProfilePicture) {
            return true
        } else {
            return false
        }
    }
}
