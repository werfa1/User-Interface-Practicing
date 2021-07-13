//
//  PhotosCollectionVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit
import Gemini
import ViewAnimator


protocol NewProfilePicDelegate: AnyObject {
    func setNewProfilePic (withImage image: String, inSection section: Int, forUser userIndex: Int)
}

class PhotoCollectionVC: UICollectionViewController {
    
    
    //MARK: - Variables
    
    var selectedFriendProfilePic = [String]()
    
    //private var photoCollectionView: GeminiCollectionView?
    
    weak var newProfilePicDelegate: NewProfilePicDelegate?
    
    /// Variable that holds picked friend's section and row 
    var pickedFriend = [-1, -1]

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView!.register(PhotoCell.nib(), forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        //Gemini animation
        (collectionView as! GeminiCollectionView).gemini
                .scaleAnimation()
                .scale(0.75)
                .scaleEffect(.scaleUp)
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
        
        (collectionView as! GeminiCollectionView).animateCell(cell)
        
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        (collectionView as! GeminiCollectionView).animateVisibleCells()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PhotoCell {
            (collectionView as! GeminiCollectionView).animateCell(cell)
        }
    }
}

extension PhotoCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.size.width
        let cellHeight = view.safeAreaLayoutGuide.layoutFrame.height * 0.9
        return CGSize(width: cellWidth, height: cellHeight)
    }
}



extension PhotoCollectionVC: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return CustomPushAnimator()
        case .pop:
            return CustomPopAnimator()
        default:
            return nil
        }
    }
}
