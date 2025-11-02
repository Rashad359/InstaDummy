//
//  ThreadEndCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/30/25.
//

import UIKit
import SnapKit

final class ThreadEndCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let firstImage: UIImageView = {
        let image = UIImageView()
        image.image = .test
        image.layer.cornerRadius = 16
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        
        return image
    }()
    
    private let secondImage: UIImageView = {
        let image = UIImageView()
        image.image = .test
        image.layer.cornerRadius = 16
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        
        return image
    }()
    
    private let thirdImage: UIImageView = {
        let image = UIImageView()
        image.image = .test
        image.layer.cornerRadius = 16
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        
        return image
    }()
    
    private let imageStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = -10
        
        return stackView
    }()
    
    private let defaultText: UILabel = {
        let label = UILabel()
        label.text = "See more from accounts you might know on Threads"
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.textColor = .cellText
        
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See More", for: .normal)
        button.tintColor = .moreButton
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return button
    }()
    
    private let mainStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 18
        stackView.alignment = .center
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .threadsBackround
        
        backgroundColor = .threadsBackround
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(mainStackView)
        
        [imageStackView, defaultText, moreButton].forEach(mainStackView.addArrangedSubview)
        
        [firstImage, secondImage, thirdImage].forEach(imageStackView.addArrangedSubview)
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        firstImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        secondImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        thirdImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        
    }
}
