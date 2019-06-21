//
//  UserCell.swift
//  Webservice
//
//  Created by CuongVX-D1 on 6/21/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class UserCell: UITableViewCell, Reusable {

    //  MARK: - Outlet
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func setContent(for user: User) {
        avatar?.sd_setImage(with: URL(string: for user.avatar ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        guard let firstName = for user.firstName,
            let lastName = for user.lastName else {
            return
        }
        
        nameLabel.text = firstName + " " + lastName
        emailLabel.text = for user.email ?? ""
     }
}
