//
//  SearchYouTubeVideoTableViewCell.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 23.04.2024.
//

import UIKit
import YouTubeiOSPlayerHelper

class YTVideoCell: UITableViewCell {
    lazy var videoPlayerImageView: UIImageView = {
        let videoPlayer = UIImageView()
        videoPlayer.backgroundColor = .black
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.layer.cornerRadius = 20
        return videoPlayer
    }()
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    lazy var chanellTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    lazy var videoDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(videoTitleLabel)
        addSubview(videoPlayerImageView)
        addSubview(chanellTitleLabel)
        backgroundColor = .black
        setupLayout()
    }
    func setupCell(videoImageURl: URL,
                   videoTitle: String,
                   videoDescription: String,
                   chanellTitle: String,
                   videDate: String) {
        load(url: videoImageURl)
        videoTitleLabel.text = videoTitle
        chanellTitleLabel.text = chanellTitle
        var date = videDate.components(separatedBy: "T")
        videoDateLabel.text = date[0].replacingOccurrences(of: "-", with: ":")
    }
    func setupLayout() {
        addSubview(videoTitleLabel)
        addSubview(videoPlayerImageView)
        addSubview(chanellTitleLabel)
        addSubview(videoDateLabel)
        backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            videoPlayerImageView.heightAnchor.constraint(equalToConstant: (self.frame.width - 20) / 16 * 10),
            videoPlayerImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            videoPlayerImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            videoPlayerImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            videoTitleLabel.topAnchor.constraint(
                equalTo: videoPlayerImageView.bottomAnchor, constant: 10),
            videoTitleLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            videoTitleLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            chanellTitleLabel.topAnchor.constraint(
                equalTo: videoTitleLabel.bottomAnchor, constant: 5),
            chanellTitleLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            chanellTitleLabel.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            videoDateLabel.topAnchor.constraint(
                equalTo: videoTitleLabel.bottomAnchor, constant: 5),
            videoDateLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.videoPlayerImageView.image = image
                        }
                    }
                }
            }
        }
}
