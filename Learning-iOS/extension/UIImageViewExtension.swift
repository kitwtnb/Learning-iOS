//
//  UIImageViewExtension.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/16.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(url: String) {
        DispatchQueue.global().async {
            do {
                let data = try NSData(contentsOf: URL(string: url)!, options: .dataReadingMapped)
                let image = UIImage(data: data as Data)

                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print(error)
            }
        }
    }
}
