//
//  UserTableViewController.swift
//  Webservice
//
//  Created by CuongVX-D1 on 6/20/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit
import Reusable
import Then

final class UserTableViewController: UITableViewController {
    
    //  MARK: - Data
    var arrayUser = [User]()
    
    //  MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTableView()
        getDataUser()
    }
    
    private func setupTableView() {
        self.tableView.do {
            $0.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    //  MARK: - Networking
    func getDataUser() {
        guard let url = URL(string: URLs.users) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil { return }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let data = json?["data"] as? [[String : Any]]
                    
                    for dict in data! {
                        let avatar = dict["avatar"] as? String ?? ""
                        let email = dict["email"] as? String ?? ""
                        let firstName = dict["first_name"] as? String ?? ""
                        let lastName = dict["last_name"] as? String ?? ""
                        self.arrayUser.append(User(avatar: avatar, email: email, firstName: firstName, lastName: lastName))
                    }
                    
                    DispatchQueue.main.async
                        {
                            self.tableView.reloadData()
                    }
                } catch {
                    self.handleServerError(errorMessage: error.localizedDescription)
                }
            }
            }.resume()
    }
    
    private func handleServerError(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UserTableViewController {
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserCell = tableView.dequeueReusableCell(for: indexPath)
        let currentUser = arrayUser[indexPath.row]
        cell.setContent(for user: currentUser)
        return cell
    }
}
