//
//  SettingsViewController.swift
//  YouTubeDownloaderApp
//
//  Created by Артур Миннушин on 27.05.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    static let shared = SettingsViewController(settingsViewModel: SetiingsViewModel())
    private var settingsView = SettingsView(frame: .zero)
    private var viewModel: SetiingsViewModel?
    
    init(settingsViewModel: SetiingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = settingsViewModel
        modalPresentationStyle = .overFullScreen
        settingsView.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = settingsView
    }
    
    func chageTheme(isBlack: Bool) {
        viewModel?.changeColor(isBlack: isBlack)
    }
}
