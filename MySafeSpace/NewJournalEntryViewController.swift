//
//  NewJournalEntryViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/27/22.
//

import UIKit
import RealmSwift
import iCarousel
import FirebaseStorage

class NewJournalEntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var addPhotosButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var currentUser: User!
    let realm = try! Realm()
    let photoCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .coverFlow
        view.backgroundColor = .black
        return view
    }()
    private var imagesData: [Data] = []
	private var photos: [Photo] = []
	private var imagesURL: [String] = []
    private let storage = Storage.storage().reference()
    									
    public var completion: ((User) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photoCarousel)
        photoCarousel.dataSource = self
        photoCarousel.delegate = self
        photoCarousel.frame(forAlignmentRect: CGRect(x: 80, y: 80, width: view.frame.size.width, height: 80))
        photoCarousel.translatesAutoresizingMaskIntoConstraints = false
        photoCarousel.topAnchor.constraint(equalTo: addPhotosButton.bottomAnchor).isActive = true
        photoCarousel.leftAnchor.constraint(equalTo: addPhotosButton.leftAnchor).isActive = true
        photoCarousel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        photoCarousel.bottomAnchor.constraint(equalTo: titleField.topAnchor).isActive = true
        
        titleField?.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        textView.delegate = self
        textView.text = "Type here..."
        textView.textColor = .white
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here..." {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type here..."
            textView.textColor = .white
        }
    }
    
    @objc func didTapSaveButton() {
		var index = 0
		let path = currentUser.email + "/\(currentUser.journalEntries.count)/"
		
		for image in imagesData {
			storage.child(path + "\(index).png").putData(image, metadata: nil, completion: { _, error in
				guard error == nil else {return}
			})
			index += 1
		}
		
        try! realm.write {
            let title = !titleField.text!.isEmpty ? titleField.text! : "No title"
            let text = textView.text!
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let journalEntry = JournaEntry()
			journalEntry.journalId = currentUser.journalEntries.count
            journalEntry.title = title
            journalEntry.text = text
            journalEntry.dateAdded = dateFormatter.string(from: date)
			journalEntry.journalPhotos.append(objectsIn: photos)
			currentUser.journalEntries.append(journalEntry)
            realm.add(currentUser)
        }
        completion(currentUser)
        self.navigationController?.popViewController(animated: true)
    }
	
    @IBAction func didTapAddPhotosButton(_ sender: Any) {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        self.present(viewController, animated: true)
    }
}

extension NewJournalEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as! UIImage
        guard let imageData = image.pngData() else {return}
        picker.dismiss(animated: true)
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "editImgVC") as! EditImageViewController
		viewController.imageData = imageData
		viewController.completion = {
			photo in
			self.photos.append(photo)
			self.imagesData.append(imageData)
			self.photoCarousel.reloadData()
		}
		navigationController?.pushViewController(viewController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension NewJournalEntryViewController: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
		return imagesData.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        view.backgroundColor = .black
		let imageView: UIImageView = UIImageView(frame: view.bounds)
		let image: UIImage = UIImage(data: imagesData[index])!
		imageView.image = image
		imageView.contentMode = .scaleAspectFit
		view.addSubview(imageView)
        return view
    }
    
    
}
