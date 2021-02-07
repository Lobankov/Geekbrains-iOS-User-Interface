//
//  FriendsTableVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 09.12.2020.
//

import UIKit

class FriendsTableVC: UITableViewController {
    
    // MARK: - Private fields
        
    private var friends          : [UserModel] = []
    
    /// Collections of sections that tides users and a specific letter
    /// - Note: Used for normal state
    private var sections         : [Section] = []
    
    /// Collections of sections that tides users and a specific letter
    /// - Note: Used for search state
    private var filteredSections : [Section] = []
    
    /// A flag that indicates if current app user is searching right now
    private var isSearching: Bool {
        return searchController.isActive && searchController.searchBar.text?.isEmpty == false
    }
    
    // MARK: - UI Components
    
    private let searchController = UISearchController()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let's pretend that we get this list from the some json from a network call...
        friends = makeDummyFriendsList()
        
        // sort friends by the first letter of the first name
        friends.sort(by: {
            $0.firstName < $1.firstName
        })
        
        sections = makeSections(from: friends)
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        
        // this line of code will remove all "extra" blank rows
        tableView.tableFooterView = UIView()
        
        setupSearchController()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return isSearching ? filteredSections.count : sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isSearching ? filteredSections[section].users.count : sections[section].users.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return isSearching ? String(filteredSections[section].letter) : String(sections[section].letter)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell
                
        let requiredUser = isSearching ? filteredSections[indexPath.section].users[indexPath.row] : sections[indexPath.section].users[indexPath.row]
        cell.setData(requiredUser)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let requiredUser = isSearching ? filteredSections[indexPath.section].users[indexPath.row] : sections[indexPath.section].users[indexPath.row]
        let userPhotosCollectionVC = UserPhotosCollectionVC(user: requiredUser)
        self.navigationController?.pushViewController(userPhotosCollectionVC, animated: true)
    }
    
    // MARK: - Private Helpers
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func makeSections(from users: [UserModel]) -> [Section] {
        
        // create and array of distinct lastName first letters and sort them in alphabetic order
        let allRequiredCharacters = Array(Set(users.map { $0.lastName.prefix(1) })).sorted()
        
        // create a section object for each letter and populate it with corresponding friends
        return allRequiredCharacters.map { letter in
            Section(letter: Character(String(letter)), users: users.filter { $0.lastName.hasPrefix(String(letter)) })
        }
    }
    
    // MARK: - Dummy Data Factory
    
    private func makeDummyFriendsList() -> [UserModel] {
        
        let boris       = UserModel(firstName: "Борис", lastName: "Семенов", avatarPath: "boris", photosPaths: ["boris1", "boris2", "boris3", "boris4", "boris5"])
        let anton       = UserModel(firstName: "Антон", lastName: "Григорьев", avatarPath: "anton", photosPaths: ["anton1", "anton2", "anton3", "anton4"])
        let ekaterina   = UserModel(firstName: "Екатерина", lastName: "Пархоменко", avatarPath: "ekaterina", photosPaths: ["ekaterina1", "ekaterina2", "ekaterina3", "ekaterina4"])
        let semen       = UserModel(firstName: "Семен", lastName: "Вишневский", avatarPath: "semen", photosPaths: ["semen1", "semen2", "semen3"])
        let natalia     = UserModel(firstName: "Наталья", lastName: "Комкова", avatarPath: "natalia", photosPaths: ["natalia1", "natalia2", "natalia3", "natalia4", "natalia5", "natalia6"])
        let ivan        = UserModel(firstName: "Иван", lastName: "Игоревич", avatarPath: "ivan", photosPaths: ["semen1", "semen2", "semen3", "anton4"])
        let marina      = UserModel(firstName: "Marina", lastName: "Petrova", avatarPath: "marina", photosPaths: ["natalia1", "natalia2", "natalia3", "natalia4", "natalia5", "natalia6"])
        let alvina      = UserModel(firstName: "Альвина", lastName: "Колосова", avatarPath: "alvina", photosPaths: ["ekaterina1", "ekaterina2", "ekaterina3", "ekaterina4"])
        let konstantin  = UserModel(firstName: "Константин", lastName: "Власов", avatarPath: "konstantin", photosPaths: ["semen1", "semen2", "semen3", "anton4"])
        let artem       = UserModel(firstName: "Артем", lastName: "Васильев", avatarPath: "artem", photosPaths: ["semen1", "semen2", "semen3", "anton4"])
        let vera        = UserModel(firstName: "Вера", lastName: "Булгакова", avatarPath: "vera", photosPaths: ["natalia1", "natalia2", "natalia3", "natalia4", "natalia5", "natalia6"])
        let ira         = UserModel(firstName: "Ира", lastName: "Комкова", avatarPath: "ira", photosPaths: ["natalia1", "natalia2", "natalia3", "natalia4", "natalia5", "natalia6"])
        let pasha       = UserModel(firstName: "Паша", lastName: "Горнев", avatarPath: "pasha", photosPaths: ["boris1", "boris2", "boris3", "boris4", "boris5"])
        
        return [boris, anton, ekaterina, semen, natalia, ivan, marina, alvina, konstantin, artem, vera, ira, pasha]
    }

}

// MARK: - Utility Data Types

extension FriendsTableVC {
    
    /// A helper struct that's only responsibility is to map `UITableView` section (letter in this case) and users whose last name starts with this letter
    private struct Section {
        
        let letter  : Character
        let users   : [UserModel]
    }
    
}

// MARK: - UISearchController Functionality

extension FriendsTableVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text!.lowercased()
        
        let filteredUsers = friends.filter { $0.firstName.lowercased().contains(searchText) || $0.lastName.lowercased().contains(searchText) }
        
        filteredSections = makeSections(from: filteredUsers)
        
        tableView.reloadData()
    }
    
}
