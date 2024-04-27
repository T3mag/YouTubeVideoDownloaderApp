//
//  URLDownloadView.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 03.04.2024.
//

import UIKit

class URLDownloadView: UIView {
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "С подключнием, Username"
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать в приложение для поиска и скачивания c YouTube!" +
        " Для того что-бы тебе скачать видео тебе нужно иметь ссылку на видео с YouTube." +
        " Если у тебя ее нет, то найди его в строеном поискове. Приятоного пользования!"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 6
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var urlSearchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [NSAttributedString.Key.foregroundColor:
                UIColor(red: 146/255, green: 146/255, blue: 154/255, alpha: 1)]
            )
        textField.keyboardType = .URL
        textField.textColor = UIColor(red: 146/255, green: 146/255, blue: 154/255, alpha: 1)
        textField.backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = textFieldSearchIconView
        return textField
    }()
    lazy var videoView: UIView = {
        var view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var videoTextLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тут будет название видео"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    lazy var textFieldSearchIconView: UIView = {
        let findTextFieldImageView = UIImageView(frame: CGRect(x: 8.0, y: 10.0, width: 20.0, height: 20.0))
        let image = UIImage(systemName: "magnifyingglass")
        findTextFieldImageView.image = image
        findTextFieldImageView.contentMode = .scaleAspectFit
        findTextFieldImageView.tintColor = .gray
        findTextFieldImageView.backgroundColor = .clear
        let findTextFieldView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        findTextFieldView.addSubview(findTextFieldImageView)
        findTextFieldView.backgroundColor = .clear
        return findTextFieldView
    }()
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        button.setTitle("Скачать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        addSubview(headingLabel)
        addSubview(subtitleLabel)
        addSubview(urlSearchTextField)
        addSubview(videoView)
        addSubview(videoTextLabel)
        addSubview(downloadButton)
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            headingLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            subtitleLabel.topAnchor.constraint(
                equalTo: headingLabel.bottomAnchor, constant: 25),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            urlSearchTextField.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor, constant: 25),
            urlSearchTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            urlSearchTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            urlSearchTextField.heightAnchor.constraint(equalToConstant: 30),
            videoView.topAnchor.constraint(
                equalTo: urlSearchTextField.bottomAnchor, constant: 20),
            videoView.widthAnchor.constraint(equalToConstant: 336),
            videoView.heightAnchor.constraint(equalToConstant: 189),
            videoView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            videoTextLabel.topAnchor.constraint(
                equalTo: videoView.bottomAnchor, constant: 10),
            videoTextLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            videoTextLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            downloadButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            downloadButton.heightAnchor.constraint(equalToConstant: 35),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
