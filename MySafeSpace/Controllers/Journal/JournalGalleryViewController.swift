//
//  JournalGalleryViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import UIKit
import FirebaseStorage

class JournalGalleryViewController: UIViewController {
	
	@IBOutlet weak var galleryCollectionView: UICollectionView!
	@IBOutlet weak var label: UILabel!
	
	public var journalEntry: JournalEntry!
	
	private let storage = Storage.storage().reference()
	
	private var imagesData: [Data] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if !journalEntry.journalPhotos.isEmpty {
			label.isHidden = true
			galleryCollectionView.isHidden = false
			imagesData = [Data](repeating: Data(), count: journalEntry.journalPhotos.count)
		}
		
		galleryCollectionView.dataSource = self
		galleryCollectionView.delegate = self
		let layout = UICollectionViewFlowLayout()
		galleryCollectionView.collectionViewLayout = layout
    }
}

extension JournalGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return journalEntry.journalPhotos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
		let path = journalEntry.user.first!.email + "/\(journalEntry.journalId)/"
		storage.child(path + "\(indexPath.row).png").getData(maxSize: 200 * 1024 * 1024, completion: {data, error in
			guard error == nil else {return}
			self.imagesData[indexPath.row] = data!
			print("arrayul")
			print(self.imagesData)
			cell.configure(image: UIImage(data: data!)!)
		})
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "photoVC") as! PhotoViewController
		viewController.imageData = imagesData[indexPath.row]
		viewController.photo = journalEntry.journalPhotos[indexPath.row]
		self.navigationController?.pushViewController(viewController, animated: true)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width/3 - 10, height: 100)
	}
}
