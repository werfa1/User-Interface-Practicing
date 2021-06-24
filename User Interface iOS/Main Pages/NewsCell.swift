//
//  NewsCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 24.06.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    //MARK: - Variables
    
    static let identifier = "NewsCell"
    
    private var newsImageView = UIImageView()
    
    var likeButton = UIButton()
    
    //Checks if the like button is tapped
    private var isLiked = false
    
    private var likeCountLabel = UILabel()
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        
        configureBottomPart()
        
        configureLikeButton()
        configureLikeCountLabel()
        
        isUserInteractionEnabled = true
        
        self.clipsToBounds = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configureImageView () {
        self.addSubview(newsImageView)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -50)
        ])
    }
    
    private func configureLikeButton () {
        likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        likeButton.clipsToBounds = true
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 50),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
    }
    
    private func configureLikeCountLabel () {
        likeCountLabel.text = ""
        likeCountLabel.numberOfLines = 0
        
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            likeCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeCountLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
    }
    
    private func configureBottomPart () {
        
        likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        likeButton.clipsToBounds = true
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        likeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeButtonPressedThroughGesture)))
        
        likeCountLabel.text = "0 like"
        likeCountLabel.numberOfLines = 0
        
        let hStack = UIStackView(arrangedSubviews: [likeButton, likeCountLabel])
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.isUserInteractionEnabled = true
                
        self.addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
            hStack.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
        
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
        if isLiked {
            sender.setImage(UIImage(named: "fullHeart"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
        
        likeCountLabel.text = isLiked ? "1 like": "0 like"
    }
    
    @objc private func likeButtonPressedThroughGesture (_ sender: UITapGestureRecognizer) {
        isLiked.toggle()
        guard let likeButton = sender.view as? UIButton else { return }
        if isLiked {
            likeButton.setImage(UIImage(named: "fullHeart"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
        
        likeCountLabel.text = isLiked ? "1 like": "0 like"
    }
    
    func configure(with image: UIImage) {
        newsImageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
