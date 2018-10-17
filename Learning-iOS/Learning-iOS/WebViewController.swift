//
//  WebViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/17.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var url: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: url) else {
            print(self.url)
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}
