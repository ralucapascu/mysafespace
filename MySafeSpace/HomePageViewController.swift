//
//  HomePageViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/24/22.
//

import UIKit
import UserNotifications
import RealmSwift

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var helloUserLabel: UILabel!
    @IBOutlet weak var breathingExerciseView: UIControl!
    @IBOutlet weak var videoPlayerView: UIControl!
    @IBOutlet weak var horoscopesView: UIControl!
	@IBOutlet weak var sentimentAnalyserView: UIControl!
	@IBOutlet weak var websiteView: UIControl!
	
    var currentUser: User!
	
	let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloUserLabel.text = "Hello, " + currentUser.firstName + "!"
        
        breathingExerciseView.layer.cornerRadius = 30
		videoPlayerView.layer.cornerRadius = 30
        horoscopesView.layer.cornerRadius = 30
		sentimentAnalyserView.layer.cornerRadius = 30
		websiteView.layer.cornerRadius = 30
		
		notificationCenter.getNotificationSettings(completionHandler: {
			settings in
			if settings.authorizationStatus == .authorized {
				DispatchQueue.main.async {
					if !self.currentUser.journalEntries.isEmpty {
						let content = UNMutableNotificationContent()
						content.title = "Hey you!"
						content.body = "Wanna add a new journal entry to express how you feel?"
						content.categoryIdentifier = "reminder"

						let dateFormatter = DateFormatter()
						dateFormatter.dateFormat = "dd/MM/yyyy"
						dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
						let lastJournalLogDate = dateFormatter.date(from: self.currentUser.journalEntries.last!.dateAdded)
						
						var calendar = Calendar.current
						calendar.timeZone = TimeZone(abbreviation: "UTC")!
						var triggerDate = calendar.date(byAdding: .day, value: 1, to: lastJournalLogDate!)
						triggerDate = calendar.date(byAdding: .hour, value: 12, to: triggerDate!)
						let triggerDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: triggerDate!)
						
						let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponent, repeats: true)
						
						let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
						self.notificationCenter.add(request)
					}
				}
					
			} else {
				self.notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: {
					permissionGranted, error in
					if permissionGranted {
						DispatchQueue.main.async {
							if !self.currentUser.journalEntries.isEmpty {
								let content = UNMutableNotificationContent()
								content.title = "Hey you!"
								content.body = "Wanna add a new journal entry to express how you feel?"
								content.categoryIdentifier = "reminder"

								let dateFormatter = DateFormatter()
								dateFormatter.dateFormat = "dd/MM/yyyy"
								dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
								let lastJournalLogDate = dateFormatter.date(from: self.currentUser.journalEntries.last!.dateAdded)
								
								var calendar = Calendar.current
								calendar.timeZone = TimeZone(abbreviation: "UTC")!
								var triggerDate = calendar.date(byAdding: .day, value: 1, to: lastJournalLogDate!)
								triggerDate = calendar.date(byAdding: .hour, value: 12, to: triggerDate!)
								let triggerDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: triggerDate!)
								
								let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponent, repeats: true)
								
								let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
								self.notificationCenter.add(request)
							}
						}
					}
				})
			}
		})
	}
    
    @IBAction func didTapBreathingExercise(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "breathingExerciseVC") as! BreathingExcerciseViewController
		viewController.title = "Breathing exercise"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
	
    @IBAction func didTapVideoPlayerView(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "videoPlayerVC") as! VideoPlayerViewController
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
	
	@IBAction func didTapWebsiteView(_ sender: Any) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "webVC") as! WebViewViewController
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}
