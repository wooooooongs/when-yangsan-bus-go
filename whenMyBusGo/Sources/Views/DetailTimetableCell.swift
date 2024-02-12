//
//  DetailTimetableCell.swift
//  whenMyBusGo
//
//  Created by Oscar on 12/25/23.
//

import UIKit

class DetailTimetableCell: UICollectionViewCell {
    var time: String?
    {
        didSet {
            setTimeLabel()
            updateTimeLabel()
        }
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.contentView.addSubview(timeLabel)
    }
    
    private func setAutoLayout() {
        timeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setTimeLabel() {
        timeLabel.text = time
    }
    
    private func updateTimeLabel() -> Void {
        guard let time = time else { return }
        let convertedTimeCell = TimeUtils.shared.convertTimeToMinutes(time)
        let currentTimeString = TimeUtils.shared.getCurrentTime()
        let currentTime = TimeUtils.shared.convertTimeToMinutes(currentTimeString)
        
        let isBusGone = currentTime > convertedTimeCell
        if isBusGone {
            self.timeLabel.textColor = .lightGray
        } else {
            self.timeLabel.textColor = .black
        }
    }
}
