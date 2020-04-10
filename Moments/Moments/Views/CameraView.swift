//
//  CameraView.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit
import AVFoundation


class CameraView: UIView {

    var switchCameraButton = UIButton()
    var switchAudioButton = UIButton()
    
    var audioSwith: String? {
        didSet {
            switchAudioButton.setTitle(audioSwith, for: .normal)
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPlayerView: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get { return videoPlayerView.session }
        set { videoPlayerView.session = newValue }
    }
    
    weak var delegate: TapHandlerDelegate? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switchCameraButton.setImage(UIImage(systemName: "arrow.2.ciclepath"), for: .normal)
        switchCameraButton.translatesAutoresizingMaskIntoConstraints = false
//        switchCameraButton.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
        addSubview(switchCameraButton)
        
        switchAudioButton.setTitle("Audio off", for: .normal)
        switchAudioButton.translatesAutoresizingMaskIntoConstraints = false
        switchAudioButton.addTarget(self, action: #selector(switchAudio), for: .touchUpInside)
        addSubview(switchAudioButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            switchCameraButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24.0),
            switchCameraButton.widthAnchor.constraint(equalToConstant: 40.0),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 40.0),
            switchCameraButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0),
            
            switchAudioButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24.0),
            switchAudioButton.widthAnchor.constraint(equalToConstant: 100.0),
            switchAudioButton.heightAnchor.constraint(equalToConstant: 100.0),
            switchAudioButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0),
        ])
    }
    
    @objc func switchAudio() {
        print("Tapped")
        delegate?.switchAudio()
    }
}
