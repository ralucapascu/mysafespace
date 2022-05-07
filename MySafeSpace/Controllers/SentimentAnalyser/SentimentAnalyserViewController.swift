//
//  SentimentAnalyserViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import UIKit

class SentimentAnalyserViewController: UIViewController {
	
	@IBOutlet weak var label: UILabel!
	
	public var user: User!
		
	var happyPerc: Float = 0.0
	var mehPerc: Float = 0.0
	var sadPerc: Float = 0.0
	var happyPercString: String = ""
	var mehPercString: String = ""
	var sadPercString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

		if !user.journalEntries.isEmpty {
			label.isHidden = true
			getSentimentAnalysisResults()
		}
        
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
			if entry != user.journalEntries.last {
				allJournalLogs += ". "
			}
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
			guard let result = try? jsonDecoder.decode(SentimentAnalyser.self, from: data) else { return }
			welf.happyPercString = result.pos_percent
			welf.mehPercString = result.mid_percent
			welf.sadPercString = result.neg_percent
			DispatchQueue.main.async {
				welf.calculatePercentages(pos: result.pos, mid: result.mid, neg: result.neg)
				welf.drawRectangles()
			}
		}
		task.resume()
	}
	
	private func calculatePercentages(pos: Float, mid: Float, neg: Float) {
		let total = pos + mid + neg;
		happyPerc = pos / total;
		mehPerc = mid / total;
		sadPerc = neg / total;
	}
	
	private func drawRectangles() {
		let rect = CGRect(origin: .zero, size: CGSize(width: 60, height: 300))
				
		let happyRec = CAShapeLayer()
		happyRec.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
		happyRec.fillColor = UIColor.systemPink.cgColor
				
		let mehRec = CAShapeLayer()
		mehRec.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
		mehRec.fillColor = UIColor.gray.cgColor
				
		let sadRec = CAShapeLayer()
		sadRec.fillColor = UIColor.blue.cgColor
		sadRec.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
		
		view.layer.addSublayer(happyRec)
		view.layer.addSublayer(mehRec)
		view.layer.addSublayer(sadRec)
		
		CATransaction.begin()
		CATransaction.setCompletionBlock({
			let newSadHeight = CGFloat((1.0 - self.sadPerc) * 300.0)
			let rect1 = CGRect(origin: CGPoint(x: 3*self.view.frame.width/4 - 30, y: self.view.frame.height/4 + newSadHeight), size: CGSize(width: 60.0, height: Double(self.sadPerc) * 300))
			sadRec.path = UIBezierPath(roundedRect: rect1, cornerRadius: 0).cgPath
			
			let newMehHeight = CGFloat((1 - self.mehPerc) * 300)
			let rect2 = CGRect(origin: CGPoint(x: self.view.frame.width/2 - 30, y: self.view.frame.height/4 + newMehHeight), size: CGSize(width: 60, height: Double(self.mehPerc) * 300))
			mehRec.path = UIBezierPath(roundedRect: rect2, cornerRadius: 0).cgPath
			
			let newHappyHeight = CGFloat((1 - self.happyPerc) * 300)
			let rect3 = CGRect(origin: CGPoint(x: self.view.frame.width/4 - 30, y: self.view.frame.height/4 + newHappyHeight), size: CGSize(width: 60, height: Double(self.happyPerc) * 300))
			happyRec.path = UIBezierPath(roundedRect: rect3, cornerRadius: 0).cgPath
			
			let happyTextLayer = CATextLayer()
			if self.happyPercString.count > 4 {
				let happyIndex = self.happyPercString.index(self.happyPercString.startIndex, offsetBy: 4)
				happyTextLayer.string = self.happyPercString.prefix(upTo: happyIndex) + "%"
			} else {
				happyTextLayer.string = self.happyPercString
			}
			happyTextLayer.fontSize = 28
			happyTextLayer.frame = CGRect(x: self.view.frame.width/4 - 40, y: self.view.frame.height/4 + 320, width: 80, height: 40)
			happyTextLayer.alignmentMode = .center
			
			let happyImageView = UIImageView(frame: CGRect(x: self.view.frame.width/4 - 30, y: self.view.frame.height/4 + 360, width: 50, height: 50))
			happyImageView.image = UIImage(named: "happy")
			
			let mehTextLayer = CATextLayer()
			if self.mehPercString.count > 4 {
				let mehIndex = self.mehPercString.index(self.mehPercString.startIndex, offsetBy: 4)
				mehTextLayer.string = self.mehPercString.prefix(upTo: mehIndex) + "%"
			} else {
				mehTextLayer.string = self.mehPercString
			}
			mehTextLayer.frame = CGRect(x: self.view.frame.width/2 - 40, y: self.view.frame.height/4 + 320, width: 80, height: 40)
			mehTextLayer.fontSize = 28
			mehTextLayer.alignmentMode = .center
			
			let mehImageView = UIImageView(frame: CGRect(x: self.view.frame.width/2 - 30, y: self.view.frame.height/4 + 360, width: 50, height: 50))
			mehImageView.image = UIImage(named: "neutral")
			
			let sadTextLayer = CATextLayer()
			if self.sadPercString.count > 4 {
				let sadIndex = self.sadPercString.index(self.sadPercString.startIndex, offsetBy: 4)
				sadTextLayer.string = self.sadPercString.prefix(upTo: sadIndex) + "%"
			} else {
				sadTextLayer.string = self.sadPercString
			}
			sadTextLayer.fontSize = 28
			sadTextLayer.frame = CGRect(x: 3*self.view.frame.width/4 - 40, y: self.view.frame.height/4 + 320, width: 80, height: 40)
			sadTextLayer.alignmentMode = .center
			
			let sadImageView = UIImageView(frame: CGRect(x: 3*self.view.frame.width/4 - 30, y: self.view.frame.height/4 + 360, width: 50, height: 50))
			sadImageView.image = UIImage(named: "sad")
			
			self.view.layer.addSublayer(happyTextLayer)
			self.view.addSubview(happyImageView)
			self.view.layer.addSublayer(mehTextLayer)
			self.view.addSubview(mehImageView)
			self.view.layer.addSublayer(sadTextLayer)
			self.view.addSubview(sadImageView)
		})
		sadRec.add(animationGroup(scaleValue: -sadPerc, animation: keepSadAnimationInPlace), forKey: nil)
		mehRec.add(animationGroup(scaleValue: -mehPerc, animation: keepMehAnimationInPlace), forKey: nil)
		happyRec.add(animationGroup(scaleValue: -happyPerc, animation: keepHappyAnimationInPlace), forKey: nil)
		CATransaction.commit()
		
	}
	
	private func animationGroup(scaleValue: Float, animation: CABasicAnimation) -> CAAnimationGroup {
		let animationGroup = CAAnimationGroup()
		animationGroup.animations = [animation, scaleAnimation(scaleValue: scaleValue)]
		animationGroup.duration = 1.5
		return animationGroup
	}
	
	private func scaleAnimation(scaleValue: Float) -> CAKeyframeAnimation {
		let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
		scaleAnimation.values = [0, scaleValue]
		scaleAnimation.keyTimes = [0, 1]
		return scaleAnimation
	}
	
	private lazy var keepSadAnimationInPlace: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "position")
		animation.fromValue = [3*view.frame.width/4 - 30, view.frame.height/4 + 300]
		animation.toValue = [3*view.frame.width/4 - 30, view.frame.height/4 + 300]
		return animation
	}()
	
	private lazy var keepMehAnimationInPlace: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "position")
		animation.fromValue = [view.frame.width/2 - 30, view.frame.height/4 + 300]
		animation.toValue = [view.frame.width/2 - 30, view.frame.height/4 + 300]
		return animation
	}()
	
	private lazy var keepHappyAnimationInPlace: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "position")
		animation.fromValue = [view.frame.width/4 - 30, view.frame.height/4 + 300]
		animation.toValue = [view.frame.width/4 - 30, view.frame.height/4 + 300]
		return animation
	}()
}
