//
//  PhotosCollectionVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit


protocol NewProfilePicDelegate: AnyObject {
    func setNewProfilePic (withImage image: String, forUser userIndex: Int)
}

class PhotoCollectionVC: UICollectionViewController {
    //MARK: - Variables
    
    var selectedFriendProfilePic = [String]()
    
    private var photoCollectionView: UICollectionView!
    
    weak var newProfilePicDelegate: NewProfilePicDelegate?
    
    var pickedFriend = -1

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PhotoCell.nib(), forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .systemTeal
    }
    
    //MARK: - Functions
    
    
}

//MARK: - Extension

extension PhotoCollectionVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedFriendProfilePic.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        cell.contentView.contentMode = .scaleAspectFill
        cell.configure(with: UIImage(named: selectedFriendProfilePic[indexPath.row])!)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newProfilePicDelegate?.setNewProfilePic(withImage: selectedFriendProfilePic[indexPath.row], forUser: pickedFriend)
    }
}

extension PhotoCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.size.width * 0.8
        let cellHeight = cellWidth / 0.75
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
