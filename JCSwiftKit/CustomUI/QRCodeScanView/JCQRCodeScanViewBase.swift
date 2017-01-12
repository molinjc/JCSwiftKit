//
//  JCQRCodeScanViewBase.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/12.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit
import AVFoundation
class JCQRCodeScanViewBase: UIView, AVCaptureMetadataOutputObjectsDelegate {

    private let session = AVCaptureSession.init();
    private let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo);
    var deviceError: (() -> Void)?;
    var QRCodeContext: ((_ context: String) -> Void)?;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setApplicationNotification();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setApplicationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(_applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(_applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil);
    }
    
    func startScan() {
        let input = try? AVCaptureDeviceInput.init(device: device);
        if (input != nil) {
            if self.deviceError != nil {
                self.deviceError!();
            }
        }else {
            let output = AVCaptureMetadataOutput.init();
            output.rectOfInterest = CGRect.init(x: 0.1, y: 0, width: 0.9, height: 1);
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main);
            session.sessionPreset = AVCaptureSessionPresetHigh;
            session.addInput(input);
            session.addOutput(output);
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
            let layer = AVCaptureVideoPreviewLayer.init(session: session);
            layer?.videoGravity = AVLayerVideoGravityResizeAspectFill;
            layer?.frame = self.layer.bounds;
            self.layer.insertSublayer(layer!, at: 0);
            session.startRunning();
        }
    }
    
    func stopScan() {
        self.session.stopRunning();
    }
    
    /// 关闭手电筒🔦
    func torchOff() {
        try? device?.lockForConfiguration();
        device?.torchMode = AVCaptureTorchMode.off;
        device?.unlockForConfiguration();
    }
    
    /// 打开手电筒🔦
    func torchOn() {
        try? device?.lockForConfiguration();
        device?.torchMode = AVCaptureTorchMode.on;
        device?.unlockForConfiguration();
    }
    
    /// AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            session.stopRunning();
            let obj: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject;
            /// 回调？？？
            if self.QRCodeContext != nil {
                self.QRCodeContext!(obj.stringValue);
            }
        }
    }
    
    func _applicationWillEnterForeground() {
        session.startRunning();
    }
    
    func _applicationDidEnterBackground() {
        session.stopRunning();
    }
}
