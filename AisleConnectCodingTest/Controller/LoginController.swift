//
//  ViewController.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/12.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//


import UIKit


class LoginController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    let network = NetworkService()
        
    let loginInfo = [
        "username": "",
        "password": ""
    ]
    
//    let loginInfo = [
//        "username": "paul.lin@lineagenetworks.com",
//        "password": "welcome1"
//    ]


    override func viewDidLoad() {
        
        super.viewDidLoad()
        network.delegate = self
        
    }
    
    @IBAction func login() {
        
                guard let username = usernameTextFiled.text, !username.isEmpty,
                      let password = passwordTextFiled.text, !password.isEmpty else {return}
        
                let loginInfo = ["username": username, "password": password]
        
        
        network.login(by: loginInfo) { (token, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            if token != nil {
                Token.shared.token = token!
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Success", message: "Login Success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:  { _ in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: "Nav") as? UINavigationController {
                            self.show(vc, sender: nil)
                        }
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    print(token!)
                }
                
            }
        }
        
    }
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
            && challenge.protectionSpace.serverTrust != nil
            && challenge.protectionSpace.host == "apistage2.aisleconnect.us" {
            
            let credential = URLCredential(user: loginInfo["username"]!, password: loginInfo["password"]!, persistence: .forSession)
            
            completionHandler(.useCredential, credential)
        }
        completionHandler(.performDefaultHandling, nil)
    }
}


