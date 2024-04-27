//
//  SearchYouTubeVC.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//

import UIKit
import Combine

class SearchYouTubeVC: UIViewController {
    private let searchYouTubeView = SearchYouTubeView(frame: .zero)
    private var searchYouTubeVideoVM: SearchYouTubeVM!
    private var searchYouTubeVideoTableViewDataSource: SearchYouTubeDataSource!
    private var cancelebels: Set<AnyCancellable> = []
    @Published var videos: [VideoInfo.Video] = []
    init(searchScreenViewModel: SearchYouTubeVM) {
        super.init(nibName: nil, bundle: nil)
        searchYouTubeVideoVM = searchScreenViewModel
        searchYouTubeVideoTableViewDataSource = SearchYouTubeDataSource(searchYouTubeVideVC: self)
        searchYouTubeView.setupDataSource(dataSource: searchYouTubeVideoTableViewDataSource)
        setupBindings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        searchYouTubeView.viewController = self
        setupNavBar()
    }
    override func loadView() {
        view = searchYouTubeView
    }
}

extension SearchYouTubeVC {
    func setupNavBar() {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: nil
        )
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "YouTubeDownloaderlogo"), for: .normal)
        button.addTarget(self, action: #selector(fbButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    @objc func fbButtonPressed() {
        print("Share to fb")
    }
    func obtainDataWithUserString(userString: String) {
        searchYouTubeVideoVM.obtainDataWithUserString(userString: userString)
        _ = Timer.scheduledTimer(timeInterval: 2.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: false)
    }
    func obtainImageForUrl(imageUrl: URL) -> UIImage {
        return searchYouTubeVideoVM.obtainImageForUrl(imageUrl: imageUrl)
    }
    @objc func updateTimer() {
        searchYouTubeView.reloadData()
    }
    func setupBindings() {
        searchYouTubeVideoVM.$videos
            .sink { [weak self] videos in
                self?.videos = videos
            }
            .store(in: &cancelebels)
    }
}
