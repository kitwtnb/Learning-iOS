//
//  GithubRepository.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

protocol GithubRepository {
    func getContributors(owner: String, repo: String, _ handler: @escaping (Array<Contributor>?, AppError?) -> Void)
}

struct GithubRepositoryImpl : GithubRepository{
    private let api: GithubApi
    
    init(api: GithubApi) {
        self.api = api
    }
    
    func getContributors(owner: String, repo: String, _ handler: @escaping (Array<Contributor>?, AppError?) -> Void) {
        api.fetchContributors(owner: owner, repo: repo, handler: handler)
    }
}
