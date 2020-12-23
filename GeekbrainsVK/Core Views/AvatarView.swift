//
//  AvatarView.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 23.12.2020.
//

import UIKit

@IBDesignable
final class AvatarView: UIView {
    
    // MARK: UI Components
    
    private var shadowView: UIView!
    
    private var imageView: UIImageView!
    
    // MARK: Properties
    
    @IBInspectable
    var shadowColor: UIColor = .black {
        didSet {
            shadowView.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0.55 {
        didSet {
            shadowView.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 5 {
        didSet {
            shadowView.layer.shadowRadius = shadowRadius
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK: Initialization
    
    init(with image: UIImage?) {
        
        self.image = image
        
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
        
        self.shadowView = UIView()
        self.imageView = UIImageView()
        
        self.addSubview(shadowView)
        self.addSubview(imageView)
        
        setupShadowView()
        setupImageView()
        updateCornerRadius()
    }
    
    // MARK: Base Class Functionality
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    // MARK: Layout
    
    private func setupShadowView() {
        
        shadowView.layer.masksToBounds = false
        shadowView.backgroundColor = .white
        
        shadowView.layer.shadowColor = self.shadowColor.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = self.shadowRadius
        shadowView.layer.shadowOpacity = self.shadowOpacity
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        shadowView.fill(self)
    }
    
    private func setupImageView() {
        
        imageView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = AppColors.blue.cgColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.fill(self)
    }
    
    // MARK: Layout Helpers
    
    private func updateCornerRadius() {
        
        let selfWidth = self.bounds.size.width
        let selfHeight = self.bounds.size.height
        
        imageView.layer.cornerRadius = selfWidth > selfHeight ? selfHeight / 2 : selfWidth / 2
        shadowView.layer.cornerRadius = selfWidth > selfHeight ? selfHeight / 2 : selfWidth / 2
    }
}
