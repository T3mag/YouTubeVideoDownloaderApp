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
    private var viewModel: SearchYouTubeVM!
    private var searchYouTubeVideoTableViewDataSource: SearchYouTubeDataSource!
    private var cancelebels: Set<AnyCancellable> = []
    private var timer = Timer()
    @Published var videos: [VideoInfoFromSearch.Video] = []
    @Published var isSearching: Bool = false
    init(searchScreenViewModel: SearchYouTubeVM) {
        super.init(nibName: nil, bundle: nil)
        viewModel = searchScreenViewModel
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
    func presentVideoInfoScreen(indexPath: IndexPath) {
        let videoInfoViewModel = VideoScreenViewModel()
        let videoViewViewController = VideoScreenViewController(viewModel: videoInfoViewModel, indexPath: indexPath)
        videoViewViewController.modalPresentationStyle = .overFullScreen
        navigationController!.present(videoViewViewController, animated: true)
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
    func obtainNewDataWithUserString(userString: String) {
        var timerLeft = 30
        isSearching = true
        searchYouTubeView.reloadData()
        viewModel.obtainNewDataWithUserString(userString: userString)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            timerLeft = -1
            if self?.viewModel.getCountVideos() != 0 {
                self?.isSearching = false
                self?.searchYouTubeView.reloadData()
                self?.timer.invalidate()
            }
            if timerLeft == 0 {
                self?.isSearching = false
                self?.searchYouTubeView.reloadData()
                self?.timer.invalidate()
            }
        }
    }
    func addDataWithUserString(nextPageToken: String) {
        var timerLeft = 30
        isSearching = true
        searchYouTubeView.reloadData()
        viewModel.addDataWithUserString(nextPageToken: nextPageToken)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            timerLeft = -1
            if self?.viewModel.getCountVideos() != 0 {
                self?.isSearching = false
                self?.searchYouTubeView.reloadData()
                self?.timer.invalidate()
                self?.scrollTableView()
            }
            if timerLeft == 0 {
                self?.isSearching = false
                self?.searchYouTubeView.reloadData()
                self?.timer.invalidate()
            }
        }
    }
    func scrollTableView() {
        searchYouTubeView.scrollFromindexPath(indexPath: searchYouTubeVideoTableViewDataSource.getIndexPath())
    }
    func obtainImageForUrl(imageUrl: URL) -> UIImage {
        return viewModel.obtainImageForUrl(imageUrl: imageUrl)
    }
    func getNextPageToken() -> String {
        return viewModel.getNextPageToken()
    }
    func scrollFromIndexPath(indexPath: IndexPath) {
        searchYouTubeView.scrollFromindexPath(indexPath: indexPath)
    }
    @objc func updateTimer() {
        print(viewModel.getCountVideos())
        if viewModel.getCountVideos() != 0 {
            timer.invalidate()
            searchYouTubeView.reloadData()
        }
    }
    func setupBindings() {
        viewModel.$videos
            .sink { [weak self] videos in
                self?.videos = videos
            }
            .store(in: &cancelebels)
    }
}
