import Foundation
import Combine

class URLDownloadViewModel {
    private let networkManager = MyNetworkManager.shared
    private var videoInfo: VideoInfoFromIdentifier?
    private var cancelebels: Set<AnyCancellable> = []
    
    init() {
        networkManager.$videoInfo.sink { [weak self] videoInfo in
            self?.videoInfo = videoInfo
        }.store(in: &cancelebels)
        print(extractYoutubeIdFromLink(link: "DW_3fuu1qjk"))
    }
    func obtainVideoByID(videoID: String) {
        networkManager.obtainVideoInfoByID(videoId: videoID)
    }
    func getVideoInfo() -> VideoInfoFromIdentifier {
        return videoInfo!
    }
    func extractYoutubeIdFromLink(link: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }
}
