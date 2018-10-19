//
//  WebApiAccessSampleViewModel.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/18.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct WebApiAccessSampleViewModelInput {
    let viewDidLoad: Observable<Void>
    let refresh: Observable<Void>
}

struct WebApiAccessSampleViewModelOutput {
    let contributors: Driver<Array<Contributor>?>
    let finishedRefresh: Signal<Void>
    let error: Signal<Error>
}

protocol WebApiAccessSampleViewModel {
    var outputs: WebApiAccessSampleViewModelOutput { get }
    
    init(input: WebApiAccessSampleViewModelInput, repository: GithubRepository)
}

class WebApiAccessSampleViewModelImpl : WebApiAccessSampleViewModel {
    let disposeBag = DisposeBag()
    let repository: GithubRepository
    
    private let contributorsRelay = BehaviorRelay<Array<Contributor>?>(value: nil)
    private let finishedRefreshRelay = PublishRelay<Void>()
    private let errorRelay = PublishRelay<Error>()
    let outputs: WebApiAccessSampleViewModelOutput
    
    required init(input: WebApiAccessSampleViewModelInput, repository: GithubRepository) {
        self.repository = repository
        outputs = WebApiAccessSampleViewModelOutput(
            contributors: contributorsRelay.asDriver(),
            finishedRefresh: finishedRefreshRelay.asSignal(),
            error: errorRelay.asSignal()
        )
        
        Observable.merge(input.viewDidLoad, input.refresh)
            .subscribe({ [weak self] _ in
                self?.loadContributors()
            }).disposed(by: disposeBag)
    }
    
    private func loadContributors() {
        repository.getContributors(owner: "DroidKaigi", repo: "conference-app-2018")
            .subscribe(onSuccess: { [weak self] contributors in
                self?.contributorsRelay.accept(contributors)
                self?.finishedRefreshRelay.accept(())
            }, onError: { [weak self] error in
                self?.errorRelay.accept(error)
                self?.finishedRefreshRelay.accept(())
            }).disposed(by: self.disposeBag)
    }
}