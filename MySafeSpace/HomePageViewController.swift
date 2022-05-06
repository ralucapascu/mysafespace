//
//  HomePageViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/24/22.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var helloUserLabel: UILabel!
    @IBOutlet weak var breathingExerciseView: UIControl!
    @IBOutlet weak var musicPlayerView: UIControl!
    @IBOutlet weak var horoscopesView: UIControl!
	@IBOutlet weak var sentimentAnalyserView: UIControl!
	
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloUserLabel.text = "Hello, " + currentUser.firstName + "!"
        
        breathingExerciseView.layer.cornerRadius = 30
        musicPlayerView.layer.cornerRadius = 30
        horoscopesView.layer.cornerRadius = 30
		sentimentAnalyserView.layer.cornerRadius = 30
    }
    
    @IBAction func didTapBreathingExercise(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "breathingExerciseVC") as! BreathingExcerciseViewController
		viewController.title = "Breathing exercise"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
	
    @IBAction func didTapMusicPlayerView(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "musicPlayerVC") as! MusicPlayerViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
	
    @IBAction func didTapHoroscopesView(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "horoscopesVC") as! HoroscopesViewController
        viewController.title = "Today's horoscope"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
	
	@IBAction func didTapSentimentAnalyserView(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "sentimentAnalyserVC") as! SentimentAnalyserViewController
		viewController.title = "Sentiment analyser"
		viewController.user = currentUser
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}
