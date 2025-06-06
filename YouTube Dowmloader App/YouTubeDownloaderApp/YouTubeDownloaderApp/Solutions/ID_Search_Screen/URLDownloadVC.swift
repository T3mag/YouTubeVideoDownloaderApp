import UIKit

class URLDownloadVC: UIViewController {
    
    private let myView = URLDownloadView(frame: .zero)
    private var viewModel: URLDownloadViewModel?
    private var timer: Timer = Timer()
    private var settingsVC: SettingsViewController?
    
    init(viewModel: URLDownloadViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        myView.setupViewController(viewController: self)
        setupNavBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
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
    
    func setupYouTubeData(videoID: String, videoTitle: String, videDate: String, videoPreviewUrl: String) {
        myView.setupLayoutIfHaveData()
        myView.setupData(videoID: videoID,
                         videoTitle: videoTitle,
                         videoDate: videDate,
                         videoPreviewUrl: videoPreviewUrl)
    }
    
    func setupButtonTitle(title: String) {
        myView.setupTitle(title: title)
    }
    
    func getVideoByID(videoID: String) {
        var timerLeft = 30
        viewModel?.obtainVideoByID(videoID: videoID)
        myView.setupLayoutWhileSearching()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            timerLeft -= 1
            if self?.viewModel?.getVideoInfo() != nil {
                self?.myView.disActiveteSpinner()
                self?.myView.setupLayoutIfHaveData()
                
                let videoTitle = self?.viewModel?.getVideoInfo().items[0].snippet.title
                let videoDate = self?.viewModel?.getVideoInfo().items[0].snippet.publishedAt
                let videoPreviewURL = self?.viewModel?.getVideoInfo().items[0].snippet.thumbnails.default.url
                
                self?.myView.setupData(videoID: videoID,
                                       videoTitle: videoTitle!,
                                       videoDate: videoDate!,
                                       videoPreviewUrl: videoPreviewURL!)
                self?.timer.invalidate()
            }
            if timerLeft == 0 {
                self?.myView.disActiveteSpinner()
                self?.myView.setupLayouIfNotHaveData()
                self?.timer.invalidate()
            }
        }
    }
    
    func downloadVideo(videoId: String, videoTitle: String, videoDate: String, videoPreviewURL: String) {
        viewModel?.downloadVideo(videoID: videoId,
                                 videoTitle: videoTitle,
                                 videoDate: videoDate,
                                 videoPreviewUrl: videoPreviewURL)
    }
    
    @objc func fbButtonPressed() {
        present(SettingsViewController.shared, animated: true)
    }
    
    func setSetinngsVC(settingsVC: SettingsViewController) {
        self.settingsVC = settingsVC
    }
    
    func setupTheme(isBlack: Bool) {
        myView.setupTheme(isBlack: isBlack)
        if isBlack {
            navigationItem.rightBarButtonItem?.tintColor = .white
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
    }
}
