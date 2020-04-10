//
//  AddFileViewController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit
import AVFoundation

class AddExperienceViewController: UIViewController {
    
    private var player: AVPlayer!
    
    let mediaView = MediaView()
    var videoController = VideoController()
    var persistenceController: PersistenceController?
    var locationController: LocationController?
    var currentCount: Int?
    
    var collectionView: UICollectionView!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        videoController.setUpCaptureSession()
        videoController.videoId = "\(currentCount ?? 1)"
        setupViews()
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoController.startCaptureSession()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("imageAdded"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoController.stopCaptureSession()
    }
    
    
    
    // MARK: - Functions
    func setupViews() {
        self.title = "Capture Experience"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        mediaView.delegate = self
        mediaView.cameraView.videoPlayerView.videoGravity = .resizeAspectFill
        mediaView.cameraView.session = videoController.captureSession
        view.addSubview(mediaView)
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width / 3) - 10
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 25, left: 5, bottom: 50, right: 5)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        /// Setup tableview datasource/delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.id)
        
        view.addSubview(collectionView)
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mediaView.heightAnchor.constraint(equalToConstant: view.frame.height),
            mediaView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 200.0),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func save() {
        let imageData = videoController.imageData
        let experience = Experience(imageData: imageData,  videoPath: "\(currentCount!)", title: "", location: Location(latitude: locationController?.location?.latitude, longitude: locationController?.location?.longitude))
        persistenceController?.experiences.append(experience)
        persistenceController?.saveToPersistence()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func reloadCollectionView() {
        self.collectionView.reloadData()
        let lastSection = self.collectionView.numberOfSections-1
        let lastRow = self.collectionView.numberOfItems(inSection: lastSection)
        let indexPath = IndexPath(row: lastRow-1, section: lastSection)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension AddExperienceViewController: TapHandlerDelegate {
    
    func recordingPressed() {
        videoController.startRecording()
    }
    
    func recordingStopped() {
        videoController.stopRecording()
    }
    
    
    func audioOn() {
        mediaView.cameraView.audioSwith = "Audio on"
        videoController.addAudio()
    }
    
    func audioOff() {
        mediaView.cameraView.audioSwith = "Audio off"
        videoController.removeAudio()
    }
    
    
    func takePhotoTapped() {
        videoController.captureImage()
    }
    
    func switchCamera() {
        // TODO
    }
}

extension AddExperienceViewController: UICollectionViewDelegate,  UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoController.imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.id, for: indexPath) as! ImageCell
        let imageData = videoController.imageData[indexPath.row]
        cell.configure(imageData)
        return cell
    }
}

extension UICollectionView {
    func scrollToLast() {
        guard numberOfSections > 0 else {
            return
        }

        let lastSection = numberOfSections - 1

        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }

        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}
