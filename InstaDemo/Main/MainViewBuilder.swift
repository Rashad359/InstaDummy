//
//  MainViewBuilder.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit

final class MainViewBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = MainViewModel(coordinator: coordinator)
        let mainVC = MainViewController(viewModel: viewModel)
        
        return mainVC
    }
}
