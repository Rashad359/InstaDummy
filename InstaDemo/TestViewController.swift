//
//  TestViewController.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/29/25.
//

import UIKit
import SnapKit

final class TestViewController: BaseViewController {
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .green
        
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .red
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
}
