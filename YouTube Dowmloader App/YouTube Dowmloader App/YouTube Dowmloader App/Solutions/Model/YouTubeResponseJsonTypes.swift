//
//  YouTubeResponseJsonTypes.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 22.04.2024.
//

import Foundation

struct VideoInfo: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let pageInfo: PageInfo
    let items: [Video]
    struct Thumbnails: Codable {
        let `default`: ImgInfo
        let medium: ImgInfo
        let high: ImgInfo
    }
    struct ImgInfo: Codable {
        let url: String
        let width: Int?
        let height: Int?
    }
    struct Snippet: Codable {
        let publishedAt: String
        let channelId: String
        let title: String
        let description: String
        let thumbnails: Thumbnails
        let channelTitle: String
        let publishTime: String
    }
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }
    struct VideoId: Codable {
        let kind: String
        let videoId: String?
    }
    struct Video: Codable {
        let kind: String
        let etag: String
        let id: VideoId
        let snippet: Snippet
    }
}