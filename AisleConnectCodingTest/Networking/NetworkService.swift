//
//  NetworkService.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/12.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//



import Foundation

class NetworkService {
    
    weak var delegate: URLSessionDelegate?
    
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }()
    
    func fetchProductBy(Id: Int, token: String, completion: @escaping (String, String)-> ()) {
        if var components = URLComponents(string: "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/product/\(Id)") {
            components.queryItems?.append(URLQueryItem(name: "access_token", value: token))

            guard let url = components.url else {return}
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    
                    guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {return}
                    guard let data = json["data"] as? [String: Any] else {return}
                    let description = data["description"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    
                    completion(description, imageUrl)
                    
                } else {
                    print(error.debugDescription)
                    
                }
                }.resume()
            
            
        }
        
        
    }

    
    
    
    
    
    func fetchListBy(Id: Int, token: String, completion: @escaping ([Product])-> ()) {
        if var components = URLComponents(string: "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/checklist/\(Id)") {
            components.queryItems?.append(URLQueryItem(name: "access_token", value: token))
            guard let url = components.url else {return}
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    
                    guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {return}
                    guard let data = json["data"] as? [String: Any] else {return}
                    guard let products = data["products"] as? [[String:Any]] else {return}
                    
                    var productArray = [Product]()
                    for product in products {
                        let id = product["id"] as? Int ?? 0
                        let name = product["name"] as? String ?? ""
                        let imageUrl = product["imageUrl"] as? String ?? ""
                        let author = product["authors"] as? [String] ?? [""]
                        let product = Product(id: id, name: name, ean: 0, imageUrl: imageUrl, stores: nil, isbn10: "", isbn13: "", authors: author, edition: "", numPages: 0, rating: Rating(statistics: RatingStatistics(average: nil, count: 0, distribution: nil), user: nil))
                        productArray.append(product)
                    }
                    completion(productArray)
                } else {
                    print(error.debugDescription)
                }
                }.resume()
        }

        
    }

    
    func fetchList(by token: String, completion: @escaping ([Data]) -> () ) {
        
        if var components = URLComponents(string: "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/checklist/") {
            components.queryItems?.append(URLQueryItem(name: "access_token", value: token))
            guard let url = components.url else {return}
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    
                    guard let jsonData = try? JSONDecoder().decode(Result.self, from: data!) else {return}
                    completion(jsonData.data)
                } else {
                    print(error.debugDescription)
                }
                }.resume()
            
            
        }
    }
    
    func login(by userInfo: [String: String], completion: @escaping (String?, String?) -> Void) {
        let endpoint = "https://apistage2.aisleconnect.us/ac.server/oauth/token"
        
        var parameters = [
            "grant_type": "password",
            "client_id": "my-client",
            "client_secret": "my-secret",
            "scope": "read"
        ]

        var components = URLComponents(string: endpoint)
        var queryItems = [URLQueryItem]()
        
        for (key, value) in userInfo {
            parameters.updateValue(value, forKey: key)
        }
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }

        components?.queryItems = queryItems
        guard let url = components?.url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        urlSession.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error.debugDescription)
                completion(nil, error.debugDescription)
                return
            }
       
            guard let data = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {return}
            guard let token = data["access_token"] as? String else {
                if let err = data["error"] as? String {
                    completion(nil, err)
                }
                return}
            completion(token, nil)
            
        }.resume()


    }
}


