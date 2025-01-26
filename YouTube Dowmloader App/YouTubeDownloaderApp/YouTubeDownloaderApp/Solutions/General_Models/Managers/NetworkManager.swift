//
//  NetworkManager.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 21.04.2024.
//

import Foundation
import UIKit
import Combine

class MyNetworkManager {
    static let shared = MyNetworkManager(with: .default)
    private let session: URLSession
    private let apiKey = "AIzaSyB_toFoqCkMASgYn1Ri5bieWn4K_3MuLng"
    private var imageForDownload = UIImage()
    private var userRequestString: String?
    private var nextPageToken: String?
    
    @Published var videos: [VideoInfoFromSearch.Video] = []
    @Published var videoInfo: VideoInfoFromIdentifier?
    
    lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    init(with configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func getNewVideoByString(userString: String) async throws -> VideoInfoFromSearch {
        userRequestString = userString
        let mainDataForRequest = "https://youtube.googleapis.com/youtube/v3/search?part=snippet"
        let additionalDataForRequest = "&maxResults=\(25)&q="+(userRequestString ??  "")+"&regionCode=RU&key="+apiKey
        let urlString = mainDataForRequest + additionalDataForRequest
        guard let url = URL(string: urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError() }
        var urlRequset = URLRequest(url: url)
        urlRequset.httpMethod = "GET"
        let responseData = try await session.data(for: urlRequset)
        return try jsonDecoder.decode(VideoInfoFromSearch.self, from: responseData.0)
    }
    
    func getAdditionalVidepByToken(nextPageToken: String) async throws -> VideoInfoFromSearch {
        let mainDataForRequest = "https://youtube.googleapis.com/youtube/v3/search?part=snippet"
        let oneAdditionalDataForRequest = "&maxResults=\(25)&pageToken=" + nextPageToken
        let twoAdditionalDataForRequest = "&q=" + (userRequestString ?? "") + "&regionCode=RU&key=" + apiKey
        let urlString = mainDataForRequest + oneAdditionalDataForRequest + twoAdditionalDataForRequest
        guard let url = URL(string: urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError() }
        var urlRequset = URLRequest(url: url)
        urlRequset.httpMethod = "GET"
        let responseData = try await session.data(for: urlRequset)
        return try jsonDecoder.decode(VideoInfoFromSearch.self, from: responseData.0)
    }
    
    func getVideoInfoById(videoId: String) async throws -> VideoInfoFromIdentifier {
        let mainStringResponse = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet"
        let additionalStringResponse = "&id=\(videoId)&key=\(apiKey)"
        let urlString = mainStringResponse + additionalStringResponse
        guard let url = URL(string: urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError() }
        var urlRequset = URLRequest(url: url)
        urlRequset.httpMethod = "GET"
        let responseData = try await session.data(for: urlRequset)
        return try jsonDecoder.decode(VideoInfoFromIdentifier.self, from: responseData.0)
    }
    
    func obtainVideoInfoByID(videoId: String) {
        videoInfo = nil
        Task {
            do {
                let jsonDecodingData = try await getVideoInfoById(videoId: videoId)
                videoInfo = jsonDecodingData
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func obtainNewDataWithUserString(userString: String) {
        Task {
            do {
                videos = []
                let jsonDecodingData = try await getNewVideoByString(userString: userString)
                self.nextPageToken = jsonDecodingData.nextPageToken
                for item in jsonDecodingData.items where item.id.videoId != nil {
                    self.videos.append(item)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func addDataWithUserString(nextPageToken: String) {
        Task {
            do {
                let jsonDecodingData = try await getAdditionalVidepByToken(nextPageToken: nextPageToken)
                self.nextPageToken = jsonDecodingData.nextPageToken
                for item in jsonDecodingData.items where item.id.videoId != nil {
                    self.videos.append(item)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

extension MyNetworkManager {
    func getPageToken() -> String {
        return nextPageToken ?? ""
    }
    
    func obtainDownloadImage(imageUrl: URL) -> UIImage {
        loadVideoImageForCell(url: imageUrl)
        return imageForDownload
    }
    
    func loadVideoImageForCell(url: URL) {
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
