//
//  DetailController.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/18.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import UIKit

class DetailController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    let network = NetworkService()
    
    var id: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.delegate = self
//        navigationItem.title = "Product Detail"
        
        guard let id = id else {return}
    
        network.fetchProductBy(Id: id, token: Token.shared.token) { (description, imageURL) in
            DispatchQueue.main.async {
                self.coverImage.image = imageURL.getImage()
                self.descriptionTextView.text = description

            }
            
        }

    }
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
            && challenge.protectionSpace.serverTrust != nil
            && challenge.protectionSpace.host == "apistage2.aisleconnect.us" {
            
            let credential = URLCredential(trust: serverTrust)
            
            completionHandler(.useCredential, credential)
            
        }
    }

}
