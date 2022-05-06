//
//  SentimentAnalyserViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import UIKit

class SentimentAnalyserViewController: UIViewController {
	
	public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        getSentimentAnalysisResults()
    }
	
	private func getSentimentAnalysisResults() {
		let urlString = "https://text-sentiment.p.rapidapi.com/analyze"
		let url = URL(string: urlString)!
		var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
		let headers = [
			"content-type": "application/x-www-form-urlencoded",
			"X-RapidAPI-Host": "text-sentiment.p.rapidapi.com",
			"X-RapidAPI-Key": "e243b8f3f1msh4e57bb53e882595p10f0f9jsn128ebb3b66b9"
		]
		
		var allJournalLogs = "text="
		for entry in user.journalEntries {
			allJournalLogs += entry.text
			allJournalLogs += ". "
		}
		
		let postData = allJournalLogs.data(using: String.Encoding.utf8)!
		
		request.httpMethod = "POST"
		request.httpBody = postData
		request.allHTTPHeaderFields = headers
		
		let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
			if let _ = error {
				return
			}
			
			let jsonDecoder = JSONDecoder()
			guard let data = data, let welf = self else { return }

			guard let item = try? jsonDecoder.decode(SentimentAnalyser.self, from: data) else { return }
			DispatchQueue.main.async {
				welf.drawRectangles()
			}
		}
		task.resume()
	}
	
	private func drawRectangles() {
		let path1 = UIBezierPath()
		path1.move(to: CGPoint(x: view.frame.width/4 - 30, y: view.frame.height/3))
		path1.addLine(to: CGPoint(x: view.frame.width/4 + 30, y: view.frame.height/3))
		path1.addLine(to: CGPoint(x: view.frame.width/4 + 30, y: view.frame.height/3 + 300))
		path1.addLine(to: CGPoint(x: view.frame.width/4 - 30, y: view.frame.height/3 + 300))
		path1.addLine(to: CGPoint(x: view.frame.width/4 - 30, y: view.frame.height/3))
				
		let happyRec = CAShapeLayer()
		happyRec.path = path1.cgPath
		happyRec.fillColor = UIColor.systemPink.cgColor
		
		let path2 = UIBezierPath()
		path2.move(to: CGPoint(x: view.frame.width/2 - 30, y: view.frame.height/3))
		path2.addLine(to: CGPoint(x: view.frame.width/2 + 30, y: view.frame.height/3))
		path2.addLine(to: CGPoint(x: view.frame.width/2 + 30, y: view.frame.height/3 + 300))
		path2.addLine(to: CGPoint(x: view.frame.width/2 - 30, y: view.frame.height/3 + 300))
		path2.addLine(to: CGPoint(x: view.frame.width/2 - 30, y: view.frame.height/3))
				
		let mehRec = CAShapeLayer()
		mehRec.path = path2.cgPath
		mehRec.fillColor = UIColor.gray.cgColor
		
		let path3 = UIBezierPath()
		path3.move(to: CGPoint(x: 3*view.frame.width/4 - 30, y: view.frame.height/3 + 300))
		path3.addLine(to: CGPoint(x: 3*view.frame.width/4 + 30, y: view.frame.height/3 + 300))
		path3.addLine(to: CGPoint(x: 3*view.frame.width/4 + 30, y: view.frame.height/3))
		path3.addLine(to: CGPoint(x: 3*view.frame.width/4 - 30, y: view.frame.height/3))
		path3.addLine(to: CGPoint(x: 3*view.frame.width/4 - 30, y: view.frame.height/3 + 300))
				
		let sadRec = CAShapeLayer()
		sadRec.fillColor = UIColor.blue.cgColor
		var rect = CGRect(origin: .zero, size: CGSize(width: 60, height: 300))
		sadRec.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
		
		view.layer.addSublayer(happyRec)
		view.layer.addSublayer(mehRec)
		view.layer.addSublayer(sadRec)
		
		CATransaction.begin()
		CATransaction.setCompletionBlock({
			var rect = CGRect(origin: CGPoint(x: 3*self.view.frame.width/4 - 30, y: self.view.frame.height/3 + (0.25 * 300)), size: CGSize(width: 60, height: 0.75 * 300))
			sadRec.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
		})
		sadRec.add(animationGroup(scaleValue: -0.75), forKey: nil)
		CATransaction.commit()
		
	}
	
	private func animationGroup(scaleValue: CGFloat) -> CAAnimationGroup {
		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [keepAnimationInPlace, scaleAnimation(scaleValue: scaleValue)]
		animationGroup.duration = 1
		animationGroup.isRemovedOnCompletion = true
		animationGroup.fillMode = .forwards
		return animationGroup
	}
	
	private func scaleAnimation(scaleValue: CGFloat) -> CAKeyframeAnimation {
		let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
		scaleAnimation.values = [0, scaleValue]
		scaleAnimation.keyTimes = [0, 1]
		return scaleAnimation
	}
	
	private lazy var keepAnimationInPlace: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "position")
		animation.fromValue = [3*view.frame.width/4 - 30, view.frame.height/3 + 300]
		animation.toValue = [3*view.frame.width/4 - 30, view.frame.height/3 + 300]
		return animation
	}()
}
