//
//  Database.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/19.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class Database<T : Object & Compatible & Uniquable> {
    private var realm: Realm {
        return Dependency.resolveRealm()
    }
    
    func fetchAll() -> Single<Array<T.Value>> {
        return Single.create(subscribe: { [weak self] single in
            if let records: Array<T.Value> = self?.realm.objects(T.self).map({ $0.to() }) {
                single(.success(records))
            }

            return Disposables.create()
        })
    }
    
    func insert(value: T) -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            do {
                try self?.realm.write {
                    self?.realm.add(value)
                }
                completable(.completed)
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create()
        })
    }
    
    func deleteAll() -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            do {
                try self?.realm.write {
                    self?.realm.deleteAll()
                }
                completable(.completed)
            } catch {
                completable(.error(error))
            }

            return Disposables.create()
        })
    }
    
    func delete(by primaryKey: String) -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            let target = self?.realm.objects(T.self).filter({ primaryKey == $0.primaryKey}).first
            
            do {
                try self?.realm.write {
                    self?.realm.delete(target!)
                }
                completable(.completed)
            } catch {
                completable(.error(error))
            }

            return Disposables.create()
        })
    }
}
