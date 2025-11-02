//
//  MainViewBuilder.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit

final class MainViewBuilder {
    func build() -> UIViewController {
        let viewModel = MainViewModel()
        let mainVC = MainViewController(viewModel: viewModel)
        
        return mainVC
    }
}
