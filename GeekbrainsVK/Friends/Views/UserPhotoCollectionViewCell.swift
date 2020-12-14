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
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        
        contentView.addSubview(imageView)
        
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
    
    private func setupImageView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.fill(contentView)
    }
    
}
