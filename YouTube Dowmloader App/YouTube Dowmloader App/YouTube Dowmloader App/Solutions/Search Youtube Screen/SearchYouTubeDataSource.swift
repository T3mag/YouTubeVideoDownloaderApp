//
//  SearchYouTubeDataSource.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 23.04.2024.
//

import Foundation
import UIKit
import Combine

class SearchYouTubeDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var videos: [VideoInfo.Video] = []
    private var viewController: SearchYouTubeVC!
    private var cancelebels: Set<AnyCancellable> = []
    init(searchYouTubeVideVC: SearchYouTubeVC) {
        super.init()
        self.viewController = searchYouTubeVideVC
        setupBindings()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count + 1
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let videoCell = tableView.dequeueReusableCell(
            withIdentifier: "videoTableViewCell",
            for: indexPath) as? YTVideoCell else { fatalError() }
        guard let buttonCell = tableView.dequeueReusableCell(
            withIdentifier: "buttonTableViewCell",
            for: indexPath) as? ButtonCell else { fatalError() }
        guard let noneVideoCell = tableView.dequeueReusableCell(
            withIdentifier: "noneVideoTableViewCell",
            for: indexPath) as? NoneVideoInfoCell else { fatalError() }
        if videos.count == 0 {
            return noneVideoCell
        } else if indexPath.row == videos.count && videos.count > 0 {
            return buttonCell
        } else {
            let video: VideoInfo.Video = videos[indexPath.row]
            videoCell.setupCell(videoImageURl: URL(string: video.snippet.thumbnails.medium.url)!,
                           videoTitle: video.snippet.title.replacingOccurrences(of: "&quot;", with: ""),
                           videoDescription: video.snippet.description,
                            chanellTitle: video.snippet.channelTitle,
                                videDate: video.snippet.publishTime)
            return videoCell
        }
    }
    func setupBindings() {
        viewController.$videos
            .sink { [weak self] videos in
                self?.videos = videos
            }
            .store(in: &cancelebels)
    }
}
