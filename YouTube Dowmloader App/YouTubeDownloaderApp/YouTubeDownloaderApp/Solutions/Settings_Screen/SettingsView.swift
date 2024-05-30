//
//  SettingsView.swift
//  YouTubeDownloaderApp
//
//  Created by Артур Миннушин on 27.05.2024.
//

import UIKit

class SettingsView: UIView {
    var viewController: SettingsViewController?
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        return label
    }()
    lazy var themeSetupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Смена темы на светлую/темную"
        label.textColor = .white
        return label
    }()
    lazy var themeSetupSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.tintColor = .white
        mySwitch.onTintColor = .black
        let action = UIAction { [weak self] _ in
            self?.changeBackgroundColor()
        }
        mySwitch.addAction(action, for: .touchUpInside)
        return mySwitch
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupSwipe()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        backgroundColor = .black
        addSubview(settingsLabel)
        addSubview(themeSetupLabel)
        addSubview(themeSetupSwitch)
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            settingsLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            themeSetupLabel.topAnchor.constraint(
                equalTo: settingsLabel.bottomAnchor, constant: 20),
            themeSetupLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            themeSetupSwitch.centerYAnchor.constraint(
                equalTo: themeSetupLabel.centerYAnchor),
            themeSetupSwitch.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    func changeBackgroundColor() {
        if themeSetupSwitch.isOn {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                self.viewController?.chageTheme(isBlack: false)
                self.backgroundColor = .white
                self.settingsLabel.textColor = .black
                self.themeSetupLabel.textColor = .black
                })
        } else {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                self.viewController?.chageTheme(isBlack: true)
                self.backgroundColor = .black
                self.settingsLabel.textColor = .white
                self.themeSetupLabel.textColor = .white
            })
        }
    }
    func setupSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.dismisController))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }
    @objc func dismisController() {
        viewController?.dismiss(animated: true)
    }
}
