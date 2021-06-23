//
//  PhotoCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 21.06.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifier = "PhotoCell"
    
    
    private var imageView = UIImageView()
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size = self.frame.size
        
        addSubview(imageView)
        backgroundColor = .white
        contentView.layer.borderWidth = 1
    }
    
    //MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Sets imageView to take the whole cell's space
        imageView.frame = contentView.bounds
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
