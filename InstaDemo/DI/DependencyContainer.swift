//
//  DependencyContainer.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit

final class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    lazy var networkManager: APISession = {
        return NetworkAdapter()
    }()
}
