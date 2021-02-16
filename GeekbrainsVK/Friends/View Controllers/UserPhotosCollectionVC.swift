//
//  UserPhotosCollectionVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

class UserPhotosCollectionVC: UICollectionViewController {
    
    // MARK: Private Fields
    private var user: UserModel?
    
    // MARK: UI Sizes
    
    private let spacing: CGFloat = 5
    
    // MARK: Initialization
    
    convenience init(user: UserModel) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.init(collectionViewLayout: layout)
        
        self.user = user
        self.title = "\(user.firstName) - Фото"
        self.collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UserPhotoCollectionViewCell.self, forCellWithReuseIdentifier: UserPhotoCollectionViewCell.reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photosPaths.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! UserPhotoCollectionViewCell
    
        cell.setData(UIImage(named: (user?.photosPaths[indexPath.item]) ?? "deb"))
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension UserPhotosCollectionVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - spacing / 2, height: collectionView.frame.width / 2 - spacing / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
