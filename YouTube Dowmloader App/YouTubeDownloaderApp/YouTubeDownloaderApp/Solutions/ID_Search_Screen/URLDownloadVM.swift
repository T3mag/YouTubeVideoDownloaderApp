import Foundation
import Combine
import YouTubeKit

class URLDownloadViewModel {
    private let networkManager = MyNetworkManager.shared
    private let fileManager = MyFileManager(with: .default)
    private var videoInfo: VideoInfoFromIdentifier?
    private var cancelebels: Set<AnyCancellable> = []
    
    init() {
        networkManager.$videoInfo.sink { [weak self] videoInfo in
            self?.videoInfo = videoInfo
        }.store(in: &cancelebels)
    }
    
    func obtainVideoByID(videoID: String) {
        networkManager.obtainVideoInfoByID(videoId: videoID)
    }
    
    func getVideoInfo() -> VideoInfoFromIdentifier {
        return videoInfo!
    }
    
    func downloadVideo(videoID: String, videoTitle: String, videoDate: String, videoPreviewUrl: String) {
        fileManager.downloadAndWriteVideoInData(videoID: videoID,
                                                fileName: videoTitle,
                                                fileDate: videoDate,
                                                videoPrevievURL: videoPreviewUrl)
    }
}
