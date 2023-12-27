//
//  BusTableViewCell.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/28/23.
//

import UIKit
import SnapKit

class BusCell: UITableViewCell {
    var busData: BusTimetable? 
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftInfoStackView, favoriteButton])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var leftInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busNumLabel, busInfoStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let busNumLabel: UILabel = {
        let label = UILabel()
        label.text = "순환20-1등교"
        label.font = UIFont.systemFont(ofSize: 42, weight: .medium)
        
        return label
    }()
    
    private lazy var busInfoStackView: UIStackView  = {
        let stackView = UIStackView(arrangedSubviews: [busTypeLabel, busBoundStackView])
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let busTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "일반"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    private lazy var busBoundStackView: UIStackView  = {
        let stackView = UIStackView(arrangedSubviews: [upboundLabel, arrowsImage, downboundLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let upboundLabel: UILabel = {
        let label = UILabel()
        label.text = "석산"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    private let arrowsImage: UIImageView = {
        let imageName = "arrow.left.arrow.right"
        let newImage = Utils.resizeSystemImage(imageName, to: 16)
        let imageView = UIImageView(image: newImage)
        
        return imageView
    }()
    
    private let downboundLabel: UILabel = {
        let label = UILabel()
        label.text = "증산"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let image = UIImage(systemName: "heart")
        
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.contentView.addSubview(mainStackView)
        self.selectionStyle = .none
    }
    
    private func setAutoLayout() {
        mainStackView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(80)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
}
