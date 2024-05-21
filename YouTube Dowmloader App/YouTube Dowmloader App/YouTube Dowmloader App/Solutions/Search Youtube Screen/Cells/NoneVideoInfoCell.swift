//
//  noneVideoInfoCell.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 27.04.2024.
//

import UIKit

class NoneVideoInfoCell: UITableViewCell {
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .white
        let oneStr = "Увы, видео пока нет, прости. "
        let twoStr = "Введи свой запрос или исправь его в поле сверху."
        let threeStr = "Также не забудь проверить интернет соединение :)"
        label.text = oneStr + twoStr + threeStr
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        backgroundColor = .blue
        addSubview(infoLabel)
        backgroundColor = UIColor(red: 28/255, green: 27/255, blue: 29/255, alpha: 1)
        layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            infoLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            infoLabel.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
