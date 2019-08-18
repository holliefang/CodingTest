//
//  ListsController.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/16.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import UIKit



class ListsController: UIViewController, UITableViewDataSource, UITableViewDelegate, URLSessionDelegate {
    
    var lists = [Data]()
    let network = NetworkService()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.delegate = self
        
        network.fetchList(by: Token.shared.token) { lists in
            self.lists = lists
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
            
        navigationItem.title = "LISTS"

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListsCell.cellID, for: indexPath) as? ListsCell {
            
            guard lists.count > 0 else {
                return UITableViewCell()}
            let list = lists[indexPath.row]
            
            cell.nameLabel.text = list.name
            if let number = list.products?.count {
                cell.numberOfItemLabel.text = "\(number) books in the list"
            } else {
                cell.numberOfItemLabel.text = "No books in the list"
            }

            
            return cell

        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let list = lists[indexPath.row]

        guard let productNumber = list.products?.count, productNumber > 0 else {return}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listVC = storyboard.instantiateViewController(withIdentifier: "List Controller") as! ListController
        listVC.id = list.id
        listVC.title = list.name
        
        
        navigationController?.pushViewController(listVC, animated: true)

        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.18
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
