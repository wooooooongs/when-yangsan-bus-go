//
//  MenuCollectionViewCell.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/4/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "버스 시간표"
        label.font = UIFont.systemFont(ofSize: 26, weight: .black)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        configureUI()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.contentView.addSubview(titleLabel)
    }
    
    private func configureUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(26)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    private func setStyle() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
}
