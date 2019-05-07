//
//  ApiClient.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiClient {
    func get(url: String, queries: [String : String]?) -> Single<Data>
}

struct ApiClientImpl: ApiClient {
    func get(url urlString: String, queries: [String : String]?) -> Single<Data> {
        return Single.create(subscribe: { single in
            let disposable = Disposables.create()
            
            guard var components = URLComponents(string: urlString) else {
                single(.error(AppError.invalidUrl))
                return disposable
            }

            components.queryItems = queries?.map { URLQueryItem(name: $0, value: $1) }
            guard let url = components.url else {
                single(.error(AppError.invalidQueryParameter))
                return disposable
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                guard let data = data else {
                    let err: AppError
                    if let res = res {
                        err = .fail(statusCode: (res as! HTTPURLResponse).statusCode)
                    } else {
                        err = .fail(description: error!.localizedDescription)
                    }
                    single(.error(err))
                    
                    return
                }
                
                single(.success(data))
            }
            task.resume()

            return Disposables.create { task.cancel() }
        })
    }
}
