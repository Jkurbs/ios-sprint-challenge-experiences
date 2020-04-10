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
    
    let mediaView = MediaView()
    var videoController = VideoController()
    var persistenceController: PersistenceController?
    var locationController: LocationController?
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        mediaView.delegate = self
        mediaView.cameraView.videoPlayerView.videoGravity = .resizeAspectFill
        mediaView.cameraView.session = videoController.captureSession
        view.addSubview(mediaView)
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mediaView.heightAnchor.constraint(equalToConstant: view.frame.height),
            mediaView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc func save() {
        let imageData = videoController.imageData
        let videoUrl = videoController.videoUrl
        let experience = Experience(imageData: imageData,  url: videoUrl, title: "", location: Location(latitude: locationController?.location?.latitude, longitude: locationController?.location?.longitude))
        persistenceController?.experiences.append(experience)
        persistenceController?.saveToPersistence()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddVideoViewController: TapHandlerDelegate {
    
    func recordingPressed() {
        videoController.startRecording()
    }
    
    func recordingStopped() {
        videoController.stopRecording()
    }
    
    func takePhotoTapped() {

        videoController.captureImage()
    }
    
    func switchAudio() {
        if videoController.hasAudio == true {
            mediaView.cameraView.audioSwith = "Audio off"
        } else {
             mediaView.cameraView.audioSwith = "Audio on"
        }
    }
    
    func switchCamera() {
        
    }
}
