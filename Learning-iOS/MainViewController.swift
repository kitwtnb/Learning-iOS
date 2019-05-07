//
//  ViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/09/30.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let database: Database<ContributorObject> = Dependency.resolveDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func unwindToTop(seque: UIStoryboardSegue) {
        // Nothing
    }
    
    @IBAction func tapClearRealmData(_ sender: Any) {
        _ = database.deleteAll().subscribe()
    }
}
