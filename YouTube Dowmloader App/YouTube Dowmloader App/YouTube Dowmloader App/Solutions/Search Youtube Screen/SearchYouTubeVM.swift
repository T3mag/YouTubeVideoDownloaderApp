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
    var networkManager = MyNetworkManager(with: .default)
    @Published var videos: [VideoInfo.Video] = []
    func obtainDataWithUserString(userString: String) {
        Task {
            do {
                videos = []
                let jsonDecodingData = try await networkManager.obtainVideoByString(userRequestString: userString)
                for item in jsonDecodingData.items where item.id.videoId != nil {
                    self.videos.append(item)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    func obtainImageForUrl(imageUrl: URL) -> UIImage {
        return networkManager.obtainDownloadImage(imageUrl: imageUrl)
    }
}
