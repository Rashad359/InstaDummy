//
//  ProfileCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ProfilesCell: UICollectionViewCell {
    
    private lazy var containerView: GradientBorderView = {
        let view = GradientBorderView()
        view.gradientColors = [.storiesTop, .storiesMid, .storiesBot]
        view.layer.cornerRadius = 31
        
        return view
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 28
        imageView.image = .test
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "Test name"
        
        return label
    }()
    
    private let mainStackView: BaseVerticalStackView = {
        let stackView = BaseVerticalStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let liveContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 3
        view.backgroundColor = .purple
        
        return view
    }()
    
    private let liveLabel: UILabel = {
        let label = UILabel()
        label.text = "LIVE"
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [mainStackView, liveContainerView].forEach(contentView.addSubview)
        
        liveContainerView.addSubview(liveLabel)
        
        [containerView, profileName].forEach(mainStackView.addArrangedSubview)
        
        containerView.addSubview(profileImage)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(56)
            make.center.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.size.equalTo(65)
        }
        
        liveContainerView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(-10)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        
        liveLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(3)
            make.horizontalEdges.equalToSuperview().inset(4)
        }
        
        DispatchQueue.main.async {
            self.makeGradient(start: UIColor.liveButtonTop.cgColor, mid: UIColor.liveButtonMid.cgColor, end: UIColor.liveButtonBot.cgColor, to: self.liveContainerView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeGradient(start startColor: CGColor, mid midColor: CGColor, end endColor: CGColor, to view: UIView) {
        
        view.layer.sublayers?
            .filter { $0 is CAGradientLayer }
            .forEach { $0.removeFromSuperlayer() }
        
        let gradient = CAGradientLayer()
        
        gradient.colors = [startColor, midColor, endColor]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        gradient.cornerRadius = view.layer.cornerRadius
        
        view.layer.insertSublayer(gradient, at: 0)
    }
}

extension ProfilesCell {
    struct Item {
        let name: String
        let imageUrl: String
        let postUrl: String
        let isLive: Bool
    }
    
    func configure(_ item: Item) {
        profileName.text = item.name
        profileImage.kf.setImage(with: URL(string: item.imageUrl))
        
        if item.isLive {
            liveContainerView.isHidden = false
            containerView.gradientColors = [.liveStoriesTop, .liveStoriesMid, .liveStroiesBot]
        } else {
            liveContainerView.isHidden = true
            containerView.gradientColors = [.storiesTop, .storiesMid, .storiesBot]
        }
    }
}
