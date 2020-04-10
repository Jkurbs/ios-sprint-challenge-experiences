//
//  MediaView.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit

class MediaView: UIView {
    
    var cameraView = CameraView()
    var recordButton = UIButton()
    
    weak var delegate: TapHandlerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cameraView)
        
        translatesAutoresizingMaskIntoConstraints = false
        recordButton.setTitle("RECORD", for: .normal)
        recordButton.setTitleColor(.darkGray, for: .normal)
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
        recordButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(recordingPressed(_:))))
        addSubview(recordButton)
        cameraView.switchAudioButton.addTarget(self, action: #selector(switchAudioOn), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func switchAudioOn() {
        delegate?.switchAudio()
    }
    
    @objc private func takePhotoTapped() {
        delegate?.takePhotoTapped()
    }
    
    @objc private func recordingPressed(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .recognized, .began:
            delegate?.recordingPressed()
        default:
            break
            delegate?.recordingStopped()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            cameraView.topAnchor.constraint(equalTo: topAnchor),
            cameraView.widthAnchor.constraint(equalTo: widthAnchor),
            cameraView.heightAnchor.constraint(equalToConstant: frame.height/2),
            
            recordButton.topAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: 80.0),
            recordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            recordButton.widthAnchor.constraint(equalToConstant: 100.0),
            recordButton.heightAnchor.constraint(equalToConstant: 100.0),
        ])
    }
}
