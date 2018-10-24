//
//  ApiClientMock.swift
//  Learning-iOSTests
//
//  Created by Keita Watanabe on 2018/10/22.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

@testable import Learning_iOS

class ApiClientMock: ApiClient {
    var returnsData: Data!
    
    private(set) var url: String!
    private(set) var queries: [String:String]?
    private(set) var callCount: Int = 0
    
    func get(url: String, queries: [String : String]?) -> Single<Data> {
        self.url = url
        self.queries = queries
        callCount += 1
        
        return Single.just(returnsData)
    }
}
