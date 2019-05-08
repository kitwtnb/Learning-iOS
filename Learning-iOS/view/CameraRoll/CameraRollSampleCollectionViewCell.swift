//
//  CameraRollSampleCollectionViewCell.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/14.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import Photos

class CameraRollSampleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(_ asset: PHAsset) {
        let manager = PHImageManager()
        manager.requestImage(for: asset,
                             targetSize: frame.size,
                             contentMode: .aspectFill,
                             options: nil,
                             resultHandler: { [weak self] (image, info) in
                                guard let self = self, let image = image else { return }
                                self.imageView.image = image
        })
    }
}
