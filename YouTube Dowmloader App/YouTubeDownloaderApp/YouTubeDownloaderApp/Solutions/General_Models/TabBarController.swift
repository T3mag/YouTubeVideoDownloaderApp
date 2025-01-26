//
//  TabBarController.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//

import UIKit

class TabBarController: UITabBarController {
    static var shared = TabBarController()
    private var uRLDownloadsVC: URLDownloadVC!
    private var searchYouTubeVC: SearchYouTubeVC!
    private var downloadsVideoVC: DownloadsVideoVC!
    private var URLDownloadVideoVM = URLDownloadViewModel()
    private var searchYouTubeVM = SearchYouTubeVM()
    private var downloadsVideoVM = DownloadsVideoVM()
    private var isBlack = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        uRLDownloadsVC = URLDownloadVC(viewModel: URLDownloadVideoVM)
        searchYouTubeVC = SearchYouTubeVC(searchScreenViewModel: searchYouTubeVM)
        downloadsVideoVC = DownloadsVideoVC(downloadsVideoViewModel: downloadsVideoVM)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabBar() {
        uRLDownloadsVC.tabBarItem.title = "Скачать по URL"
        uRLDownloadsVC.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        searchYouTubeVC.tabBarItem.title = "Поиск по видео"
        searchYouTubeVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsVideoVC.tabBarItem.title = "Ваши видео"
        downloadsVideoVC.tabBarItem.image = UIImage(systemName: "folder")
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .clear
        self.viewControllers = [
            UINavigationController(rootViewController: uRLDownloadsVC),
            UINavigationController(rootViewController: searchYouTubeVC),
            UINavigationController(rootViewController: downloadsVideoVC)
        ]
    }
    
    func setupURLDownloadVC(videoID: String, videoTitle: String, videoDate: String, videoPreviewUrl: String) {
        uRLDownloadsVC.setupYouTubeData(videoID: videoID,
                                        videoTitle: videoTitle,
                                        videDate: videoDate,
                                        videoPreviewUrl: videoPreviewUrl)
    }
    
    func setupButtonTitle(title: String) {
        uRLDownloadsVC.setupButtonTitle(title: title)
    }
    
    func setupColor(isBlack: Bool) {
        if isBlack {
            self.tabBar.tintColor = .white
        } else {
            self.tabBar.tintColor = .black
        }
        var counter = 0
        while counter < 3 {
            downloadsVideoVC.setupTheme(isBlack: isBlack)
            uRLDownloadsVC.setupTheme(isBlack: isBlack)
            searchYouTubeVC.setupTheme(isBlack: isBlack)
            counter += 1
        }
    }
}
