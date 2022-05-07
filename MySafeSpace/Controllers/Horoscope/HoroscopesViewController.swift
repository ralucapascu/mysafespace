//
//  HoroscopesViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/4/22.
//

import UIKit

class HoroscopesViewController: UIViewController {
    
    @IBOutlet weak var horoscopeCollectionView: UICollectionView!
    
    private let signs: [String] = ["Aquarius", "Pisces", "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        horoscopeCollectionView.dataSource = self
        horoscopeCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        horoscopeCollectionView.collectionViewLayout = layout
    }
}

extension HoroscopesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horoscopeCollectionCell", for: indexPath) as! HoroscopeCollectionViewCell
        cell.configure(image: UIImage(named: signs[indexPath.row].description.lowercased())!.withRenderingMode(.alwaysTemplate), labelText: signs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "horoscopeVC") as! HoroscopeViewController
        viewController.title = signs[indexPath.row]
        viewController.sign = signs[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3 - 10, height: 140)
    }
}

