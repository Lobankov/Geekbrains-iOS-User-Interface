//
//  UserTableViewCell.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

class UserTableViewCell: UITableViewCell, Reusable {

    // MARK: UI Components
    private var avatar: UIImageView!
    private var nameLabel: UILabel!
    
    // MARK: UI Sizes
    
    private let avatarWidth: CGFloat = 40
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        self.avatar = UIImageView()
        self.nameLabel = UILabel()
        
        contentView.addSubview(avatar)
        contentView.addSubview(nameLabel)
        
        setupAvatar()
        setupNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set Data
    
    func setData(_ user: UserModel){
        
        avatar.image = UIImage(named: user.avatarPath)
        nameLabel.text = user.firstName + " " + user.lastName
    }
    
    // MARK: Layout
    
    private func setupAvatar() {
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        avatar.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatar.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor)
        ])
        
        avatar.layer.cornerRadius = avatarWidth / 2
        avatar.layer.masksToBounds = true
    }
    
    private func setupNameLabel() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
}
