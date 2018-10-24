//
//  SampleSpec.swift
//  Learning-iOSTests
//
//  Created by Keita Watanabe on 2018/10/22.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking

@testable import Learning_iOS

class GithubApiSpec: QuickSpec {
    override func spec() {
        describe("GithubApi") {
            var mock: ApiClientMock!
            var githubApi: GithubApi!
            
            beforeEach {
                mock = ApiClientMock()
                mock.returnsData = githubJson.data(using: .utf8)
                
                githubApi = GithubApiImpl(client: mock)
            }
            
            context("call fetchContributors") {
                let owner = "Owner"
                let repo = "Repo"
                var contributors: Array<Contributor>!
                
                beforeEach {
                    contributors = try! githubApi.fetchContributors(owner: owner, repo: repo).toBlocking().single()
                }
                
                it("get method is called") {
                    expect(mock.callCount).to(equal(1))
                }
                
                it("url is correct") {
                    expect(mock.url).to(equal("https://api.github.com/repos/\(owner)/\(repo)/contributors"))
                }
                
                it("queries is correct") {
                    expect(mock.queries).to(equal(nil))
                }
                
                it("count is correct") {
                    expect(contributors.count).to(equal(2))
                }
            }
        }
    }
}
