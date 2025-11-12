//
//  PostsCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PostsCell: BaseCollectionViewCell {
    
    private var postImage: [ImageCell.Item] = []
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .test
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Test user"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    private let checkmark: UIImageView = {
        let image = UIImageView()
        image.image = .officialIcon
        
        return image
    }()
    
    private let nameStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Test location"
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .subtitle
        
        return label
    }()
    
    private let profileTextStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 2
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private let profileStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        
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
    
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 375)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pageViewBackground
        view.layer.cornerRadius = 13
        
        return view
    }()
    
    private let currentPageLabel: UILabel = {
        let label = UILabel()
        label.text = "1/3"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    private let likeIcon: UIImageView = {
        let image = UIImageView()
        image.image = .likeIcon
        
        return image
    }()
    
    private let commentIcon: UIImageView = {
        let image = UIImageView()
        image.image = .commentIcon
        
        return image
    }()
    
    private let shareIcon: UIImageView = {
        let image = UIImageView()
        image.image = .shareIcon
        
        return image
    }()
    
    private let bookmarkIcon: UIImageView = {
        let image = UIImageView()
        image.image = .bookmarkIcon
        
        return image
    }()
    
    private let leftIconStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 17
        
        return stackView
    }()
    
    private let iconStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundStyle = .automatic
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .link
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    
    private let likedPostProfileImage: UIImageView = {
        let image = UIImageView()
        image.image = .test
        
        return image
    }()
    
    private let likedPostLabel: UILabel = {
        let label = UILabel()
        label.text = "Test liked by someone"
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    private let likedPostStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 6
        
        return stackView
    }()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.text = "Test description Test description"
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    private let postStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.text = "TestDate 1"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .dateBackground
        
        return label
    }()
    
    private let bottomStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 12
        
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
        
        [topStackView, imageCollectionView, iconStackView, pageControl, bottomStackView, containerView].forEach(contentView.addSubview)
        
        [profileStackView, moreOptions].forEach(topStackView.addArrangedSubview)
        
        [profileImage, profileTextStackView].forEach(profileStackView.addArrangedSubview)
        
        [nameStackView, locationLabel].forEach(profileTextStackView.addArrangedSubview)
        
        [profileName, checkmark].forEach(nameStackView.addArrangedSubview)
        
        [leftIconStackView, bookmarkIcon].forEach(iconStackView.addArrangedSubview)
        
        [likeIcon, commentIcon, shareIcon].forEach(leftIconStackView.addArrangedSubview)
        
        [postStackView, postDateLabel].forEach(bottomStackView.addArrangedSubview)
        
        [likedPostStackView, postLabel].forEach(postStackView.addArrangedSubview)
        
        [likedPostProfileImage, likedPostLabel].forEach(likedPostStackView.addArrangedSubview(_:))
        
        containerView.addSubview(currentPageLabel)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(375)
        }
        
        iconStackView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(14)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(21)
            make.centerX.equalTo(imageCollectionView.snp.centerX)
            make.height.equalTo(20)
        }
        
        moreOptions.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(14)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(iconStackView.snp.bottom).offset(13)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        likedPostProfileImage.snp.makeConstraints { make in
            make.size.equalTo(17)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.top).offset(14)
            make.trailing.equalTo(imageCollectionView.snp.trailing).offset(-14)
        }
        
        currentPageLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(6)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: contentView.frame.width, height: 375)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        imageCollectionView.collectionViewLayout = layout
    }
}

extension PostsCell {
    struct Item {
        let username: String
        let userImage: String
        let location: String
        let postImage: [ImageCell.Item]
        let description: String
        let likeCount: Int
        let likedBy: String
        let createdAt: String
        var currentPage: Int = 0
    }
    
    func configure(_ item: Item) {
        profileName.text = item.username.capitalized
        locationLabel.text = item.location
        postImage = item.postImage
        postDateLabel.text = Date().showDate(dateString: item.createdAt)
        profileImage.kf.setImage(with: URL(string: item.userImage))
        if !item.description.isEmpty {
            postLabel.attributedText = self.changeText(text: "\(profileName.text ?? "No profile") \(item.description)", alterRange: "\(profileName.text ?? "No profile")")
        } else {
            postLabel.text = ""
        }
        likedPostLabel.attributedText = self.changeText(text: "Liked by \(item.likedBy) and \(item.likeCount) others", alterRange1: "\(item.likedBy)", alterRange2: "\(item.likeCount) others")
        
        let count = postImage.count
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        containerView.isHidden = !(count > 1)
        
        pageControl.currentPage = item.currentPage
        currentPageLabel.text = "\(item.currentPage + 1)/\(count)"
        
        imageCollectionView.reloadData()
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: item.currentPage, section: 0)
            self.imageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

extension PostsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueCell(with: indexPath)
        cell.configure(postImage[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        let numberOfPages = pageControl.numberOfPages
        
        currentPageLabel.text = "\(currentPage + 1)/\(numberOfPages)"
        
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        let numberOfPages = pageControl.numberOfPages
        
        currentPageLabel.text = "\(currentPage + 1)/\(numberOfPages)"
        
        pageControl.currentPage = currentPage
    }
}
