//
//  ViewController.swift
//  VideoBackground
//
//  Created by Adan Reséndiz on 10/07/20.
//  Copyright © 2020 Adan Reséndiz. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var videoView: UIView!
    var newLayer = AVPlayerLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        newLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    private func setupView() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "Blue", ofType: "mp4")!)
        let player = AVPlayer(url: path)
        
        newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self, selector: #selector(self.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero, completionHandler: nil)
    }
}

