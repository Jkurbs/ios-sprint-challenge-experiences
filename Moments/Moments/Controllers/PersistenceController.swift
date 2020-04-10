//
//  PersistenceController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import Foundation

class PersistenceController {
    
    var experiences = [Experience]()
    
    init() {
        loadFromPersistence()
    }
    
    // Persistence file url
    var fileURL: URL? {
        let manager = FileManager.default
        guard let documentDir = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDir.appendingPathComponent("Experiences.plist")
        return fileURL
    }
    
    // Save to persistence
    func saveToPersistence() {
        guard let url = fileURL else {  return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(experiences)
            try data.write(to: url)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    // Load from persistence
    func loadFromPersistence() {
        
        let bgQueu = DispatchQueue(label: "test",attributes: .concurrent)
        bgQueu.async {
            guard let url = self.fileURL else { return }
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: url)
                print(data)
                let decodedData = try decoder.decode([Experience].self, from: data)
                self.experiences = decodedData
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }
   
}
