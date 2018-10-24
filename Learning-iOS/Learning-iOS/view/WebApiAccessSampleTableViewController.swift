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
    // for event relay
    private let viewDidLoadRelay = BehaviorRelay<Void>(value: ())
    
    private var viewModel: WebApiAccessSampleViewModel!
    private let repository: GithubRepository = Dependency.resolveGithubRepository()
    private let disposeBag = DisposeBag()
    
    private var contributors = Array<Contributor>()
    private var selectedContributor: Contributor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl

        viewModel = Dependency.resolveWebApiAccessSampleViewModel(input: WebApiAccessSampleViewModelInput(
            viewDidLoad: viewDidLoadRelay.asDriver(),
            refresh: tableView.refreshControl!.rx.controlEvent(.valueChanged).asSignal()
        ))
        
        // event handling
        viewModel.outputs.contributors.drive(onNext: { [weak self] contributors in
            self?.contributors = contributors ?? []
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.outputs.finishedRefresh.emit(onNext: { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
        
        viewModel.outputs.error.emit(onNext: {
            print($0)
        }).disposed(by: disposeBag)
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
}
