//
//  Reusable.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 14.12.2020.
//

/// A simple protocol for any object with a **reuse identifier**
/// - Remark: `UITableViewCell` and `UICollectionViewCell` basically :)
protocol Reusable : class {
    
}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
