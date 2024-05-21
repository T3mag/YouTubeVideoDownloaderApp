//
//  VideoScreenView.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 27.04.2024.
//

import UIKit
import YouTubeiOSPlayerHelper

class VideoScreenView: UIView {
    private var videoInfo: VideoInfoFromIdentifier?
    private var viewController: VideoScreenViewController?
    private var videoID: String?
    lazy var videoPlayeView: YTPlayerView = {
        let ytPlayerView = YTPlayerView()
        ytPlayerView.translatesAutoresizingMaskIntoConstraints = false
        return ytPlayerView
    }()
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    lazy var videoDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    lazy var videoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 100
        return label
    }()
    lazy var chanelTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    lazy var downloadVideoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить видео", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        button.layer.cornerRadius = 20
        let action = UIAction {[weak self] _ in
            self?.downloadButtonTap()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupLayout()
        setupSwipe()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupVideoInfo(videoInfo: VideoInfoFromIdentifier) {
        self.videoInfo = videoInfo
        videoPlayeView.load(withVideoId: videoInfo.items[0].id)
        videoTitleLabel.text = videoInfo.items[0].snippet.title
        var date = videoInfo.items[0].snippet.publishedAt.components(separatedBy: "T")[0]
        date = date.replacingOccurrences(of: "-", with: ":")
        let newDate = date.components(separatedBy: ":")
        videoDateLabel.text = date
        videoDescriptionLabel.text = videoInfo.items[0].snippet.description
        chanelTitleLabel.text = videoInfo.items[0].snippet.channelTitle
        self.reloadInputViews()
        self.videoID = videoInfo.items[0].id
    }
    func setupController(viewController: VideoScreenViewController) {
        self.viewController = viewController
    }
    func setupScrollView() {
        addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        backgroundColor = .black
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    func setupLayout() {
        addSubview(videoPlayeView)
        addSubview(videoTitleLabel)
        addSubview(videoDateLabel)
        addSubview(videoDescriptionLabel)
        addSubview(chanelTitleLabel)
        addSubview(downloadVideoButton)
        NSLayoutConstraint.activate([
            videoPlayeView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor, constant: 10),
            videoPlayeView.heightAnchor.constraint(equalToConstant: 200),
            videoPlayeView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            videoPlayeView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            videoTitleLabel.topAnchor.constraint(
                equalTo: videoPlayeView.bottomAnchor, constant: 10),
            videoTitleLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 10),
            videoTitleLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -10),
            videoDateLabel.topAnchor.constraint(
                equalTo: videoTitleLabel.bottomAnchor, constant: 10),
            videoDateLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 10),
            chanelTitleLabel.topAnchor.constraint(
                equalTo: videoDateLabel.bottomAnchor, constant: 10),
            chanelTitleLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 10),
            videoDescriptionLabel.topAnchor.constraint(
                equalTo: chanelTitleLabel.bottomAnchor, constant: 10),
            videoDescriptionLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 10),
            videoDescriptionLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -10),
            downloadVideoButton.topAnchor.constraint(
                equalTo: videoDescriptionLabel.bottomAnchor, constant: 40),
            downloadVideoButton.centerXAnchor.constraint(
                equalTo: self.contentView.centerXAnchor, constant: 10),
            downloadVideoButton.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor, constant: -10),
            downloadVideoButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
        ])
    }
    func downloadButtonTap() {
        guard videoID != nil else { return }
        guard videoTitleLabel.text != nil else { return }
        self.viewController?.downloadButtonTap(videoID: videoID!,
                                               videoTitle: videoTitleLabel.text!)
    }
}

extension VideoScreenView {
    func setupSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.dismisController))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }
    @objc func dismisController() {
        viewController?.dismiss(animated: true)
    }
}
