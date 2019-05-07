//
//  GithubApi.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubApi {
    func fetchContributors(owner: String, repo: String) -> Single<Array<Contributor>>
}

struct GithubApiImpl : GithubApi {
    private static let baseUrl = "https://api.github.com"
    
    private let apiClient: ApiClient
    
    init(client: ApiClient) {
        apiClient = client
    }
    
    func fetchContributors(owner: String, repo: String) -> Single<Array<Contributor>> {
        let url = String(format: GithubApiImpl.baseUrl + "/repos/%@/%@/contributors", owner, repo)
        
        return apiClient.get(url: url, queries: nil)
            .map { try! JSONDecoder().decode([Contributor].self, from: $0) }
    }
}
