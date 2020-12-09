//
//  FriendsTableVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

class FriendsTableVC: UITableViewController {
    
    // MARK: Private fields
    
    private var friends: [UserModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        friends = makeDummyFriendsList()
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        
        // this line of code will remove all "extra" blank rows
        tableView.tableFooterView = UIView()

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
        
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell
        
        cell.setData(friends[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userPhotosCollectionVC = UserPhotosCollectionVC(user: friends[indexPath.row])
        self.navigationController?.pushViewController(userPhotosCollectionVC, animated: true)
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
    
    // MARK: Dummy Data Helpers
    
    private func makeDummyFriendsList() -> [UserModel] {
        
        let boris = UserModel(firstName: "Борис", lastName: "Семенов", avatarPath: "boris")
        let anton = UserModel(firstName: "Антон", lastName: "Григорьев", avatarPath: "anton")
        let ekaterina = UserModel(firstName: "Екатерина", lastName: "Пархоменко", avatarPath: "ekaterina")
        let semen = UserModel(firstName: "Семен", lastName: "Вишневский", avatarPath: "semen")
        let natalia = UserModel(firstName: "Наталья", lastName: "Комкова", avatarPath: "natalia")
        
        return [boris, anton, ekaterina, semen, natalia]
    }

}
