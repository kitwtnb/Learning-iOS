//
//  CameraViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/10.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    @IBOutlet weak var cameraView: UIView!
    
    let output = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("do not get device")
                return
            }

            let input = try AVCaptureDeviceInput(device: device)
            
            let session = AVCaptureSession()
            session.addInput(input)
            session.addOutput(output)
            session.sessionPreset = .photo
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
            
            session.startRunning()
        } catch {
            print(error)
        }
    }
    
    @IBAction func tapCapture(_ sender: Any) {
        let settingForMonitoring = AVCapturePhotoSettings()
        settingForMonitoring.flashMode = .auto
        settingForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingForMonitoring.isHighResolutionPhotoEnabled = false

        output.capturePhoto(with: settingForMonitoring, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let imageData = photo.fileDataRepresentation()!
        let photo = UIImage(data: imageData)!
        UIImageWriteToSavedPhotosAlbum(photo, self, nil, nil)
    }
}
