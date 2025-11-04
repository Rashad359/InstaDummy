//
//  ThreadPostCell 2.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/2/25.
//


import UIKit
import SnapKit
import Kingfisher

final class ThreadPostCell: BaseCollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.threadsBorder.cgColor
        
        return view
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .test
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Test User"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    private let postDate: UILabel = {
        let label = UILabel()
        label.text = "Test Date"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .dateBackground
        
        return label
    }()
    
    private let profileTextStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let profileStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let moreOptions: UIImageView = {
        let image = UIImageView()
        image.image = .moreIcon
        
        return image
    }()
    
    private let topStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Description"
        label.numberOfLines = .zero
        
        return label
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.image = .testPost
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let likeIcon: UIImageView = {
        let image = UIImageView()
        image.image = .likeIcon
        
        return image
    }()
    
    private let likeCount: UILabel = {
        let label = UILabel()
        label.text = "1"
        
        return label
    }()
    
    private let likeStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let commentIcon: UIImageView = {
        let image = UIImageView()
        image.image = .commentIcon
        
        return image
    }()
    
    private let commentCount: UILabel = {
        let label = UILabel()
        label.text = "1"
        
        return label
    }()
    
    private let commentStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let repostIcon: UIImageView = {
        let image = UIImageView()
        image.image = .repostIcon
        
        return image
    }()
    
    private let repostCount: UILabel = {
        let label = UILabel()
        label.text = "1"
        
        return label
    }()
    
    private let repostStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let sendIcon: UIImageView = {
        let image = UIImageView()
        image.image = .shareIcon
        
        return image
    }()
    
    private let sendCount: UILabel = {
        let label = UILabel()
        label.text = "1"
        
        return label
    }()
    
    private let sendStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let bottomStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let midStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 16
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private let mainStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 14
        
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
        
        postImage.kf.setImage(with: URL(string: "https://photos.bandsintown.com/large/7230696.jpeg"))
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.greaterThanOrEqualToSuperview().inset(13)
            make.bottom.lessThanOrEqualToSuperview().inset(13)
        }
        
        containerView.addSubview(mainStackView)

        [topStackView, midStackView].forEach(mainStackView.addArrangedSubview)
        
        [profileStackView, moreOptions].forEach(topStackView.addArrangedSubview)
        
        [profileImage, profileTextStackView].forEach(profileStackView.addArrangedSubview)
        
        [profileName, postDate].forEach(profileTextStackView.addArrangedSubview)
        
        [descriptionLabel, postImage, bottomStackView].forEach(midStackView.addArrangedSubview)
        
        [likeStackView, commentStackView, repostStackView, sendStackView].forEach(bottomStackView.addArrangedSubview)
        
        [likeIcon, likeCount].forEach(likeStackView.addArrangedSubview)
        
        [commentIcon, commentCount].forEach(commentStackView.addArrangedSubview)
        
        [repostIcon, repostCount].forEach(repostStackView.addArrangedSubview)
        
        [sendIcon, sendCount].forEach(sendStackView.addArrangedSubview)
        
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.horizontalEdges.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionLabel.isHidden = false
        descriptionLabel.text = nil
        
        postImage.isHidden = false
        postImage.image = nil
    }
}

extension ThreadPostCell {
    struct Item {
        let profileImage: String
        let userName: String
        let postDescription: String
        let postImage: String
        let postDate: String
        let likeCount: Int
        let commentCount: Int
        let repostCount: Int
        let sharedCount: Int
    }
    
    func configure(_ item: Item) {
        profileName.text = item.userName
        profileImage.kf.setImage(with: URL(string: item.profileImage))
        postDate.text = self.showDate(dateString: item.postDate)
        likeCount.text = "\(item.likeCount)"
        commentCount.text = "\(item.commentCount)"
        repostCount.text = "\(item.repostCount)"
        sendCount.text = "\(item.sharedCount)"
        
        // Description handling
        if item.postDescription.isEmpty {
            descriptionLabel.isHidden = true
            descriptionLabel.text = nil
        } else {
            descriptionLabel.isHidden = false
            descriptionLabel.text = item.postDescription
        }
        
        // Image handling
        if item.postImage.isEmpty {
            postImage.isHidden = true
            postImage.image = nil
        } else {
            postImage.isHidden = false
            postImage.kf.setImage(with: URL(string: item.postImage))
        }
    }
}
