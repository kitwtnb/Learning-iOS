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
}

struct WebApiAccessSampleViewModelOutput {
    let contributors: Driver<Array<Contributor>?>
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
    private let errorRelay = PublishRelay<Error>()
    let outputs: WebApiAccessSampleViewModelOutput
    
    required init(input: WebApiAccessSampleViewModelInput, repository: GithubRepository) {
        self.repository = repository
        outputs = WebApiAccessSampleViewModelOutput(
            contributors: contributorsRelay.asDriver(),
            error: errorRelay.asSignal()
        )
        
        input.viewDidLoad.subscribe({ [weak self] _ in
            guard let self = self else { return }

            self.repository.getContributors(owner: "DroidKaigi", repo: "conference-app-2018")
                .subscribe(onSuccess: { [weak self] contributors in
                    self?.contributorsRelay.accept(contributors)
                }, onError: { [weak self] error in
                    self?.errorRelay.accept(error)
                }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
