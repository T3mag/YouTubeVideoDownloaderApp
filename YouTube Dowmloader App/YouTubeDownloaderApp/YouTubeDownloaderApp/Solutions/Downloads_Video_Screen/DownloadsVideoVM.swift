//
//  DownloadsVideoVM.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//

import Foundation
import Combine

class DownloadsVideoVM {
    private var coreDataManager = CoreDataManager.shared
    private var fileManager = MyFileManager(with: .default)
    @Published var downloadsVideo: [Video] = []
    
    init() {
        downloadsVideo = coreDataManager.obtaineSaveVideo()
    }
    
    func updateData() {
        downloadsVideo = coreDataManager.obtaineSaveVideo()
    }
    
    func deleteVideosFromDevice(indexPath: IndexPath) {
        let video = downloadsVideo[indexPath.row]
        fileManager.removeImageFromDirectory(imageName: video.videoTitle)
        fileManager.removeVideoFromDirectory(videoName: video.videoTitle)
        coreDataManager.deleteVideoInfo(videoID: video.videoId)
    }
}
