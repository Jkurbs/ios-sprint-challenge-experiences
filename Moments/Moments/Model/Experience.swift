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
    
    var imageData: Data?
    var url: URL?
    var title: String?
    var location: Location!
    
    init(imageData: Data?, url: URL?, title: String, location: Location?) {
        self.imageData = imageData
        self.url = url
        self.title = title
        self.location = location
    }
}
