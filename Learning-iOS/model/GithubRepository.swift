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
    private let dao: ContributorDao
    
    init(api: GithubApi, dao: ContributorDao) {
        self.api = api
        self.dao = dao
    }
    
    func getContributors(owner: String, repo: String) -> Single<Array<Contributor>> {
        return dao.fetch()
            .flatMap({ contributors in
                let single: Single<Array<Contributor>>
                if !contributors.isEmpty {
                    single = Single.just(contributors)
                } else {
                    single = self.donwloadAndSaveContributors(owner: owner, repo: repo)
                }
                
                return single
            })
    }
    
    private func donwloadAndSaveContributors(owner: String, repo: String) -> Single<Array<Contributor>> {
        return api.fetchContributors(owner: owner, repo: repo)
            .do(onSuccess: { contributors in
                _ = self.dao.deleteAll().andThen(self.dao.insert(contributors)).subscribe()
            })
    }
}
