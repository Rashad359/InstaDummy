//
//  AdImagesCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/2/25.
//

//
//  ImageCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/29/25.
//

import UIKit
import SnapKit
import Kingfisher

final class AdImagesCell: UICollectionViewCell {
    
    private var goToAdPage: (() -> ())? = nil
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.image = .testPost
        
        return image
    }()
    
    private let shopView: UIView = {
        let view = UIView()
        view.backgroundColor = .shopBar
        
        return view
    }()
    
    private let shopLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop now"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        
        return label
    }()
    
    private let shopChevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronRightIcon
        
        return imageView
    }()
    
    private let shopStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var shopContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .shopIconBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapShop)))
        
        return view
    }()
    
    private let shopIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .shopIcon
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapShop() {
        self.goToAdPage?()
    }
    
    private func setupUI() {
        
        [postImage, shopView, shopContainerView].forEach(contentView.addSubview)
        
        shopView.addSubview(shopStackView)
        
        [shopLabel, shopChevronIcon].forEach(shopStackView.addArrangedSubview)
        
        shopContainerView.addSubview(shopIcon)
        
        shopContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(shopView.snp.top).offset(-6)
            make.leading.equalToSuperview().offset(5)
            make.size.equalTo(20)
        }
        
        shopIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        shopView.snp.makeConstraints { make in
            make.bottom.equalTo(postImage.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(33)
        }
        
        shopStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(11)
            make.centerY.equalToSuperview()
        }
        
        postImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(375)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.kf.cancelDownloadTask()
        postImage.image = nil
    }
}

extension AdImagesCell {
    struct Item {
        var image: String
        var url: String
    }
    
    func configure(_ item: Item) {
//        postImage.image = item.image
        
        if let url = URL(string: item.image) {
            postImage.kf.setImage(with: url)
        } else {
            postImage.image = nil
        }
        
        self.goToAdPage = {
            UIApplication.shared.open(URL(string: item.url) ?? URL(string: "https://www.google.com")!)
        }
    }
}
