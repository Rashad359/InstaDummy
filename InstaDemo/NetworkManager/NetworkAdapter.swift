//
//  NetworkAdapter.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit

final class NetworkAdapter: APISession {
    func fetchProfiles(completion: @escaping(Result<ProfileModel, Error>) -> Void) {
        let safeUrl = URL(string: "https://mocki.io/v1/d9936aaa-4308-4b91-8077-12d907f63ce2")!
        let url = URL(string: "http://172.20.10.179:3000/stories")!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            if let data {
                do {
                    
                    let info = try JSONDecoder().decode(ProfileModel.self, from: data)
                    completion(.success(info))
                    
                } catch {
                    completion(.failure(error))
                    return
                }
            }
        }.resume()
    }
    
    func fetchFeed(completion: @escaping(Result<FeedModel, Error>) -> Void) {
        let safeUrl = URL(string: "https://mocki.io/v1/d4b81786-a74a-48c7-ac19-c2ed0abfe394")!
        let url = URL(string: "http://172.20.10.179:3000/feed")!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                do {
                    let info = try JSONDecoder().decode(FeedModel.self, from: data)
                    completion(.success(info))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
