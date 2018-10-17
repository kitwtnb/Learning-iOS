//
//  ImageViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var asset: PHAsset!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = PHImageManager()
        manager.requestImage(for: asset,
                             targetSize: view.frame.size,
                             contentMode: .aspectFit,
                             options: nil,
                             resultHandler: { [weak self] (image, info) in
                                guard let self = self, let image = image else { return }
                                self.imageView.image = image
        })
    }
}
