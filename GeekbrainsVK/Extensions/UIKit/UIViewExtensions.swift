//
//  UIViewExtensions.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 14.12.2020.
//

import UIKit

extension UIView {
    
    /// Anchors view to a passed super view
    /// - Parameters:
    ///   - superView: parent view that we want to be attached to
    ///   - insets: padding from super view (Default is none)
    ///   - respectSafeArea: if true, safe area will be taken into consideration
    /// - Note: do not forget to set translatesAutoresizingMaskIntoConstraints to false before calling this method
    func fill(_ superView: UIView, _ insets: UIEdgeInsets = .zero, _ respectSafeArea: Bool = false) {
                        
        if respectSafeArea {
            let guide = superView.safeAreaLayoutGuide
            self.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: insets.left).isActive        = true
            self.topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top).isActive                 = true
            self.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: insets.right).isActive     = true
            self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: insets.bottom).isActive        = true
        } else {
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left).isActive    = true
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top).isActive             = true
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: insets.right).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: insets.bottom).isActive    = true
        }
    }
    
}
