//
//  ApiClientMock.swift
//  Learning-iOSTests
//
//  Created by Keita Watanabe on 2018/10/24.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

@testable import Learning_iOS

class GithubApiMock: GithubApi {
    var returns: Single<Array<Contributor>>!

    private(set) var owner: String!
    private(set) var repo: String!
    private(set) var callCount: Int = 0

    func fetchContributors(owner: String, repo: String) -> Single<Array<Contributor>> {
        self.owner = owner
        self.repo = repo
        callCount += 1
        
        return returns
    }
}
