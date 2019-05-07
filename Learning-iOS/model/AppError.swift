//
//  File.swift
//  Learning-iOS
//
//  Created by 渡辺 恵太 on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

enum AppError : Error {
    case invalidUrl
    case invalidQueryParameter
    case fail(statusCode: Int)
    case fail(description: String)
}
