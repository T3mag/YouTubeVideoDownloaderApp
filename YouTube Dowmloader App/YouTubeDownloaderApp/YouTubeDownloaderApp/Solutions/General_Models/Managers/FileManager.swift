//
//  FileManager.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 22.05.2024.
//

import Foundation
import YouTubeKit

class MyFileManager {
    private let session: URLSession
    private var streamURL: URL?
    private var coreDataManager = CoreDataManager.shared
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var isDownloading = false
    
    init(with configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func removeImageFromDirectory(imageName: String) {
        let docName = "\(imageName.utf8).jpg"
        let destinationUrl = documentDirectory.appendingPathComponent(docName)
        print(destinationUrl)
        do {
            try FileManager.default.removeItem(at: destinationUrl)
            print("Successfully deleted file!")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
    func removeVideoFromDirectory(videoName: String) {
        let docName = "\(videoName.utf8).mp4"
        let destinationUrl = documentDirectory.appendingPathComponent(docName)
        print(destinationUrl)
        do {
            try FileManager.default.removeItem(at: destinationUrl)
            print("Successfully deleted file!")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
    func getAllTmpFilesList() -> [URL] {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentDirectory,
                includingPropertiesForKeys: nil
            )
            return directoryContents
        } catch {
            print(error)
        }
        return [URL]()
    }
    
    func downloadAndWriteImageInData(videoPreviewURL: String, videoName: String, videoDate: String,
                                     videoID: String, videoPath: String) {
        Task {
            do {
                self.updateBuuton(text: "Запуск работы с превью")
                let docName = "\(videoName.utf8).jpg"
                let destinationUrl = documentDirectory.appendingPathComponent(docName)
                if FileManager().fileExists(atPath: destinationUrl.path) {
                    for counter in stride(from: 10, to: 0, by: 1) {
                        self.updateBuuton(text: "Такое фото уже существует, жди\(counter)")
                    }
                    self.isDownloading = false
                    self.updateBuuton(text: "Скачать")
                } else {
                    var request = URLRequest(url: URL(string: videoPreviewURL)!)
                    request.httpMethod = "GET"
                    session.dataTask(with: request, completionHandler: { (data, response, error) in
                        if error != nil {
                            for counter in stride(from: 10, to: 0, by: 1) {
                                self.updateBuuton(text: "Ошибка, жди: \(counter)")
                            }
                            self.isDownloading = false
                            self.updateBuuton(text: "Скачать")
                        }
                        self.updateBuuton(text: "Загрузка началась!")
                        if let response = response as? HTTPURLResponse {
                            if response.statusCode == 200 {
                                DispatchQueue.main.async {
                                    if let data = data {
                                        if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic) {
                                            self.updateBuuton(text: "Превью загружено")
                                            self.coreDataManager.addVideoInfo(videoID: videoID, videoPath: videoPath, videoTitle: videoName,
                                                videoDate: videoDate, videoPreviePath: destinationUrl.absoluteString)
                                            for counter in stride(from: 10, to: 0, by: 1) {
                                                self.updateBuuton(text: "Данные записаны, подожди: \(counter)")
                                            }
                                            self.isDownloading = false
                                            self.updateBuuton(text: "Скачать")
                                        } else {
                                            for counter in stride(from: 10, to: 0, by: 1) {
                                                self.updateBuuton(text: "Ошибкаб жди: \(counter)")
                                            }
                                            self.isDownloading = false
                                            self.updateBuuton(text: "Скачать")
                                        }
                                    }
                                }
                            }
                        }
                    }).resume()
                }
            }
        }
    }
    func downloadAndWriteVideoInData(videoID: String, fileName: String, fileDate: String, videoPrevievURL: String) {
        Task {
            if isDownloading {
                return
            }
            do {
                self.updateBuuton(text: "Запрос принят")
                self.isDownloading = true
                let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)")
                let stream = try await YouTube(url: youtubeURL!).streams.filter {
                    $0.includesVideoAndAudioTrack && $0.fileExtension == .mp4
                }.highestResolutionStream()
                let streamURL = stream?.url
                let videoUrl = streamURL?.absoluteString
                let docName = "\(fileName.utf8).mp4"
                let destinationUrl = documentDirectory.appendingPathComponent(docName)
                self.updateBuuton(text: "Дириектория создана")
                if FileManager().fileExists(atPath: destinationUrl.path) {
                    for counter in stride(from: 10, to: 0, by: 1) {
                        self.updateBuuton(text: "Такое видео уже существует, жди\(counter)")
                    }
                    self.isDownloading = false
                    self.updateBuuton(text: "Скачать")
                } else {
                    var request = URLRequest(url: URL(string: videoUrl!)!)
                    request.httpMethod = "GET"
                    session.dataTask(with: request, completionHandler: { (data, response, error) in
                        if error != nil {
                            for counter in stride(from: 10, to: 0, by: 1) {
                                self.updateBuuton(text: "Ошибка, жди: \(counter)")
                            }
                            self.isDownloading = false
                            self.updateBuuton(text: "Скачать")
                        }
                        self.updateBuuton(text: "Загрузка видео началась!")
                        if let response = response as? HTTPURLResponse {
                            if response.statusCode == 200 {
                                DispatchQueue.main.async {
                                    if let data = data {
                                        if (try? data.write(
                                            to: destinationUrl, options: Data.WritingOptions.atomic)) != nil {
                                                self.updateBuuton(text: "Видео загружено")
                                                self.downloadAndWriteImageInData(videoPreviewURL: videoPrevievURL, videoName: fileName,
                                                                                 videoDate: fileDate,videoID: videoID, videoPath: destinationUrl.absoluteString)
                                        } else {
                                            for counter in stride(from: 10, to: 0, by: 1) {
                                                self.updateBuuton(text: "Ошибкаб жди: \(counter)")
                                            }
                                            self.isDownloading = false
                                            self.updateBuuton(text: "Скачать")
                                        }
                                    }
                                }
                            }
                        }
                    }).resume()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    func updateBuuton(text: String) {
        let tabBarController = TabBarController.shared
        tabBarController.setupButtonTitle(title: text)
    }
}
