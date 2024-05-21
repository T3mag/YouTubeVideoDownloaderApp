//
//  VideoScreenViewController.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 27.04.2024.
//

import UIKit

class VideoScreenViewController: UIViewController {
    let myView = VideoScreenView(frame: .zero)
    var viewModel: VideoScreenViewModel!
    init(viewModel: VideoScreenViewModel, indexPath: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        obtainVideoInfo(indexPath: indexPath)
        _ = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: false)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = myView
        myView.setupController(viewController: self)
    }
    func obtainVideoInfo(indexPath: IndexPath) {
        viewModel.obtainVideoInfoById(indexPath: indexPath)
    }
    func downloadButtonTap(videoID: String, videoTitle: String) {
        viewModel.downloadButtonTap(videoID: videoID, videoTitle: videoTitle)
        dismiss(animated: true)
    }
    @objc func updateTimer() {
        myView.setupVideoInfo(videoInfo: viewModel.getVideoInfo())
    }
}
