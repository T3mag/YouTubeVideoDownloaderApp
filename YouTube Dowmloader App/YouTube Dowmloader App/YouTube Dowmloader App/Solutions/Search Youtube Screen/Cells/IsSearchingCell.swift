//
//  IsSearchingCellTableViewCell.swift
//  YouTube Dowmloader App
//
//  Created by Артур Миннушин on 20.05.2024.
//

import UIKit

class IsSearchingCell: UITableViewCell {
    lazy var loadingSpinerView: CustomSpinerSimpleView = {
        let spiner = CustomSpinerSimpleView(squareLength: 30)
        return spiner
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        backgroundColor = .clear
        addSubview(loadingSpinerView)
        loadingSpinerView.backgroundColor = .clear
        loadingSpinerView.frame = CGRect(x: frame.width / 2 + 10, y: frame.origin.y + 10, width: 30, height: 30)
    }
    deinit {
        loadingSpinerView.stopAnimation()
        loadingSpinerView.removeFromSuperview()
    }
    func activateSpiner() {
        setupLayout()
        loadingSpinerView.startAnimation(delay: 0.04, replicates: 12)
    }
    func disActiveteSpinner() {
        loadingSpinerView.stopAnimation()
        loadingSpinerView.removeFromSuperview()
    }
}
