//
//  PhotosCollectionVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit
import Gemini


protocol NewProfilePicDelegate: AnyObject {
    func setNewProfilePic (withImage image: String, inSection section: Int, forUser userIndex: Int)
}

class PhotoCollectionVC: UICollectionViewController {
    //MARK: - Variables
    
    var selectedFriendProfilePic = [String]()
    
    private var photoCollectionView: GeminiCollectionView!
    
    weak var newProfilePicDelegate: NewProfilePicDelegate?
    
    /// Variable that holds picked friend's section and row 
    var pickedFriend = [-1, -1]

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PhotoCell.nib(), forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
    }
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
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.layer.borderWidth = 3
        selectedCell?.layer.borderColor = UIColor.green.cgColor
        selectedCell?.layer.cornerRadius = 10
        newProfilePicDelegate?.setNewProfilePic(withImage: selectedFriendProfilePic[indexPath.row], inSection: pickedFriend[0], forUser: pickedFriend[1])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            selectedCell?.layer.borderWidth = 0
            selectedCell?.layer.borderColor = UIColor.clear.cgColor
            selectedCell?.layer.cornerRadius = 0
        }
    }
}

extension PhotoCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.size.width
        let cellHeight = view.safeAreaLayoutGuide.layoutFrame.height * 0.9 //- view.safeAreaInsets.bottom 
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
