//
//  ApiClient.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

protocol ApiClient {
    func get(url: String, queries: [String : String]?, response: @escaping (Data?, AppError?) -> Void)
}

struct ApiClientImpl: ApiClient {
    func get(url urlString: String, queries: [String : String]?, response: @escaping (Data?, AppError?) -> Void) {
        guard var components = URLComponents(string: urlString) else {
            response(nil, .invalidUrl)
            return
        }
        
        components.queryItems = queries?.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else {
            response(nil, .invalidQueryParameter)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            guard let data = data else {
                let err: AppError
                if let res = res {
                    err = .fail(statusCode: (res as! HTTPURLResponse).statusCode)
                } else {
                    err = .fail(description: error!.localizedDescription)
                }
                response(nil, err)
                
                return
            }
            
            response(data, nil)
        }.resume()
    }
}
