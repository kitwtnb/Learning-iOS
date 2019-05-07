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
import RxBlocking

@testable import Learning_iOS

class GithubRepositorySpec: QuickSpec {
    override func spec() {
        describe("GithubRepository") {
            let owner = "Owner"
            let repo = "Repo"

            var mockApi: GithubApiMock!
            var mockDao: ContributorDaoMock!
            var repository: GithubRepository!
            
            beforeEach {
                mockApi = GithubApiMock()
                mockDao = ContributorDaoMock()
                repository = GithubRepositoryImpl(api: mockApi, dao: mockDao)
            }
            
            context("no cache") {
                beforeEach {
                    mockDao.returnsFetch = Single.just([])
                    mockDao.returnsDeleteAll = Completable.empty()
                    mockDao.returnsInsertContributors = Completable.empty()
                    mockApi.returns = Single.just([])

                    _ = try! repository.getContributors(owner: owner, repo: repo).toBlocking().single()
                }
                
                it("dao's fetch method is called") {
                    expect(mockDao.callFetchCount).to(equal(1))
                }
                
                it("dao's delete method is called") {
                    expect(mockDao.callDeleteAllCount).to(equal(1))
                }
                
                it("dao's insert method is called") {
                    expect(mockDao.callInsertContributorsCount).to(equal(1))
                }
                
                it("api's get method is called") {
                    expect(mockApi.callCount).to(equal(1))
                }
            }
            
            context("has cache") {
                beforeEach {
                    let contributors = try! JSONDecoder().decode([Contributor].self, from: githubJson.data(using: .utf8)!)
                    mockDao.returnsFetch = Single.just(contributors)
                    
                    _ = try! repository.getContributors(owner: owner, repo: repo).toBlocking().single()
                }
                
                it("dao's fetch method is called") {
                    expect(mockDao.callFetchCount).to(equal(1))
                }
                
                it("api's get method is not called") {
                    expect(mockApi.callCount).to(equal(0))
                }
            }
        }
    }
}
