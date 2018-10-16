//
//  WebApiAccessSampleTableViewCell.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class WebApiAccessSampleTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func set(contributor: Contributor) {
        icon.setImage(url: contributor.avatarUrl)
        name.text = contributor.login
    }
}
