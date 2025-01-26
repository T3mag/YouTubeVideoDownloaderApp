//
//  VideoScreenViewModel.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 28.04.2024.
//

import Foundation
import Combine

class VideoScreenViewModel {
    private var networkManager = MyNetworkManager.shared
    private var cancelebels: Set<AnyCancellable> = []
    private var videos: [VideoInfoFromSearch.Video] = []
    private var videoInfo: VideoInfoFromIdentifier?
    private var mainTabBarController: TabBarController = TabBarController.shared
    
    init() {
        networkManager.$videos.sink { [weak self] videos in
            self?.videos = videos
        } .store(in: &cancelebels)
        networkManager.$videoInfo.sink { [weak self] videoInfo in
            self?.videoInfo = videoInfo
        }
        .store(in: &cancelebels)
    }
    
    func obtainVideoInfoById(indexPath: IndexPath) {
        let videoId = videos[indexPath.row].id.videoId
        networkManager.obtainVideoInfoByID(videoId: videoId!)
    }
    
    func getVideoInfo() -> VideoInfoFromIdentifier {
        return videoInfo!
    }
    
    func downloadButtonTap(videoID: String, videoTitle: String, videoDate: String, videoPreviewUrl: String) {
        mainTabBarController.selectedIndex = 0
        mainTabBarController.setupURLDownloadVC(videoID: videoID,videoTitle: videoTitle,
                                                videoDate: videoDate, videoPreviewUrl: videoPreviewUrl)
    }
}
