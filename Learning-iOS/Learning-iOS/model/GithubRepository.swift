//
//  GithubRepository.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubRepository {
    func getContributors(owner: String, repo: String) -> Single<Array<Contributor>>
}

struct GithubRepositoryImpl : GithubRepository{
    private let api: GithubApi
    
    init(api: GithubApi) {
        self.api = api
    }
    
    func getContributors(owner: String, repo: String) -> Single<Array<Contributor>> {
        return api.fetchContributors(owner: owner, repo: repo)
    }
}
