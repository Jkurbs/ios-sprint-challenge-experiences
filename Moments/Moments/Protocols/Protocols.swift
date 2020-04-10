//
//  Protocols.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import Foundation

protocol TapHandlerDelegate: NSObjectProtocol {
    func recordingPressed()
    func recordingStopped()
    func takePhotoTapped()
    func audioOn()
    func audioOff()
    func switchCamera()
}
