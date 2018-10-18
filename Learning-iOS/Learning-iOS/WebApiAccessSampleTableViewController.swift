//
//  WebApiAccessSampleTableViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WebApiAccessSampleTableViewController: UITableViewController {
    private let viewDidLoadRelay = PublishRelay<Void>()
    
    private var viewModel: WebApiAccessSampleViewModel!
    private let repository: GithubRepository = Dependency.resolveGithubRepository()
    private let disposeBag = DisposeBag()
    
    private var contributors = Array<Contributor>()
    private var selectedContributor: Contributor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = Dependency.resolveWebApiAccessSampleViewModel(input: WebApiAccessSampleViewModelInput(
            viewDidLoad: viewDidLoadRelay.asObservable()
        ))
        viewModel.outputs.contributors.drive(onNext: { [weak self] contributors in
            self?.contributors = contributors ?? []
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        viewModel.outputs.error
            .emit(onNext: { print($0) })
            .disposed(by: disposeBag)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        viewDidLoadRelay.accept(())
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
        viewController.url = selectedContributor.htmlUrl
    }
    
    @objc private func onRefresh(sender: UIRefreshControl) {
        showContributors()
        
        refreshControl!.endRefreshing()
    }
    
    private func showContributors() {
        repository.getContributors(owner: "DroidKaigi", repo: "conference-app-2018")
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] contributors in
                self?.contributors = contributors
                self?.tableView.reloadData()
            }, onError: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}
