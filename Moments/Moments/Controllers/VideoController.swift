//
//  VideoController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import Foundation
import AVFoundation

class VideoController: NSObject {
    
    lazy var captureSession = AVCaptureSession()
    lazy var fileOutput = AVCaptureMovieFileOutput()
    
    var session: AVCaptureSession?
    var fileUrl: URL?
    
    func setUpCaptureSession() {
        captureSession.beginConfiguration()
        // Add inputs
        let camera = bestCamera()
        
        // Video
        guard let captureInput = try? AVCaptureDeviceInput(device: camera),
            captureSession.canAddInput(captureInput) else {
                fatalError("Can't create the input form the camera")
        }
        captureSession.addInput(captureInput)
        
        if captureSession.canSetSessionPreset(.hd1920x1080) { // FUTURE: Play with 4k
            captureSession.sessionPreset = .hd1920x1080
        }
        
        // Add outputs
        
        // Recording to disk
        guard captureSession.canAddOutput(fileOutput) else {
            fatalError("Cannot record to disk")
        }
        captureSession.addOutput(fileOutput)
        
        captureSession.commitConfiguration()
    }
    
    func startCaptureSession() {
        captureSession.startRunning()
    }
    
    func stopCaptureSession() {
        captureSession.stopRunning()
    }
    
    func bestCamera() -> AVCaptureDevice {
        // All iPhones have a wide angle camera (front + back)
        if let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) {
            return ultraWideCamera
        }
        
        if let wideCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return wideCamera
        }
        
        // Future: Add a button to toggle front/back camera
        
        fatalError("No cameras on the device (or you're running this on a Simulator which isn't supported)")
    }
    
    func startRecording() {
        if fileOutput.isRecording {
            fileOutput.stopRecording()
        } else {
            let url = FileController.momentURL(folderName: "Test", pathExtension: "mov")
            self.fileUrl = url
            fileOutput.startRecording(to: url, recordingDelegate: self)
        }
    }
}

extension VideoController: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("RECORDING DID FINISH")
    }
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        // Update UI
        print("RECORDING DID START")
    }
}

