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
    var detailsLabel = UILabel()
    
    weak var delegate: TapHandlerDelegate?
    
    var audioState: Bool? = true
    
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
        
        detailsLabel.text = "Tap for a picture or long press to capture video."
        detailsLabel.font = UIFont.systemFont(ofSize: 14)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func switchAudioOn() {
        if audioState == true {
            audioState = false
            delegate?.audioOff()
        } else {
            audioState = true
            delegate?.audioOn()
        }
    }
    
    @objc private func takePhotoTapped() {
        delegate?.takePhotoTapped()
    }
    
    @objc private func recordingPressed(_ gesture: UILongPressGestureRecognizer) {
        gesture.numberOfTouchesRequired = 1
        switch gesture.state {
        case .began, .recognized:
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
            
            detailsLabel.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 8.0),
            detailsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
