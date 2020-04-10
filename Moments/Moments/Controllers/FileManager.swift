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
    static func momentURL(folderName: String, pathExtension: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        let fileName = formatter.string(from: Date())
        
        let dataPath = documentsDirectory.appendingPathComponent(folderName)
        
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.relativePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
        return dataPath.appendingPathComponent(fileName).appendingPathExtension(pathExtension)
    }
}
