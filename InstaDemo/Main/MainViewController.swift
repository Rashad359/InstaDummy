//
//  ViewController.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit
import SnapKit

enum PostsHandler {
    case normalPost(PostsCell.Item)
    case ads(AdvertisementCell.Item)
    case threads(ThreadsCell.Item)
    case peopleSuggestions([PeopleAccountsCell.Item])
}

class MainViewController: BaseViewController {
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var profileItems: [ProfilesCell.Item] = []
    
    private var items: [PostsHandler] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        collectionView.register(ProfilesCell.self, forCellWithReuseIdentifier: ProfilesCell.identifier)
        collectionView.register(PostsCell.self, forCellWithReuseIdentifier: PostsCell.identifier)
        collectionView.register(ThreadsCell.self, forCellWithReuseIdentifier: ThreadsCell.identifier)
        collectionView.register(PeopleSuggestionsCell.self, forCellWithReuseIdentifier: PeopleSuggestionsCell.identifier)
        collectionView.register(AdvertisementCell.self, forCellWithReuseIdentifier: AdvertisementCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        viewModel.subscribe(self)
        viewModel.fetchProfiles()
        viewModel.fetchFeed()
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func setupNavigation() {
        
        let imageView = UIImageView(image: .instagramLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        
        navigationItem.titleView = imageView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .cameraIcon, style: .plain, target: self, action: nil)
        
        let paperButton = UIBarButtonItem(image: .messageIcon, style: .plain, target: self, action: nil)
        let tvButton = UIBarButtonItem(image: .tvIcon.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)

        navigationItem.rightBarButtonItems = [paperButton, tvButton]
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(85),
                                                      heightDimension: .absolute(100))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80),
                                                       heightDimension: .absolute(100))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 10, bottom: 10, trailing: 10)
                
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(10))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(10))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                return section
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return profileItems.count }
        else { return items.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell: ProfilesCell = collectionView.dequeueCell(with: indexPath)
            cell.configure(profileItems[indexPath.row])
            
            return cell
            
        } else {
            let myCell = items[indexPath.row]
            switch myCell {
            case .normalPost(let postItem):
                
                let cell: PostsCell = collectionView.dequeueCell(with: indexPath)
                cell.configure(postItem)
                
                return cell
                
            case .threads(let threadsItem):
                
                let cell: ThreadsCell = collectionView.dequeueCell(with: indexPath)
                cell.configure(threadsItem)
                
                return cell
                
            case .ads(let adItem):
                
                let cell: AdvertisementCell = collectionView.dequeueCell(with: indexPath)
                cell.configure(adItem)
                
                return cell
                
            case .peopleSuggestions(let suggestionItem):
                let cell: PeopleSuggestionsCell = collectionView.dequeueCell(with: indexPath)
                cell.configure(suggestionItem)
                
                return cell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let item = profileItems[indexPath.row]
            
            let selectedStory = StoryModel(
                profileImage: item.imageUrl,
                username: item.name,
                createdAt: "4h",
                postImage: item.postUrl
            )
            
            viewModel.goToStories(with: selectedStory, from: profileItems)
        } else {
            return
        }
    }
}

extension MainViewController: MainViewDelegate {
    
    func didFetchFeed(_ item: [PostsHandler]) {
        self.items = item
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFetchProfiles(_ item: [ProfilesCell.Item]) {
        profileItems = item
        
        profileItems.insert(.init(name: "Your Story", imageUrl: "https://i.pravatar.cc/100?img=12", postUrl: "https://fastly.picsum.photos/id/619/720/1280.jpg?hmac=v9BPzSXNfQWdOA_dZWLJaMomh8Vh6lwa8KRADnuF32o", isLive: false), at: 0)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func error(_ error: any Error) {
        
        print(error.localizedDescription)
    }
    
    
}
