//
//  GroupsTableVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

/// A `UIViewController` that manages all groups screen
/// - Tag: GroupsTableVC
class GroupsTableVC: UITableViewController {
    
    // MARK: Private Fields
    private var allGroups: [GroupModel] = []
    
    // MARK: Internal Properties
    weak var delegate: GroupsTableVCDelegate?    
    var subscribedGroups: Set<GroupModel> = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allGroups = GroupFactory.makeDummyGroups()
        self.title = "Все сообщества"        
        
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.reuseIdentifier)
        
        // this line of code will remove all "extra" blank rows
        tableView.tableFooterView = UIView()
        
        tableView.allowsMultipleSelection = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.reuseIdentifier, for: indexPath) as! GroupTableViewCell
        cell.isUserInteractionEnabled = true

        let group = allGroups[indexPath.row]
        
        cell.setData(group, showSubscriptionIcon: true)
        
        subscribedGroups.contains(group) ? cell.updateSubscribed() : cell.updateUnsubscribed()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupToSelect = allGroups[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as? GroupTableViewCell
        
        if subscribedGroups.contains(groupToSelect) {
            subscribedGroups.remove(groupToSelect)
            delegate?.unsubscribed(from: groupToSelect)
            cell?.updateUnsubscribed()
        } else {
            subscribedGroups.insert(groupToSelect)
            delegate?.subscribed(to: groupToSelect)
            cell?.updateSubscribed()
        }
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

}

// MARK: Delegate Protocol

/// A delegate protocol that's function is to connect [all groups VC](x-source-tag://GroupsTableVC) and his *parent* [user groups VC](x-source-tag://UserGroupsTableVC)
protocol GroupsTableVCDelegate: UITableViewController {
    
    func subscribed(to group: GroupModel)
    
    func unsubscribed(from group: GroupModel)
    
}
