//
//  UserGroupsTableVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

/// A `UIViewController` that manages user groups screen
/// - Tag: UserGroupsTableVC
class UserGroupsTableVC: UITableViewController {
    
    // MARK: Private Fields
    
    private var userGroups: [GroupModel] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        userGroups = GroupFactory.makeDummyGroups()
        userGroups.removeSubrange(0...7)
        
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.reuseIdentifier)
        
        // this line of code will remove all "extra" blank rows
        tableView.tableFooterView = UIView()

        // this line of code just renames the back button from vc title to "Назад" word
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        
        // all groups bar button
        let allGroupsButton = UIBarButtonItem(title: "Ещё", style: .plain, target: self, action: #selector(handleAllGroupsButtonTap))
        self.navigationItem.rightBarButtonItem = allGroupsButton
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.reuseIdentifier, for: indexPath) as! GroupTableViewCell

        cell.setData(userGroups[indexPath.row])
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Button Handlers
    
    @objc private func handleAllGroupsButtonTap() {
     
        let allGroupsVC = GroupsTableVC()
        allGroupsVC.delegate = self
        allGroupsVC.subscribedGroups = Set<GroupModel>(userGroups)
        self.navigationController?.pushViewController(allGroupsVC, animated: true)
    }
}

extension UserGroupsTableVC: GroupsTableVCDelegate {
    
    func subscribed(to group: GroupModel) {
        userGroups.append(group)
        tableView.reloadData()
    }
    
    func unsubscribed(from group: GroupModel) {
        userGroups.removeAll(where: { $0 == group })
        tableView.reloadData()
    }
    
}

