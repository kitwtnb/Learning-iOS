//
//  Dependency.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RealmSwift

struct Dependency {
    static func resolveRealm() -> Realm {
        return try! Realm()
    }
    
    static func resolveDatabase<T>() -> Database<T> {
        return Database<T>()
    }
    
    static func resolveContributorDao() -> ContributorDao {
        return ContributorDaoImpl(database: resolveDatabase())
    }
    
    static func resolveApiClient() -> ApiClient {
        return ApiClientImpl()
    }
    
    static func resolveGithubApi() -> GithubApi {
        return GithubApiImpl(client: resolveApiClient())
    }

    static func resolveGithubRepository() -> GithubRepository {
        return GithubRepositoryImpl(api: resolveGithubApi(), dao: resolveContributorDao())
    }
    
    static func resolveWebApiAccessSampleViewModel(input: WebApiAccessSampleViewModelInput) -> WebApiAccessSampleViewModel {
        return WebApiAccessSampleViewModelImpl(input: input, repository: resolveGithubRepository())
    }
}
