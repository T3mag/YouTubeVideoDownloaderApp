//
//  ButtonCell.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 25.04.2024.
//

import UIKit

class ButtonCell: UITableViewCell {
    lazy var addVideoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        button.setTitle("Добавить видео", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        let action = UIAction {[weak self] _ in
            print("Обновил")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        contentView.addSubview(addVideoButton)
        backgroundColor = .black
        NSLayoutConstraint.activate([
            addVideoButton.widthAnchor.constraint(
                equalToConstant: 170),
            addVideoButton.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            addVideoButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            addVideoButton.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
