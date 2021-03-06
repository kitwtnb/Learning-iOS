//
//  CameraRollSampleCollectionViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/14.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

class CameraRollSampleCollectionViewController: UICollectionViewController {
    var photoAssets: Array = [PHAsset]()
    var giveAsset: PHAsset!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            guard let self = self else { return }
            
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects({ [weak self] (asset, index, stop) in
                    guard let self = self else { return }
                    
                    self.photoAssets.append(asset)
                })
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CameraRollSampleCollectionViewCell
        cell.setImage(photoAssets[indexPath.row])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        giveAsset = photoAssets[indexPath.row]
        
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ImageViewController
        viewController.asset = giveAsset
    }
}
