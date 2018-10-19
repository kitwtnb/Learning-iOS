//
//  ContributorDao.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/19.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RxSwift

protocol ContributorDao {
    func fetch() -> Single<Array<Contributor>>
    func insert(_ contributor: Contributor) -> Completable
    func insert(_ contributors: Array<Contributor>) -> Completable
    func deleteAll() -> Completable
}

struct ContributorDaoImpl : ContributorDao {
    private let database: Database<ContributorObject>
    
    init(database: Database<ContributorObject>) {
        self.database = database
    }
    
    func fetch() -> Single<Array<Contributor>> {
        return database.fetchAll()
    }
    
    func insert(_ contributor: Contributor) -> Completable {
        return database.insert(value: ContributorObject.init(from: contributor))
    }
    
    func insert(_ contributors: Array<Contributor>) -> Completable {
        return Completable.merge(contributors.map { insert($0) })
    }
    
    func deleteAll() -> Completable {
        return fetch().flatMapCompletable { contributors in
            return Completable.merge(contributors.map {
                self.database.delete(by: ContributorObject.init(from: $0).primaryKey)
            })
        }
    }
}
