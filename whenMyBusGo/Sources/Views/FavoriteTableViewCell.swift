//
//  FavoriteCell.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import Foundation
import UIKit

class FavoriteTableViewCell: UITableViewCell {
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busNumLabel, timeInfoStackView])
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let busNumLabel: UILabel = {
        let label = UILabel()
        label.text = "8번"
        label.font = UIFont.systemFont(ofSize: 42, weight: .medium)
        
        return label
    }()
    
    private lazy var timeInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLeftLabel, nextTimeStackView])
        stackView.axis = .vertical
        stackView.spacing = 6
        
        return stackView
    }()
    
    private let timeLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "막차 끊김"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var nextTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nextTimeLabel, leaveLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        
        return stackView
    }()
    
    private let nextTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "06:45"
        label.textAlignment = .right
        
        return label
    }()
    
    private let leaveLabel: UILabel = {
        let label = UILabel()
        label.text = "출발"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setAutoLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.contentView.addSubview(mainStackView)
    }
    
    private func setAutoLayout() {
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    func setCellData(_ busData: BusTimetable) {
        self.busNumLabel.text = busData.busNumber
        self.timeLeftLabel.text = "막차 끊김"
        self.nextTimeLabel.text = "06:55"
    }
    
    func setStyle() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 10
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
}
