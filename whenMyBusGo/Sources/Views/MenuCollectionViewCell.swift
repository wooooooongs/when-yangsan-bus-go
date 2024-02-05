//
//  MenuCollectionViewCell.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/4/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    var menuData: MenuData? {
        didSet {
            if menuData?.isWebView == true {
                setBorder()
                addYangsanLogo()
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "버스 시간표"
        label.font = UIFont.systemFont(ofSize: 26, weight: .black)
        
        return label
    }()
    
    private let yangsanLogo: UIImageView = {
        let image = UIImage(named: "yangsan_logo")
        let newImage = UIImage(originalImage: image!, width: 1000.0)
        
        let imageView = UIImageView(image: newImage)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
    
    private func setBorder() {
        self.addBorder([.all], withColor: HexColor.from("00A651"), width: 4.0)
    }
    
    private func addYangsanLogo() {
        self.contentView.addSubview(yangsanLogo)
        
        yangsanLogo.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
