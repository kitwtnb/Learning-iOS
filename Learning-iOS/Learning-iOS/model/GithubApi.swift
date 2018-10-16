//
//  GithubApi.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

protocol GithubApi {
    func fetchContributors(owner: String, repo: String, handler: @escaping (Array<Contributor>?, AppError?) -> Void)
}

struct GithubApiImpl : GithubApi {
    private static let baseUrl = "https://api.github.com"
    
    private let apiClient: ApiClient
    
    init(client: ApiClient) {
        apiClient = client
    }
    
    func fetchContributors(owner: String, repo: String, handler: @escaping (Array<Contributor>?, AppError?) -> Void) {
        let url = String(format: GithubApiImpl.baseUrl + "/repos/%@/%@/contributors", owner, repo)
        
        apiClient.get(url: url, queries: nil) { (data, error) in
            guard let data = data else {
                handler(nil, error)
                return
            }
            
            let contributors = try! JSONDecoder().decode([Contributor].self, from: data)
            handler(contributors, nil)
        }
    }
}
