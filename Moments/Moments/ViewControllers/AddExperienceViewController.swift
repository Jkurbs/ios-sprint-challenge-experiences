//
//  AddFileViewController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit
import AVFoundation

class AddExperienceViewController: UIViewController {

    private var player: AVPlayer!
    
    let mediaView = MediaView()
    var videoController = VideoController()
    var persistenceController: PersistenceController?
    var locationController: LocationController?
    var currentCount: Int? 
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        videoController.setUpCaptureSession()
        videoController.videoId = "\(currentCount ?? 1)"
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
        self.title = "Capture Experience"
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
        let experience = Experience(imageData: imageData,  videoPath: "\(currentCount!)", title: "", location: Location(latitude: locationController?.location?.latitude, longitude: locationController?.location?.longitude))
        persistenceController?.experiences.append(experience)
        persistenceController?.saveToPersistence()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddExperienceViewController: TapHandlerDelegate {
    
    func recordingPressed() {
        videoController.startRecording()
    }
    
    func recordingStopped() {
        videoController.stopRecording()
    }
    
    
    func audioOn() {
        mediaView.cameraView.audioSwith = "Audio on"
        videoController.addAudio()
    }
    
    func audioOff() {
        mediaView.cameraView.audioSwith = "Audio off"
        videoController.removeAudio()
    }

    
    func takePhotoTapped() {
        videoController.captureImage()
    }
    
    func switchCamera() {
        // TODO
    }
}
