//
//  ReceiveParameterSampleViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/05.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class ReceiveParameterSampleViewController: UIViewController {
    @IBOutlet weak var receiveText: UILabel!
    
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveText.text = text
    }
}
