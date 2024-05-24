//
//  Video+CoreDataProperties.swift
//  YouTubeDownloaderApp
//
//  Created by Артур Миннушин on 22.05.2024.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var date: String
    @NSManaged public var filePath: String
    @NSManaged public var previewPath: String
    @NSManaged public var videoTitle: String
    @NSManaged public var videoId: String

}

extension Video : Identifiable {

}
