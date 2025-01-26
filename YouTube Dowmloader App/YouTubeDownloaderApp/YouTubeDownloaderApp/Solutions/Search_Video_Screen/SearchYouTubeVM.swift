//
//  SearcvYouTubeVM.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//
import UIKit
import Foundation
import Combine

class SearchYouTubeVM {
    var networkManager = MyNetworkManager.shared
    private var cancelebels: Set<AnyCancellable> = []
    @Published var videos: [VideoInfoFromSearch.Video] = []
    
    init() {
        networkManager.$videos.sink { [weak self] videos in
            self?.videos = videos
        }
        .store(in: &cancelebels)
    }
    
    func getCountVideos() -> Int {
        return videos.count
    }
    
    func obtainNewDataWithUserString(userString: String) {
        networkManager.obtainNewDataWithUserString(userString: userString)
    }
    
    func addDataWithUserString(nextPageToken: String) {
        networkManager.addDataWithUserString(nextPageToken: nextPageToken)
    }
    
    func obtainImageForUrl(imageUrl: URL) -> UIImage {
        return networkManager.obtainDownloadImage(imageUrl: imageUrl)
    }
    
    func getNextPageToken() -> String {
        return networkManager.getPageToken()
    }
}
