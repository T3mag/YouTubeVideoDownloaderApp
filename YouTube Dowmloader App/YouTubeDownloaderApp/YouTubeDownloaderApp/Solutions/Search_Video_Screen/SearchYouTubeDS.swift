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
    private var videos: [VideoInfoFromSearch.Video] = []
    private var viewController: SearchYouTubeVC!
    private var cancelebels: Set<AnyCancellable> = []
    private var isSearching: Bool = false
    private var indexPath: IndexPath?
    private var isBlack = true
    init(searchYouTubeVideVC: SearchYouTubeVC) {
        super.init()
        self.viewController = searchYouTubeVideVC
        viewController.$videos
            .sink { [weak self] videos in
                self?.videos = videos
            }
            .store(in: &cancelebels)
        viewController.$isSearching
            .sink { [weak self] isSearching in
                self?.isSearching = isSearching
            }
            .store(in: &cancelebels)
    }
    func setupIsBlack(isBlack: Bool) {
        self.isBlack = isBlack
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return 1
        } else {
            return videos.count + 1
        }
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let isSearchinfCell = tableView.dequeueReusableCell(
            withIdentifier: "isSearchingTableViewCell",
            for: indexPath) as? IsSearchingCell else { fatalError() }
        isSearchinfCell.disActiveteSpinner()
        guard let videoCell = tableView.dequeueReusableCell(
            withIdentifier: "videoTableViewCell",
            for: indexPath) as? YTVideoCell else { fatalError() }
        guard let buttonCell = tableView.dequeueReusableCell(
            withIdentifier: "buttonTableViewCell",
            for: indexPath) as? ButtonCell else { fatalError() }
        guard let noneVideoCell = tableView.dequeueReusableCell(
            withIdentifier: "noneVideoTableViewCell",
            for: indexPath) as? NoneVideoInfoCell else { fatalError() }
        isSearchinfCell.setupColor(isBlack: isBlack)
        videoCell.setupColor(isBlack: isBlack)
        buttonCell.setupColor(isBlack: isBlack)
        noneVideoCell.setupColor(isBlack: isBlack)
        if isSearching && videos.count <= 1 {
            isSearchinfCell.activateSpiner()
            return isSearchinfCell
        } else if videos.count == 0 {
            return noneVideoCell
        } else if indexPath.row == videos.count && videos.count > 0 {
            self.indexPath = indexPath
            buttonCell.delegate = tableView.superview as? any AddNewVideo
            buttonCell.setupCell(nextPageToken: viewController.getNextPageToken())
            return buttonCell
        } else if isSearching && videos.count > 1 {
            isSearchinfCell.activateSpiner()
            return isSearchinfCell
        } else {
            let video: VideoInfoFromSearch.Video = videos[indexPath.row]
            videoCell.setupCell(videoImageURl: URL(string: video.snippet.thumbnails.medium.url)!,
                           videoTitle: video.snippet.title.replacingOccurrences(of: "&quot;", with: ""),
                           videoDescription: video.snippet.description,
                            chanellTitle: video.snippet.channelTitle,
                                videDate: video.snippet.publishTime)
            return videoCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video: VideoInfoFromSearch.Video = videos[indexPath.row]
        viewController.presentVideoInfoScreen(indexPath: indexPath,
                                              videoPreViewURL: video.snippet.thumbnails.default.url)
    }
    func getIndexPath() -> IndexPath {
        return self.indexPath ?? IndexPath()
    }
}
