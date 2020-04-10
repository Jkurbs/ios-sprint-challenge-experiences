//
//  AddFileViewController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit
import AVFoundation

class AddVideoViewController: UIViewController {

    private var player: AVPlayer!
    
    let cameraView = CameraView()
    var videoController = VideoController()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        videoController.setUpCaptureSession()
        setupViews()
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoController.startCaptureSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoController.stopCaptureSession()
    }
    
    
    // MARK: - Functions
    func setupViews() {
        view.backgroundColor = .white
        cameraView.backgroundColor = .red
        cameraView.delegate = self
        cameraView.videoPlayerView.videoGravity = .resizeAspectFill
        cameraView.session = videoController.captureSession
        view.addSubview(cameraView)
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            cameraView.heightAnchor.constraint(equalTo: view.heightAnchor),
            cameraView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

extension AddVideoViewController: TapHandlerDelegate {
    
    func recordButtonTapped() {
        videoController.startRecording()
    }
}
