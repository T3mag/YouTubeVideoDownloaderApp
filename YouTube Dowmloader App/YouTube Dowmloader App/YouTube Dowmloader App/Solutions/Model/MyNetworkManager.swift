//
//  NetworkManager.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 21.04.2024.
//

import Foundation
import UIKit

class MyNetworkManager {
    private let session: URLSession
    private let apiKey = "AIzaSyDprjxV0rFg0OMwkn4TpSfijbV9GBeHa-c"
    private var imageForDownload = UIImage()
    lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
    init(with configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    func obtainVideoByString(userRequestString: String) async throws -> VideoInfo {
        let mainDataForRequest = "https://youtube.googleapis.com/youtube/v3/search?part=snippet"
        let additionalDataForRequest = "&maxResults=\(30)&q=" + userRequestString + "&regionCode=RU&key=" + apiKey
        let urlString = mainDataForRequest + additionalDataForRequest
        guard let url = URL(string: urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError() }
        var urlRequset = URLRequest(url: url)
        urlRequset.httpMethod = "GET"
        let responseData = try await session.data(for: urlRequset)
        return try jsonDecoder.decode(VideoInfo.self, from: responseData.0)
    }
    func obtainDownloadImage(imageUrl: URL) -> UIImage {
        load(url: imageUrl)
        return imageForDownload
    }
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self!.imageForDownload = image
                    }
                }
            }
        }
    }
}
