//
//  DataCell.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = contentView.frame
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true 
        contentView.addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ imageData: Data?) {
        if let imageData = imageData  {
            imageView.image = UIImage(data: imageData)
        }
    }
}
