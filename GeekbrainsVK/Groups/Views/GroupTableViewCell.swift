//
//  GroupTableViewCell.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

class GroupTableViewCell: UITableViewCell, Reusable {
    
    // MARK: Private Fields
    private var isSubscribed: Bool = false

    // MARK: UI Components
    private var avatar: UIImageView!
    private var nameLabel: UILabel!
    private var iconView: UIImageView!
    
    // MARK: UI Sizes
    
    private let avatarWidth: CGFloat = 40
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
     
        self.avatar = UIImageView()
        self.nameLabel = UILabel()
        self.iconView = UIImageView()
        
        contentView.addSubview(avatar)
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconView)
        
        setupAvatar()
        setupNameLabel()
        setupIconView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setData(_ group: GroupModel, showSubscriptionIcon: Bool = false){
        
        avatar.image = UIImage(named: group.imagePath)
        nameLabel.text = group.name
        
        if showSubscriptionIcon {
            iconView.alpha = 1
        }
    }
    
    func toggleSubscription() {
        
        isSubscribed.toggle()
        
        iconView.image = isSubscribed ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "plus.square")
        iconView.tintColor = isSubscribed ? AppColors.gray : AppColors.blue
    }
    
    func updateSubscribed() {
        
        iconView.image = UIImage(systemName: "checkmark.square")
        iconView.tintColor = AppColors.gray
    }
    
    func updateUnsubscribed() {
        iconView.image = UIImage(systemName: "plus.square")
        iconView.tintColor = AppColors.blue
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
    
    private func setupIconView() {
        
        iconView.alpha = 0
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        iconView.image = UIImage(systemName: "plus.square")?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = AppColors.blue
        
        NSLayoutConstraint.activate([
            iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            iconView.widthAnchor.constraint(equalToConstant: 25),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
