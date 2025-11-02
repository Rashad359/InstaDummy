//
//  PeopleSuggestionsCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit
import SnapKit

final class PeopleSuggestionsCell: UICollectionViewCell {
    
    private var items: [PeopleAccountsCell.Item] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Suggested for you"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.moreButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return button
    }()
    
    private let topStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var suggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: 141, height: 188)
        layout.itemSize = CGSize(width: 141, height: 188)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PeopleAccountsCell.self, forCellWithReuseIdentifier: PeopleAccountsCell.identifier)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
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
        
        [topStackView, suggestionsCollectionView].forEach(contentView.addSubview)
        
        [titleLabel, seeAllButton].forEach(topStackView.addArrangedSubview)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        suggestionsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(_ items: [PeopleAccountsCell.Item]) {
        self.items = items
    }
}

extension PeopleSuggestionsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PeopleAccountsCell = collectionView.dequeueCell(with: indexPath)
        //For testing purposes
//        cell.configure(.init(profileImage: .test, profileName: "Test user", shortName: "testusershort"))
        cell.configure(items[indexPath.row])
        
        return cell
    }
}
