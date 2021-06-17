//
//  PhotoCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let identifier = "PhotoCell"
    
    //MARK: - Outlets
    @IBOutlet var imageView: UIImageView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        backgroundColor = .clear
        contentView.layer.borderWidth = 1
    }
    
    //MARK: - Functions
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
