//
//  DetailViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 12/18/23.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    var busData: BusTimetable? {
        didSet {
            
        }
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busInfoStackView, buttonsStackView, upboundStackView, emptyView])
        stackView.axis = .vertical
        stackView.spacing = 25
        
        return stackView
    }()
    
    // MARK: - Bus Info
    private lazy var busInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busInfoLeftStackView, busInfoRightStackView])
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private lazy var busInfoLeftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busType, busNumberLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let busType: UILabel = {
        let label = UILabel()
        label.text = "일반"
        label.textAlignment = .left
        
        return label
    }()

    private let busNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0번"
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        
        return label
    }()
    
    private lazy var busInfoRightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busUpboundLabel, busDownboundLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let busUpboundLabel: UILabel = {
        let label = UILabel()
        label.text = "양산"
        label.textAlignment = .center
        
        return label
    }()
    
    private let busDownboundLabel: UILabel = {
        let label = UILabel()
        label.text = "부산"
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Buttons
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [repeatIcon, dayTypeButtonView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var repeatIcon: UIImageView = {
        let imageName = "repeat"
        // TODO: - 새로운 리사이징 메서드로 변경
        let newImage = UIImage(systemName: imageName)!
        
        let imageView = UIImageView(image: newImage)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var dayTypeButtonView: UIView = {
        let view = UIView()
        let weekdayButton = UIButton(type: .system)
        let holidayButton = UIButton(type: .system)
        
        weekdayButton.setTitle("평일", for: .normal)
        weekdayButton.setTitleColor(.black, for: .normal)
        weekdayButton.backgroundColor = .gray
        
        weekdayButton.layer.cornerRadius = 5
        weekdayButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        weekdayButton.tag = 1
        
        
        holidayButton.setTitle("일,공휴일", for: .normal)
        holidayButton.setTitleColor(.black, for: .normal)
        
        holidayButton.layer.cornerRadius = 5
        holidayButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        holidayButton.backgroundColor = .lightGray
        holidayButton.tag = 2

        
        view.addSubview(weekdayButton)
        view.addSubview(holidayButton)
        
        weekdayButton.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(35)
        }
        
        holidayButton.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(weekdayButton.snp.right)
            make.width.equalTo(weekdayButton)
        }
        
        return view
    }()
    
    // MARK: - Upbound
    private lazy var upboundStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelContainer, upboundCollectionView])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
        
    private lazy var labelContainer: UIView = {
        let view = UIView()
        view.addSubview(upboundCollectionViewLabel)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    private let upboundCollectionViewLabel: UILabel = {
        let label = UILabel()
        label.text = "양산행"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    
    private let upboundCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - Downbound
    private lazy var downboundStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [downboundCollectionViewLabel, downboundCollectionView])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let downboundCollectionViewLabel: UILabel = {
        let label = UILabel()
        label.text = "신평터미널행"
        
        return label
    }()
    
    private let downboundCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - Empty View
    
    private let emptyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setCollectionView()
        setAutoLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        addBorder()
    }
    
    private func setView() {
        self.view.addSubview(mainStackView)
        self.view.backgroundColor = .white
    }

    private func setAutoLayout() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        }
        
        busUpboundLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(110)
        }
        
        busNumberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(busInfoStackView.snp.bottom).offset(-25)
            make.height.equalTo(48)
        }
        
        busType.snp.makeConstraints { make in

        }
        
        busInfoStackView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        busInfoLeftStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        
        busInfoRightStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        upboundStackView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(400)
        }
        
        labelContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        upboundCollectionViewLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview()
        }
        
        upboundCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
        }
        
    }
    
    private func setCollectionView() {
        upboundCollectionView.dataSource = self
        upboundCollectionView.delegate = self
        upboundCollectionView.register(DetailTimetableCell.self, forCellWithReuseIdentifier: Cell.detailCellIdentifier)
        
        downboundCollectionView.dataSource = self
        downboundCollectionView.delegate = self
        downboundCollectionView.register(DetailTimetableCell.self, forCellWithReuseIdentifier: Cell.detailCellIdentifier)
    }
    
    private func addBorder() {
        busInfoStackView.addBorder([.bottom], withColor: .black, width: 1)
        busUpboundLabel.addBorder([.top, .bottom], withColor: .black, width: 1)
        upboundStackView.addBorder()
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upboundCollectionView { return 35 } else
        if collectionView == downboundCollectionView { return 15 }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.detailCellIdentifier, for: indexPath) as? DetailTimetableCell else { return UICollectionViewCell() }
        
        cell.time = "00:00"
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 30)
    }
}


#Preview {
    DetailViewController()
}
