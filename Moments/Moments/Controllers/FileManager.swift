//
//  FileManager.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import Foundation

class FileController {
    /// Creates a new file URL in the documents directory
    
    var url: URL?
    
    func momentURL(id: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(id).appendingPathExtension("mov")
        self.url = fileURL
    }
}
