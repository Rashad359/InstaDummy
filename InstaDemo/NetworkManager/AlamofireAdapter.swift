//
//  AlamofireAdapter.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/13/25.
//

import UIKit
import Alamofire

final class AlamofireAdapter: APISession {
    
    func fetchProfiles(completion: @escaping (Result<ProfileModel, any Error>) -> Void) {
        let safeUrl = "https://mocki.io/v1/d9936aaa-4308-4b91-8077-12d907f63ce2"
        let url = "http://172.20.10.179:3000/stories"
        
        AF.request(url, method: .get).validate().responseDecodable(of: ProfileModel.self) { data in
            switch data.result {
                
            case .success(let value):
                
                completion(.success(value))
                
            case .failure(let error):
                
                completion(.failure(error))
                
            }
        }
    }
    
    func fetchFeed(completion: @escaping (Result<FeedModel, any Error>) -> Void) {
        let safeUrl = "https://mocki.io/v1/d4b81786-a74a-48c7-ac19-c2ed0abfe394"
        let url = "http://172.20.10.179:3000/feed"
        
        AF.request(url, method: .get).validate().responseDecodable(of: FeedModel.self) { data in
            switch data.result {
                
            case .success(let value):
                
                completion(.success(value))
                
            case .failure(let error):
                
                completion(.failure(error))
                
            }
        }
    }
    
    
}
