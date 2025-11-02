//
//  ProfileModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit

nonisolated struct ProfileModel: Decodable {
    let data: [DataModel]
    
    struct DataModel: Decodable {
        let username: String
        let userPhoto: String
        let storyUrl: String
        let isLive: Bool
    }
}
