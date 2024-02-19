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
            self.titleLabel.text = menuData?.title
            
            if menuData?.isWebView == true {
                setBorder()
                addYangsanLogo()
            }
        }
    }
    
    // MARK: - Views
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
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        configureUI()
        setStyle()
        addLongPressAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
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
        self.addBorder(width: 4.0)
        self.layer.borderColor = HexColor.from("00A651").cgColor
    }
    
    private func addYangsanLogo() {
        self.contentView.addSubview(yangsanLogo)
        
        yangsanLogo.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
        
    // MARK: - Cell Tapped Animation
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

extension MenuCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
