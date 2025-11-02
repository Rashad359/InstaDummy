//
//  PeopleAccountsCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PeopleAccountsCell: UICollectionViewCell {
    
    private var isFollowing = false
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.suggestionBorder.cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.cancelButton, for: .normal)
        
        return button
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .test
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 43
        
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Test user"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    private let shortName: UILabel = {
        let label = UILabel()
        label.text = "testUsershort"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        
        return label
    }()
    
    private let textStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .moreButton
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        
        return button
    }()
    
    private let mainStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 7
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
        
        contentView.addSubview(containerView)
        contentView.addSubview(followButton)
        
        [backButton, mainStackView].forEach(containerView.addSubview)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [profileImage, textStackView].forEach(mainStackView.addArrangedSubview)
        
        [profileName, shortName].forEach(textStackView.addArrangedSubview)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        mainStackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(86)
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(7)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(31)
        }
        
    }
    
    @objc
    private func didTapFollow() {
        isFollowing.toggle()
        
        if isFollowing {
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.moreButton.cgColor
            followButton.backgroundColor = .white
            followButton.setTitle("Following", for: .normal)
            followButton.setTitleColor(.moreButton, for: .normal)
        } else {
            followButton.layer.borderWidth = 0
            followButton.backgroundColor = .moreButton
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
        }
    }
}

extension PeopleAccountsCell {
    struct Item {
        let profileImage: String
        let profileName: String
        let shortName: String
    }
    
    func configure(_ item: Item) {
//        profileImage.image = item.profileImage
        profileName.text = item.profileName
        shortName.text = item.shortName
        
        profileImage.kf.setImage(with: URL(string: item.profileImage))
    }
}
