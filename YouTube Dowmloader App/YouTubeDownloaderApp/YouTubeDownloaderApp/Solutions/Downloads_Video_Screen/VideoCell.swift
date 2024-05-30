//
//  VideoCell.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 22.05.2024.
//

import UIKit

class VideoCell: UITableViewCell {
    var videoInfo: Video?
    lazy var videoPreView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    lazy var videoDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupColor(isBlack: Bool) {
        if isBlack {
            videoTitleLabel.textColor = .white
            videoDateLabel.textColor = .white
        } else {
            videoDateLabel.textColor = .black
            videoTitleLabel.textColor = .black
        }
    }
    func setupVideoInfo(videoInfo: Video) {
        self.videoInfo = videoInfo
        videoTitleLabel.text = videoInfo.videoTitle
        let components = videoInfo.date.components(separatedBy: "T")
        let date = components[0].replacingOccurrences(of: "-", with: ":")
        let baseUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let assetUrl = baseUrl.appendingPathComponent("\(videoInfo.videoTitle.utf8).jpg")
        let url = assetUrl
        let data: NSData = NSData(contentsOf: url) ?? NSData()
        videoPreView.image = UIImage(data: data as Data)
        videoDateLabel.text = date
    }
    func setupLayout() {
        backgroundColor = .clear
        addSubview(videoPreView)
        addSubview(videoTitleLabel)
        addSubview(videoDateLabel)
        NSLayoutConstraint.activate([
            videoPreView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            videoPreView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            videoPreView.heightAnchor.constraint(equalToConstant: 70),
            videoPreView.widthAnchor.constraint(equalToConstant: 100),
            videoPreView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            videoTitleLabel.topAnchor.constraint(equalTo: videoPreView.topAnchor, constant: 5),
            videoTitleLabel.leadingAnchor.constraint(equalTo: videoPreView.trailingAnchor, constant: 10),
            videoTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            videoDateLabel.bottomAnchor.constraint(equalTo: videoPreView.bottomAnchor, constant: -5),
            videoDateLabel.leadingAnchor.constraint(equalTo: videoPreView.trailingAnchor, constant: 10)
        ])
    }
}
