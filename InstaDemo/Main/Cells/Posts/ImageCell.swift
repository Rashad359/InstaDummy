//
//  ImageCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/29/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ImageCell: UICollectionViewCell {
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.image = .testPost
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(postImage)
        
        postImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(375)
        }
    }
}

extension ImageCell {
    struct Item {
        var image: String
    }
    
    func configure(_ item: Item) {
//        postImage.image = item.image
        postImage.kf.setImage(with: URL(string: item.image))
    }
}
