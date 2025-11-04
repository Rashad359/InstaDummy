//
//  StoryModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/3/25.
//

import UIKit

struct StoryModel: Equatable {
    let profileImage: String
    let username: String
    let createdAt: String
    let postImage: String
    var isSeen: Bool = false
}
