//
//  DetailsViewController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var collectionView: UICollectionView!
    var experience: Experience?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(experience?.location.latitude ?? 0.0), \(experience?.location.longitude ?? 0.0)"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width / 3) - 10
        layout.itemSize = CGSize(width: width, height: width)
            layout.sectionInset = UIEdgeInsets(top: 25, left: 5, bottom: 50, right: 5)
            layout.minimumLineSpacing = 20
              layout.minimumInteritemSpacing = 10
              
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        /// Setup tableview datasource/delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.id)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.id)

        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if experience?.videoPath == "" {
                return 0
            }
            return 1
        } else {
            return experience?.imageData?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.id, for: indexPath) as! VideoCell
            cell.configure((experience?.videoPath)!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.id, for: indexPath) as! ImageCell
            let data = experience?.imageData?[indexPath.row]
            cell.configure(data)
            return cell
        }
    }
}
