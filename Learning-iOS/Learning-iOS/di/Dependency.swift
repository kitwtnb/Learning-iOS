//
//  Dependency.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

struct Dependency {
    static func resolveApiClient() -> ApiClient {
        return ApiClientImpl()
    }
    
    static func resolveGithubApi() -> GithubApi {
        return GithubApiImpl(client: resolveApiClient())
    }

    static func resolveGithubRepository() -> GithubRepository {
        return GithubRepositoryImpl(api: resolveGithubApi())
    }
    
    static func resolveWebApiAccessSampleViewModel(input: WebApiAccessSampleViewModelInput) -> WebApiAccessSampleViewModel {
        return WebApiAccessSampleViewModelImpl(input: input, repository: resolveGithubRepository())
    }
}
