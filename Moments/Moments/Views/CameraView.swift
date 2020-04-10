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
    
    var recordButton = UIButton()
    
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
        recordButton.setTitle("RECORD", for: .normal)   
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.addTarget(self, action: #selector(recordingTapped), for: .touchUpInside)
        addSubview(recordButton)
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
            recordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0),
            recordButton.widthAnchor.constraint(equalToConstant: 100.0),
            recordButton.heightAnchor.constraint(equalToConstant: 100.0),
            recordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc func recordingTapped() {
        delegate?.recordButtonTapped()
    }
}
