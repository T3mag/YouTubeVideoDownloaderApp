//
//  ButtonCell.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 25.04.2024.
//

import UIKit

class ButtonCell: UITableViewCell {
    var nextPageToken: String!
    weak var delegate: AddNewVideo?
    lazy var addVideoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        button.setTitle("Добавить видео", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        let action = UIAction {[weak self] _ in
            self!.delegate?.addDataWithUserString(nextPageToken: self!.nextPageToken)
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
    func setupCell(nextPageToken: String) {
        self.nextPageToken = nextPageToken
    }
    func setupLayout() {
        contentView.addSubview(addVideoButton)
        backgroundColor = .clear
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
    func setupColor(isBlack: Bool) {
        if isBlack {
            addVideoButton.setTitleColor(.black, for: .normal)
        } else {
            addVideoButton.setTitleColor(.white, for: .normal)
        }
    }
}
