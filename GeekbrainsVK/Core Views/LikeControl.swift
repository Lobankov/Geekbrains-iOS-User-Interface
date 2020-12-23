//
//  LikeControl.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 23.12.2020.
//

import UIKit

final class LikeControl: UIControl {
    
    // MARK: UI Components
    
    private var iconView: UIImageView!
    
    private var valueLabel: UILabel!
    
    private let filledImage = UIImage(systemName: "heart.fill")!
    private let emptyImage = UIImage(systemName: "heart")!
    
    // MARK: UI Sizes
    
    private let iconWidth: CGFloat = 20
    
    // MARK: Properties
    
    private(set) var likesNumber: UInt = 0
    
    var likeIsPressed: Bool = false
    
    // MARK: Initialization
    
    init(with likesNumber: UInt) {
        
        super.init(frame: .zero)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        iconView = UIImageView()
        valueLabel = UILabel()
        
        addSubview(iconView)
        addSubview(valueLabel)
        
        setupIcons()
        setupValueLabel()
        
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: Internal Functions
    
    internal func setLikes(_ number: UInt) {
        self.likesNumber = number
        updateLikeNumbers()
    }
    
    // MARK: Private Functions
    
    @objc
    private func handleTouchDown() {
        
        let filledImage = self.filledImage
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6,
                       options: .allowUserInteraction) { [weak self] in
            self?.iconView.image = filledImage
            self?.iconView.tintColor = AppColors.darkRed
            self?.iconView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    @objc
    private func handleTouchUpInside() {
        
        likeIsPressed.toggle()
        
        let color = likeIsPressed ? UIColor.red : UIColor.lightGray
        let icon = likeIsPressed ? filledImage : emptyImage
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6,
                       options: .allowUserInteraction) { [weak self] in
            self?.iconView.image = icon
            self?.iconView.tintColor = color
            self?.valueLabel.textColor = color
            self?.iconView.transform = CGAffineTransform.identity
        }
        
        
        if likeIsPressed {
            likesNumber -= 1
        } else {
            likesNumber += 1
        }
        
        updateLikeNumbers()
    }
    
    
    private func updateLikeNumbers(animated: Bool = true) {
        
        let likesString = likesNumber > 0 ? "\(likesNumber)" : String()
        
        if animated {
            
            UIView.transition(with: valueLabel,
                              duration: 0.2,
                              options: .transitionFlipFromTop) { [weak self] in
                self?.valueLabel.text = "\(likesString)"
            }
        } else {
            valueLabel.text = "\(likesString)"
        }
    }
    
    // MARK: Layout
    
    private func setupIcons() {
        
        iconView.image = emptyImage
        iconView.tintColor = .lightGray
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: self.iconWidth),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupValueLabel() {
        
        valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        valueLabel.textColor = .lightGray
        
        valueLabel.text = likesNumber > 0 ? "\(likesNumber)" : String()
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5)
        ])
    }
}
