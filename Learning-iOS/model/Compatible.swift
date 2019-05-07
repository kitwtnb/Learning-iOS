//
//  BaseObject.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/19.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

protocol Compatible {
    associatedtype Value
    
    init(from: Value)
    func to() -> Value
}
