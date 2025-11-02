//
//  APISession.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit

protocol APISession {
    
    func fetchProfiles(completion: @escaping(Result<ProfileModel, Error>) -> Void)
    
    func fetchFeed(completion: @escaping(Result<FeedModel, Error>) -> Void)
}
