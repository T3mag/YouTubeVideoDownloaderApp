//
//  CoreDataManager.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 22.05.2024.
//

import Foundation
import CoreData
import Combine

class CoreDataManager {
    static let shared = CoreDataManager()
    init () {}
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VideoCoreData")
        container.loadPersistentStores(completionHandler: {( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtaineSaveVideo() -> [Video] {
        let videoFetchRequest = Video.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "videoTitle", ascending: true)
        videoFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? viewContext.fetch(videoFetchRequest)
        return result ?? []
    }
    
    func addVideoInfo(videoID: String, videoPath: String, videoTitle: String,
                      videoDate: String, videoPreviePath: String) {
        let video = Video(context: viewContext)
        video.videoId = videoID
        video.date = videoDate
        video.videoTitle = videoTitle
        video.previewPath = videoPreviePath
        video.filePath = videoPath
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    func deleteVideoInfo(videoID: String) {
        let video = obtaineSaveVideo().first(where: {$0.videoId == videoID})
        viewContext.delete(video!)
        try? viewContext.save()
    }
}
