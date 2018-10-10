//
//  CameraViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/10.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController/* , AVCapturePhotoCaptureDelegate */ {
    @IBOutlet weak var cameraView: UIView!

    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        stillImageOutput = AVCapturePhotoOutput()

        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080

        let device = AVCaptureDevice.default(for: AVMediaType.video)

        do {
            guard let device = device else { return }
            let input = try AVCaptureDeviceInput(device: device)
            if !captureSession.canAddInput(input) {
                return
            }
            captureSession.addInput(input)

            if !captureSession.canAddOutput(stillImageOutput) {
                return
            }
            captureSession.addOutput(stillImageOutput)

            captureSession.startRunning()

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait

            cameraView.layer.addSublayer(previewLayer)

            previewLayer.position = CGPoint(x: cameraView.frame.width / 2, y: cameraView.frame.height / 2)
            previewLayer.bounds = cameraView.frame
        } catch {
            print(error)
        }
    }
    
    @IBAction func tapCapture(_ sender: Any) {
    }
}
