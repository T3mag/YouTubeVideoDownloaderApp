//
//  DownloadsVideoView.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//

import UIKit

class DownloadsVideoView: UIView {
    lazy var videoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor(red: 146/255,
                                           green: 146/255,
                                           blue: 154/255,
                                           alpha: 1)
        tableView.register(VideoCell.self, forCellReuseIdentifier: "videoCell")
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    func reloadTableView() {
        videoTableView.reloadData()
    }
    func setupLayout() {
        addSubview(videoTableView)
        NSLayoutConstraint.activate([
            videoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            videoTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            videoTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            videoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    func setupDataSourse(dataSource: DownloadsVideoDataSource) {
        videoTableView.dataSource = dataSource
        videoTableView.delegate = dataSource
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTheme(isBlack: Bool) {
        if isBlack {
            backgroundColor = .black
        } else {
            backgroundColor = .white
        }
        self.reloadInputViews()
    }
}
