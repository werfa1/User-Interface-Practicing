//
//  PhotosCollectionVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class PhotoCollectionVC: UICollectionViewController {
    //MARK: - Variables
    
    var selectedFriendProfilePic: String = "random-dude"
    
    private var photoCollectionView: UICollectionView!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView!.register(PhotoCell.nib(), forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .systemTeal
    }
}

//MARK: - Extension

extension PhotoCollectionVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        cell.configure(with: UIImage(named: selectedFriendProfilePic)!)
        
        return cell
    }
}

extension PhotoCollectionVC: FriendSelectionDelegate {
    func didSelectFriend(profilePic: String) {
        self.selectedFriendProfilePic = profilePic
    }
}
