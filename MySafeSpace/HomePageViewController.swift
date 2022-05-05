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
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloUserLabel.text = "Hello, " + currentUser.firstName + "!"
        
        breathingExerciseView.layer.cornerRadius = 30
        musicPlayerView.layer.cornerRadius = 30
        horoscopesView.layer.cornerRadius = 30
    }
    
    @IBAction func didTapStartExerciseButton(_ sender: Any) {
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "breathingExerciseVC") as! BreathingExcerciseViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapBreathingExercise(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "breathingExerciseVC") as! BreathingExcerciseViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func didTapMusicPlayerView(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "musicPlayerVC") as! MusicPlayerViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func didTapMusicPlayerButton(_ sender: Any) {
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "musicPlayerVC") as! MusicPlayerViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func didTapHoroscopesView(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "horoscopesVC") as! HoroscopesViewController
        viewController.title = "Today's horoscope"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
