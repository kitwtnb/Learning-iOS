//
//  SampleSpec.swift
//  Learning-iOSTests
//
//  Created by Keita Watanabe on 2018/10/24.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest

@testable import Learning_iOS

class WebApiAccessSampleViewModelSpec: QuickSpec {
    override func spec() {
        describe("WebApiAccessSampleViewModel") {
            var viewDidLoad: PublishRelay<Void>!
            var refresh: PublishRelay<Void>!
            var mockRepository: GithubRepositoryMock!
            var viewModel: WebApiAccessSampleViewModel!
            
            beforeEach {
                viewDidLoad = PublishRelay()
                refresh = PublishRelay()
                mockRepository = GithubRepositoryMock()
                
                let input = WebApiAccessSampleViewModelInput(
                    viewDidLoad: viewDidLoad.asDriver(onErrorDriveWith: Driver.empty()),
                    refresh: refresh.asSignal()
                )
                viewModel = WebApiAccessSampleViewModelImpl(input: input, repository: mockRepository)
            }
            
            context("on view did load") {
                var disposeBag: DisposeBag!
                var scheduler: TestScheduler!
                var contributorsObserver: TestableObserver<Array<Contributor>>!
                var finishedRefreshObserver: TestableObserver<Void>!

                beforeEach {
                    mockRepository.returns = Single.just([])
                    disposeBag = DisposeBag()
                    scheduler = TestScheduler(initialClock: 0)
                    
                    let viewDidLoadStream = scheduler.createHotObservable([ Recorded.next(0, ()) ])
                    viewDidLoadStream.bind(to: viewDidLoad).disposed(by: disposeBag)

                    contributorsObserver = scheduler.createObserver([Contributor].self)
                    viewModel.outputs.contributors.drive(contributorsObserver).disposed(by: disposeBag)
                    
                    finishedRefreshObserver = scheduler.createObserver(Void.self)
                    viewModel.outputs.finishedRefresh.emit(to: finishedRefreshObserver).disposed(by: disposeBag)

                    scheduler.start()
                }

                it("return to 1 item") {
                    expect(contributorsObserver.events.count).to(equal(1))
                }
                
                it("refresh is finish") {
                    expect(finishedRefreshObserver.events.count).to(equal(1))
                }
                
                it("repository's method is called") {
                    expect(mockRepository.callCount).to(equal(1))
                }
            }
            
            context("on refresh") {
                var disposeBag: DisposeBag!
                var scheduler: TestScheduler!
                var contributorsObserver: TestableObserver<Array<Contributor>>!
                var finishedRefreshObserver: TestableObserver<Void>!

                beforeEach {
                    mockRepository.returns = Single.just([])
                    disposeBag = DisposeBag()
                    scheduler = TestScheduler(initialClock: 0)
                    
                    let refreshStream = scheduler.createHotObservable([ Recorded.next(0, ()) ])
                    refreshStream.bind(to: refresh).disposed(by: disposeBag)
                    
                    contributorsObserver = scheduler.createObserver([Contributor].self)
                    viewModel.outputs.contributors.drive(contributorsObserver).disposed(by: disposeBag)
                    
                    finishedRefreshObserver = scheduler.createObserver(Void.self)
                    viewModel.outputs.finishedRefresh.emit(to: finishedRefreshObserver).disposed(by: disposeBag)

                    scheduler.start()
                }
                
                it("return to 1 item") {
                    expect(contributorsObserver.events.count).to(equal(1))
                }
                
                it("refresh is finish") {
                    expect(finishedRefreshObserver.events.count).to(equal(1))
                }

                it("repository's method is called") {
                    expect(mockRepository.callCount).to(equal(1))
                }
            }
            
            context("on error") {
                var disposeBag: DisposeBag!
                var scheduler: TestScheduler!
                var errorObserver: TestableObserver<Error>!
                var finishedRefreshObserver: TestableObserver<Void>!

                beforeEach {
                    mockRepository.returns = Single.error(AppError.fail(description: "fail test"))
                    disposeBag = DisposeBag()
                    scheduler = TestScheduler(initialClock: 0)
                    
                    let stream = scheduler.createHotObservable([ Recorded.next(0, ()) ])
                    stream.bind(to: viewDidLoad).disposed(by: disposeBag)
                    
                    errorObserver = scheduler.createObserver(Error.self)
                    viewModel.outputs.error.emit(to: errorObserver).disposed(by: disposeBag)
                    
                    finishedRefreshObserver = scheduler.createObserver(Void.self)
                    viewModel.outputs.finishedRefresh.emit(to: finishedRefreshObserver).disposed(by: disposeBag)

                    scheduler.start()
                }
                
                it("return to 1 item") {
                    expect(errorObserver.events.count).to(equal(1))
                }
                
                it("refresh is finish") {
                    expect(finishedRefreshObserver.events.count).to(equal(1))
                }
            }
        }
    }
}
