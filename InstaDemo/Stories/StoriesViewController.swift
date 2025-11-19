//
//  StoriesViewController.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/3/25.
//

import UIKit
import SnapKit
import Kingfisher
import Combine

final class StoriesViewController: BaseViewController {
    
    private var cancellable = Set<AnyCancellable>()
    
    private let viewModel: StoriesViewModel
    
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var leftView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLeft)))
        
        return view
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRight)))
        
        return view
    }()
    
    private let storyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .testPost
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        progressView.progressTintColor = .white
        
        return progressView
    }()
    
    private let messageTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .white
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.textFieldBorder.cgColor
        textField.layer.cornerRadius = 21
        
        // Camera Icon
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 34))
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 34, height: 34))
        imageView.image = .storyCamera
        leftView.addSubview(imageView)
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        // Placeholder
        let placeholderText = "Send Message"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        
        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private let sendIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .messageIcon.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private let optionsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .moreIcon.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private let bottomStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 13
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .test
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.text = "Test user"
        label.textColor = .white
        
        return label
    }()
    
    private let postDate: UILabel = {
        let label = UILabel()
        label.text = "Test Date"
        label.textColor = .textFieldBorder
        
        return label
    }()
    
    private let textStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let leftStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.cancelIcon, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        return button
    }()
    
    private let topStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupResponse()
        viewModel.startProgress()
        bindViewModel()
        
    }
    
    private func bindViewModel() {
        viewModel.$progress.sink { time in
            self.progressBar.progress = time
        }.store(in: &cancellable)
    }
    
    @objc
    private func didTapRight() {
        viewModel.stopProgress()
        self.viewModel.showNextStories()
    }
    
    @objc
    private func didTapLeft() {
        viewModel.stopProgress()
        self.viewModel.showPreviousStories()
    }
    
    @objc
    private func didTapCancel() {
        viewModel.stopProgress()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupResponse() {
        storyImage.kf.setImage(with: URL(string: viewModel.storyModel.postImage))
        
        profileImage.kf.setImage(with: URL(string: viewModel.storyModel.profileImage))
        
        username.text = viewModel.storyModel.username
        postDate.text = viewModel.storyModel.createdAt
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .black
        
        [leftView, rightView, storyImage, progressBar, bottomStackView, topStackView].forEach(view.addSubview)
        
        [messageTextField, sendIcon, optionsIcon].forEach(bottomStackView.addArrangedSubview)
        
        [leftStackView, cancelButton].forEach(topStackView.addArrangedSubview)
        
        [profileImage, textStackView].forEach(leftStackView.addArrangedSubview)
        
        [username, postDate].forEach(textStackView.addArrangedSubview)
        
        storyImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(bottomStackView.snp.top).offset(-15)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(storyImage.snp.top).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(43)
        }
        
        messageTextField.snp.makeConstraints { make in
            make.height.equalTo(43)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(32)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        leftView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
    }
}
