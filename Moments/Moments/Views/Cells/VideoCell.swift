//
//  VideoCell.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit
import AVFoundation

class VideoCell: UICollectionViewCell {
        
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var path: String?
    var timeObserver: Any?

    static var id: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ videoPath: String) {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let docDir : URL = urls.first {
            let videoUrl = docDir.appendingPathComponent("\(videoPath).mov")
            print(videoUrl)
            player = AVPlayer(url:  videoUrl)
            player?.isMuted = false 
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = contentView.bounds
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            contentView.layer.addSublayer(playerLayer!)
            player?.play()
        }
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.player?.seek(to: CMTime.zero)
        self.player?.play()
    }
}
