//
//  FavoriteCell.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import Foundation
import UIKit

class FavoriteTableViewCell: UITableViewCell {
    var favoritedBusData: BusTimetableForHomeView? {
        didSet {
            setCellData()
        }
    }
    
    // MARK: - UI
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busInfoStackView, timeInfoStackView])
        stackView.alignment = .center
        
        return stackView
    }()
    
    
    // MARK: - BusInfoStackView(LeftStackView)
    private lazy var busInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [additionalInfoStackView, busNumLabel])
        stackView.axis = .vertical
        
        return stackView
    }()

    private lazy var additionalInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busTypeLabel, busDiretionLabel])
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let busTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "일반"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private let busDiretionLabel: UILabel = {
        let label = UILabel()
        label.text = "증산행"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private let busNumLabel: UILabel = {
        let label = UILabel()
        label.text = "8번"
        label.font = UIFont.systemFont(ofSize: 42, weight: .medium)
        
        return label
    }()
    
    // MARK: - TimeInfoStackView(RightStackView)
    private lazy var timeInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLeftLabel, nextTimeStackView])
        stackView.axis = .vertical
        
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
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setAutoLayout()
        addLongPressAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func addViews() {
        self.contentView.addSubview(mainStackView)
    }
    
    private func setAutoLayout() {
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        busTypeLabel.snp.makeConstraints { make in
            make.width.equalTo(35)
        }
    }
    
    private func setCellData() {
        self.busNumLabel.text = busData?.busNumber
        self.busTypeLabel.text = busData?.busType.caseName
        self.busDiretionLabel.text = busData?.upbound
        self.busDiretionLabel.text = busData?.downbound
        
        self.timeLeftLabel.text = "막차 끊김"
        self.nextTimeLabel.text = "06:55"
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 10
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    private func addLongPressAnimation() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(menuTapped))
        longPressGestureRecognizer.minimumPressDuration = 0.01
        longPressGestureRecognizer.cancelsTouchesInView = false
        longPressGestureRecognizer.delaysTouchesBegan = false
        longPressGestureRecognizer.delegate = self

        self.addGestureRecognizer(longPressGestureRecognizer)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func menuTapped(gestureRecognizer: UILongPressGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .began:
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
        case .ended:
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity
            })
        default:
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}

extension FavoriteTableViewCell {
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

#Preview {
    FavoriteTableViewCell()
}
