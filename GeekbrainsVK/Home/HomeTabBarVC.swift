//
//  HomeTabBarVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

class HomeTabBarVC: UITabBarController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        self.tabBar.tintColor = AppColors.blue
        
        viewControllers = [makeFriendsViewControllers(), makeGroupsViewControllers()]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NetworkManager.shared.getFriends(count: 10)
        NetworkManager.shared.getPhotos()
        NetworkManager.shared.getGroups(count: 5, userID: Session.shared.userId)
        NetworkManager.shared.searchGroups(with: "Картошка")
    }
    
    // MARK: - Factory Methods
    
    private func makeFriendsViewControllers() -> UIViewController {
        
        let friendsTableVC = FriendsTableVC()
        friendsTableVC.title = "Друзья"
        
        let friendsNavigationVC = UINavigationController(rootViewController: friendsTableVC)
        
        friendsNavigationVC.tabBarItem = UITabBarItem(title: "Друзья", image: UIImage(systemName: "person.2")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), selectedImage: UIImage(systemName: "person.2.fill")?.withTintColor(AppColors.blue).withRenderingMode(.alwaysOriginal))
        
        
        return friendsNavigationVC
    }
    
    
    private func makeGroupsViewControllers() -> UIViewController {
        
        let userGroupsTableVC = UserGroupsTableVC()
        userGroupsTableVC.title = "Сообщества"
        
        let groupsNavigationVC = UINavigationController(rootViewController: userGroupsTableVC)
        
        groupsNavigationVC.tabBarItem = UITabBarItem(title: "Сообщества", image: UIImage(systemName: "person.3")?.withTintColor(.lightGray).withRenderingMode(.alwaysOriginal), selectedImage: UIImage(systemName: "person.3.fill")?.withTintColor(AppColors.blue).withRenderingMode(.alwaysOriginal))
        
        return groupsNavigationVC
    }
}
