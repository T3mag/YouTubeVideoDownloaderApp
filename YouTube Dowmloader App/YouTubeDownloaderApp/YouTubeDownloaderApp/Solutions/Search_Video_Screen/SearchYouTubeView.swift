//
//  SearchYouTubeView.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 05.04.2024.
//

import UIKit

protocol AddNewVideo: AnyObject {
    func addDataWithUserString(nextPageToken: String)
}

class SearchYouTubeView: UIView {
    var viewController: SearchYouTubeVC!
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [NSAttributedString.Key.foregroundColor:
                UIColor(red: 146/255,
                        green: 146/255,
                        blue: 154/255,
                        alpha: 1)])
        textField.textColor = UIColor(red: 146/255,
                                      green: 146/255,
                                      blue: 154/255,
                                      alpha: 1)
        textField.backgroundColor = UIColor(red: 28/255,
                                            green: 27/255,
                                            blue: 29/255,
                                            alpha: 1)
        textField.keyboardType = .webSearch
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = textFieldSearchIconView
        textField.delegate = self
        return textField
    }()
    lazy var searchVideosTablewView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(YTVideoCell.self,
                           forCellReuseIdentifier: "videoTableViewCell")
        tableView.register(ButtonCell.self,
                           forCellReuseIdentifier: "buttonTableViewCell")
        tableView.register(NoneVideoInfoCell.self,
                           forCellReuseIdentifier: "noneVideoTableViewCell")
        tableView.register(IsSearchingCell.self,
                           forCellReuseIdentifier: "isSearchingTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    lazy var textFieldSearchIconView: UIView = {
        let findTextFieldImageView = UIImageView(frame: CGRect(x: 8.0,
                                                               y: 10.0,
                                                               width: 20.0,
                                                               height: 20.0))
        let image = UIImage(systemName: "magnifyingglass")
        findTextFieldImageView.image = image
        findTextFieldImageView.contentMode = .scaleAspectFit
        findTextFieldImageView.tintColor = .gray
        findTextFieldImageView.backgroundColor = .clear
        let findTextFieldView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 35,
                                                     height: 40))
        findTextFieldView.addSubview(findTextFieldImageView)
        findTextFieldView.backgroundColor = .clear
        return findTextFieldView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        addSubview(searchTextField)
        addSubview(searchVideosTablewView)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            searchVideosTablewView.topAnchor.constraint(
                equalTo: searchTextField.bottomAnchor, constant: 10),
            searchVideosTablewView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchVideosTablewView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchVideosTablewView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    func reloadData() {
        searchVideosTablewView.reloadData()
    }
    func scrollFromindexPath(indexPath: IndexPath) {
        searchVideosTablewView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    func setupDataSource(dataSource: SearchYouTubeDataSource) {
        searchVideosTablewView.delegate = dataSource
        searchVideosTablewView.dataSource = dataSource
    }
    func setupTheme(isBlack: Bool) {
        if isBlack {
            backgroundColor = .black
            self.reloadInputViews()
        } else {
            backgroundColor = .white
            self.reloadInputViews()
        }
    }
}
extension SearchYouTubeView: AddNewVideo {
    func addDataWithUserString(nextPageToken: String) {
        viewController.addDataWithUserString(nextPageToken: nextPageToken)
    }
}

extension SearchYouTubeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            viewController.obtainNewDataWithUserString(userString: textField.text!)
        }
        return true
    }
}
