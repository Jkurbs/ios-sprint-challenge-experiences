//
//  Image.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit
import Foundation

struct Experience: Codable {
    
    var imageData: [Data]?
    var videoPath: String?
    var title: String?
    var location: Location!
    
    init(imageData: [Data]?, videoPath: String?, title: String, location: Location?) {
        self.imageData = imageData
        self.videoPath = videoPath
        self.title = title
        self.location = location
    }
}
