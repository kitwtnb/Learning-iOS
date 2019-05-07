//
//  ViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/09/30.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let presenter = MainPresenter()
    private let database: Database<ContributorObject> = Dependency.resolveDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.segues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.segues[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: presenter.segues[indexPath.row], sender: nil)
    }
}
