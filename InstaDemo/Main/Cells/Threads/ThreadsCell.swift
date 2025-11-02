//
//  ThreadsCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ThreadsCell: UICollectionViewCell {
    
    private var items: [ThreadPostCell.Item] = []
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .threadsIcon
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Threads"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return label
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
    
    private lazy var threadsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 375)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ThreadPostCell.self, forCellWithReuseIdentifier: ThreadPostCell.identifier)
        collectionView.register(ThreadEndCell.self, forCellWithReuseIdentifier: ThreadEndCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        
        [topStackView, threadsCollectionView].forEach(contentView.addSubview)
        
        [profileStackView, moreOptions].forEach(topStackView.addArrangedSubview)
        
        [profileImage, profileTextStackView].forEach(profileStackView.addArrangedSubview)
        
        [profileName, locationLabel].forEach(profileTextStackView.addArrangedSubview)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        threadsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(375)
            make.bottom.equalToSuperview().offset(-10)
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
        
        threadsCollectionView.collectionViewLayout = layout
        
    }
    
    func configure(_ items: [ThreadPostCell.Item]) {
        self.items = items
    }
}

extension ThreadsCell {
    
    struct Item {
        let username: String
        let joinCount: Int
        let posts: [ThreadPostCell.Item]
    }
    
    func configure(_ item: Item) {
        locationLabel.text = "\(item.joinCount) others joined"
        
        self.items = item.posts
        threadsCollectionView.reloadData()
    }
}

extension ThreadsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == items.count {
            let cell: ThreadEndCell = collectionView.dequeueCell(with: indexPath)
            
            return cell
        } else {
            let cell: ThreadPostCell = collectionView.dequeueCell(with: indexPath)
            cell.configure(items[indexPath.row])
            
            return cell
        }
    }
}
