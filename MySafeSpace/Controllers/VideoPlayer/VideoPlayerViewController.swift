//
//  MusicPlayerViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/29/22.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: AVPlayerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		let player = AVPlayer(url : URL(fileURLWithPath: Bundle.main.path(forResource: "howToRelax", ofType: "mp4")!))
		self.player = player
    }
}
