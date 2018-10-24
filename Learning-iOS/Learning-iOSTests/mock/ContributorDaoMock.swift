//
//  ApiClientMock.swift
//  Learning-iOSTests
//
//  Created by Keita Watanabe on 2018/10/24.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

@testable import Learning_iOS

class ContributorDaoMock: ContributorDao {
    var returnsFetch: Single<Array<Contributor>>!
    var returnsInsertContributor: Completable!
    var returnsInsertContributors: Completable!
    var returnsDeleteAll: Completable!

    private(set) var insertContributor: Contributor!
    private(set) var insertContributors: Array<Contributor>!
    private(set) var callFetchCount: Int = 0
    private(set) var callInsertContributorCount: Int = 0
    private(set) var callInsertContributorsCount: Int = 0
    private(set) var callDeleteAllCount: Int = 0

    func fetch() -> Single<Array<Contributor>> {
        callFetchCount += 1
        return returnsFetch
    }
    
    func insert(_ contributor: Contributor) -> Completable {
        insertContributor = contributor
        callInsertContributorCount += 1
        return returnsInsertContributor
    }
    
    func insert(_ contributors: Array<Contributor>) -> Completable {
        insertContributors = contributors
        callInsertContributorsCount += 1
        return returnsInsertContributors
    }
    
    func deleteAll() -> Completable {
        callDeleteAllCount += 1
        return returnsDeleteAll
    }
}
