//
//  NavigationWithParameterSampleViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/05.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class NavigationWithParameterSampleViewController: UIViewController {
    @IBOutlet weak var text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // call by touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // hide keyboard
        view.endEditing(true)
    }
    
    // before call by scene changes
    // return value is...
    // true  -> change scene
    // false -> not change scene
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return text.text != nil && !text.text!.isEmpty
    }
    
    // before call by scene changes
    // example, set value next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ReceiveParameterSampleViewController
        viewController.text = text.text!
    }
    
    // call by touch button
    @IBAction func pushButton(_ sender: Any) {
        // hide keyboard
        view.endEditing(true)
    }
}
