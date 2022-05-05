//
//  HoroscopeViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/5/22.
//

import UIKit

class HoroscopeViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    var horoscope: String = ""
    var sign: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.startAnimating()
        getHoroscopeData(sign: sign.lowercased())
    }
    
    private func getHoroscopeData(sign: String) {
        let urlString = "https://ohmanda.com/api/horoscope/" + sign + "/"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let _ = error {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let data = data,
                    let welf = self else { return }

            guard let item = try? jsonDecoder.decode(Horoscope.self, from: data) else { return }
            welf.horoscope = item.horoscope
            print(item)
            DispatchQueue.main.async {
                welf.loadingSpinner.stopAnimating()
                welf.textView.text = welf.horoscope
            }
        }
        task.resume()
    }
}
