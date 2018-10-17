//
//  WebApiAccessSampleTableViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

class WebApiAccessSampleTableViewController: UITableViewController {
    private let repository: GithubRepository = Dependency.resolveGithubRepository()
    
    private var contributors = Array<Contributor>()
    private var selectedContributor: Contributor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        showContributors()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WebApiAccessSampleTableViewCell
        cell.set(contributor: contributors[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedContributor = contributors[indexPath.row]
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! WebViewController
        viewController.url = selectedContributor.reposUrl
    }
    
    @objc private func onRefresh(sender: UIRefreshControl) {
        showContributors()
        
        refreshControl!.endRefreshing()
    }
    
    private func showContributors() {
        repository.getContributors(owner: "DroidKaigi", repo: "conference-app-2018") { [weak self] (contributors, error) in
            guard let self = self else { return }
            
            guard let contributors = contributors else {
                print(error!)
                return
            }
            
            self.contributors = contributors
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
