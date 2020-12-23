//
//  UserPhotoCollectionViewCell.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 14.12.2020.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: UI Components
    
    private var imageView: UIImageView!
    
    private var likeControl: LikeControl!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        likeControl = LikeControl()
        
        contentView.addSubview(likeControl)
        contentView.addSubview(imageView)
        
        setupLikeControl()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Data Set
    
    func setData(_ image: UIImage?) {
        self.imageView.image = image
    }
    
    // MARK: Layout
    
    private func setupLikeControl() {
        
        likeControl.setLikes(UInt.random(in: 0..<150)) 
        
        likeControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            likeControl.widthAnchor.constraint(equalToConstant: 100),
            likeControl.heightAnchor.constraint(equalToConstant: 30),
            likeControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: likeControl.topAnchor, constant: -5)
        ])
    }
}
