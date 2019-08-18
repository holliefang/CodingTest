//
//  ListController.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/18.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import UIKit

class ListController: UIViewController, UITableViewDataSource, UITableViewDelegate, URLSessionDelegate {
    
    var products =  [Product]() {
        didSet {
//            self.tabelView.reloadData()
        }
    }
    
    let network = NetworkService()
    var id: Int?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.delegate = self
        
        guard let id = id else {
            return}
        
        network.fetchListBy(Id: id, token: Token.shared.token) { data in
            self.products.removeAll()
            self.products = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }


        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.cellID) as? ListCell {
            
            let product = products[indexPath.row]
            cell.bookTitleLabel.text = product.name
            cell.bookCoverImageView.image = product.imageUrl.getImage()
            cell.bookAuthorLabel.text = product.authors.allString()
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productName = products[indexPath.row].name
        
        let id = products[indexPath.row].id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailtVC = storyboard.instantiateViewController(withIdentifier: "Detail Controller") as! DetailController
        detailtVC.id = id
        detailtVC.title = productName
        navigationController?.pushViewController(detailtVC, animated: true)
        
        
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
