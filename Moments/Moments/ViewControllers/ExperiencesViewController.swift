//
//  MomentsViewController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit

class ExperiencesViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var persistenceController = PersistenceController()
    var locationController = LocationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Experiences"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddMomentVC))
        
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
        
        collectionView.register(ExperienceCell.self, forCellWithReuseIdentifier: ExperienceCell.id)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        locationController.requestLocation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
    @objc func showAddMomentVC() {
        let vc = AddExperienceViewController()
        vc.currentCount =  persistenceController.experiences.count
        vc.persistenceController = self.persistenceController
        vc.locationController = self.locationController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        navigationController?.present(nav, animated: true, completion: nil)
    }
}


extension ExperiencesViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persistenceController.experiences.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExperienceCell.id, for: indexPath) as? ExperienceCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.experience = persistenceController.experiences[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
