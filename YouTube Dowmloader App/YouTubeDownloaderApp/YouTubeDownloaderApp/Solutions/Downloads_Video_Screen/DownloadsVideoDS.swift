//
//  DownloadsVideoDataSource.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 22.05.2024.
//

import Foundation
import UIKit
import Combine
import AVFoundation
import AVKit

class DownloadsVideoDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var videos: [Video] = []
    private var viewController: DownloadsVideoVC!
    private var cancelebels: Set<AnyCancellable> = []
    private var isBlack = true
    
    init(viewController: DownloadsVideoVC) {
        super.init()
        self.viewController = viewController
        viewController.$videos.sink { [weak self] videos in
            self?.videos = videos
        }.store(in: &cancelebels)
    }
    
    func setIsBlack(isBlack: Bool) {
        self.isBlack = isBlack
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let videoCell = tableView.dequeueReusableCell(
            withIdentifier: "videoCell",
            for: indexPath) as? VideoCell else { fatalError() }
        let video: Video = videos[indexPath.row]
        videoCell.setupVideoInfo(videoInfo: video)
        videoCell.setupColor(isBlack: isBlack)
        return videoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        let baseUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let assetUrl = baseUrl.appendingPathComponent("\(video.videoTitle).mp4")
        let url = assetUrl
        let avAssest = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: avAssest)
        let player = AVPlayer(playerItem: playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.viewController.present(playerViewController, animated: true, completion: {
            player.play()
        })
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewController.deleteVideo(indexPath: indexPath)
        }
    }
}
