//
//  MusicPlayerViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/29/22.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    
    @IBOutlet weak var timeSlider: UISlider!
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = Bundle.main.path(forResource: "music_meditation", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            player.play()

        } catch {
            print(error)
        }
    }
    
    @IBAction func didTapPlayPauseButton(_ sender: Any) {
    }
}
