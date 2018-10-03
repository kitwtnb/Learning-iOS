//
//  CounterSampleViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/03.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class CounterSampleViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = ""
    }
    
    @IBAction func countUp(_ sender: Any) {
        counter += 1
        label.text = "\(counter)"
    }
}
