import UIKit

class URLDownloadVC: UIViewController {
    let myView = URLDownloadView(frame: .zero)
    override func loadView() {
        self.view = myView
        setupNavBar()
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
    @objc func fbButtonPressed() {
        print("Share to fb")
    }
}
