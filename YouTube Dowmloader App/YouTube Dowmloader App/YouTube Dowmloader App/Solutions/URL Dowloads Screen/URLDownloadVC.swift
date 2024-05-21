import UIKit

class URLDownloadVC: UIViewController {
    private let myView = URLDownloadView(frame: .zero)
    private var viewModel: URLDownloadViewModel?
    private var timer: Timer = Timer()
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
    func setupYouTubeData(videoID: String, videoTitle: String) {
        myView.setupLayoutIfHaveData()
        myView.setupData(videoID: videoID, videoTitle: videoTitle)
    }
    func getVideoByID(videoID: String) {
        var timerLeft = 30
        viewModel?.obtainVideoByID(videoID: videoID)
        myView.setupLayoutWhileSearching()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            print(timerLeft)
            timerLeft -= 1
            if self?.viewModel?.getVideoInfo() != nil {
                self?.myView.disActiveteSpinner()
                self?.myView.setupLayoutIfHaveData()
                let vide0ID = self?.viewModel?.getVideoInfo().items[0].id
                let videoTitle = self?.viewModel?.getVideoInfo().items[0].snippet.title
                self?.myView.setupData(videoID: videoID, videoTitle: videoTitle!)
                self?.timer.invalidate()
            }
            if timerLeft == 0 {
                self?.myView.disActiveteSpinner()
                self?.myView.setupLayouIfNotHaveData()
                self?.timer.invalidate()
            }
        }
    }
    @objc func fbButtonPressed() {
        print("Share to fb")
    }
}
