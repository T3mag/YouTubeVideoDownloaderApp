//
//  DownloadsVideoVC.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//

import UIKit
import Combine

class DownloadsVideoVC: UIViewController {
    private let myView = DownloadsVideoView(frame: .zero)
    private var viewModel: DownloadsVideoVM!
    private var cancelebels: Set<AnyCancellable> = []
    private var dataSource: DownloadsVideoDataSource!
    private var settingsVC: SettingsViewController?
    
    @Published var videos: [Video] = []
    
    init(downloadsVideoViewModel: DownloadsVideoVM) {
        super.init(nibName: nil, bundle: nil)
        viewModel = downloadsVideoViewModel
        dataSource = DownloadsVideoDataSource(viewController: self)
        myView.setupDataSourse(dataSource: dataSource)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.updateData()
        myView.reloadTableView()
    }
    
    func setupBindings() {
        viewModel.$downloadsVideo.sink { [weak self] videos in
            self?.videos = videos
        }
        .store(in: &cancelebels)
    }
    
    func setupNavBar() {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(fbButtonPressed)
        )
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "YouTubeDownloaderlogo"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func fbButtonPressed() {
        present(SettingsViewController.shared, animated: true)
    }
    
    func deleteVideo(indexPath: IndexPath) {
        viewModel.deleteVideosFromDevice(indexPath: indexPath)
        viewModel.updateData()
        myView.reloadTableView()
    }
    
    func setSetinngsVC(settingsVC: SettingsViewController) {
        self.settingsVC = settingsVC
    }
    
    func setupTheme(isBlack: Bool) {
        if isBlack {
            navigationItem.rightBarButtonItem?.tintColor = .white
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
        myView.setupTheme(isBlack: isBlack)
        dataSource.setIsBlack(isBlack: isBlack)
        myView.reloadTableView()
    }
}
