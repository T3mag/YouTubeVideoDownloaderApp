//
//  SetiingsViewModel.swift
//  YouTubeDownloaderApp
//
//  Created by Артур Миннушин on 27.05.2024.
//

import Foundation

class SetiingsViewModel {
    private var tabBarController = TabBarController.shared
    
    func changeColor(isBlack: Bool) {
        tabBarController.setupColor(isBlack: isBlack)
    }
}
