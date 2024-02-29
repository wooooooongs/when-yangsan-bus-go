//
//  DetailViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 12/18/23.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    weak var homeViewController: HomeViewController?
    
    var busData: BusTimetable? {
        didSet {
            updateUI()
            setDayType()
            getFavoritedBus()
        }
    }
    
    private var isUpbound: Bool = true {
        didSet {
            updateCollectionViewForNewDirection()
            updateFavoriteButtonImage()
        }
    }
    
    private var isDayTypeSeperated: Bool = false
    private var currentDayType: Day = .weekday
    private var dayTypeButtonArray: [UIButton] = []
    
    // CoreData용 프로퍼티
    private let coreDataManager = CoreDataManager.shared
    private var favoritedData: FavoritedBus? {
        didSet {
            updateFavoriteButtonImage()
        }
    }
    
    // MARK: - Views
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busInfoStackView, buttonsStackView, timetableStackView, emptyView])
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
        let stackView = UIStackView(arrangedSubviews: [dayTypeButtonView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var dayTypeButtonView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: - Timetable
    private lazy var timetableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timetableHeaderContainer, timetableCollectionView])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    private lazy var timetableHeaderContainer: UIView = {
        let view = UIView()
        view.addSubview(timetableHeaderStackView)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    private lazy var timetableHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [collectionViewLabel, favoriteButton])
        
        return stackView
    }()
    
    private let collectionViewLabel: UILabel = {
        let label = UILabel()
        label.text = "양산행"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let newImage = UIImage(systemName: "heart")
        
        let button = UIButton()
        button.setImage(newImage, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let timetableCollectionView: UICollectionView = {
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
        addOnTapEvents()
        addBorder()
        addOnTapEventsForCoreData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        homeViewController?.updateFavoritedBusData()
        dismiss(animated: true)
    }
    
    init(homeViewController: HomeViewController?) {
        self.homeViewController = homeViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setView() {
        self.view.addSubview(mainStackView)
        self.view.backgroundColor = .white
    }
    
    private func setAutoLayout() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        }
        
        // Bus Info
        busInfoStackView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        busInfoLeftStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        busNumberLabel.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        // Buttons
        buttonsStackView.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        // Timetable
        timetableHeaderStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
            make.height.equalTo(50)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
    }
    
    private func setCollectionView() {
        timetableCollectionView.dataSource = self
        timetableCollectionView.delegate = self
        timetableCollectionView.register(DetailTimetableCell.self, forCellWithReuseIdentifier: Cell.detailCellIdentifier)
    }
    
    private func addBorder() {
        busInfoStackView.addBorder([.bottom], withColor: .black, width: 1)
        busUpboundLabel.addBorder([.top, .bottom], withColor: .black, width: 1)
        timetableStackView.addBorder()
    }
    
    private func updateUI() {
        guard let data = busData else { return }
        
        self.busType.text = data.busType.caseName
        self.busNumberLabel.text = data.busNumber
        self.busUpboundLabel.text = data.upbound
        self.busDownboundLabel.text = data.downbound
        self.collectionViewLabel.text = data.upbound
    }
    
    private func updateCollectionViewForNewDirection() {
        guard let data = busData else { return }
        
        self.collectionViewLabel.text = isUpbound ? data.upbound : data.downbound
        self.timetableCollectionView.reloadData()
    }
    
    private func updateFavoriteButtonImage() {
        guard let isCurrentDirectionFavorited: Bool = isUpbound ? favoritedData?.upbound : favoritedData?.downbound else { return }
        
        let imageName: String = isCurrentDirectionFavorited ? "heart.fill" : "heart"
        let newImage = UIImage(systemName: imageName)!
        self.favoriteButton.setImage(newImage, for: .normal)
    }
    
    private func addOnTapEvents() {
        setBusDirectionButtons()
        setDayTypeButtons()
    }
    
    private func setBusDirectionButtons() {
        busInfoRightStackView.arrangedSubviews.forEach { label in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeBusDirectionButtonTapped))
            label.addGestureRecognizer(tapGestureRecognizer)
            label.isUserInteractionEnabled = true
        }
    }
    
    @objc private func changeBusDirectionButtonTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        let isUpbound = label == busUpboundLabel
        
        self.isUpbound = isUpbound
    }
    
    private func setDayType() {
        // NOTE: 평일 - 토 - 공휴일
        let isSeperated = busData?.upboundTimetable.keys.count == 3
        
        if isSeperated {
            self.isDayTypeSeperated = true
        }
    }
    
    // TODO: 중복 코드 삭제
    private func setDayTypeButtons() {
        if self.isDayTypeSeperated {
            let weekdayButton = UIButton(type: .system)
            let saturdayButton = UIButton(type: .system)
            let holidayButton = UIButton(type: .system)
            
            dayTypeButtonArray = [weekdayButton, saturdayButton, holidayButton]
            dayTypeButtonArray.forEach { button in
                button.layer.cornerRadius = 5
                button.backgroundColor = .lightGray
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(changeDayTypeButtonTapped), for: .touchUpInside)
                
            }
            
            weekdayButton.setTitle("평일", for: .normal)
            weekdayButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            weekdayButton.tag = DayTypeForButton.weekday.rawValue
            weekdayButton.backgroundColor = .gray
            saturdayButton.setTitle("토", for: .normal)
            saturdayButton.layer.cornerRadius = 0
            saturdayButton.tag = DayTypeForButton.sat.rawValue
            holidayButton.setTitle("공휴일", for: .normal)
            holidayButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            holidayButton.tag = DayTypeForButton.sun.rawValue
            
            dayTypeButtonView.addSubview(weekdayButton)
            dayTypeButtonView.addSubview(saturdayButton)
            dayTypeButtonView.addSubview(holidayButton)
            
            weekdayButton.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.right.equalTo(saturdayButton.snp.left)
                make.width.equalTo(75)
            }
            
            saturdayButton.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.right.equalTo(holidayButton.snp.left)
                make.width.equalTo(weekdayButton)
            }
            
            holidayButton.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.right.equalToSuperview()
                make.width.equalTo(weekdayButton)
            }
        } else {
            let weekdayButton = UIButton(type: .system)
            let weekendButton = UIButton(type: .system)
            
            dayTypeButtonArray = [weekdayButton, weekendButton]
            dayTypeButtonArray.enumerated().forEach { index, button in
                button.layer.cornerRadius = 5
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(changeDayTypeButtonTapped), for: .touchUpInside)
            }
            
            weekdayButton.setTitle("평일", for: .normal)
            weekdayButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            weekdayButton.tag = DayTypeForButton.weekday.rawValue
            weekdayButton.backgroundColor = .gray
            weekendButton.setTitle("토,공휴일", for: .normal)
            weekendButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            weekendButton.tag = DayTypeForButton.weekend.rawValue
            weekdayButton.backgroundColor = .lightGray
            
            dayTypeButtonView.addSubview(weekdayButton)
            dayTypeButtonView.addSubview(weekendButton)
            
            weekdayButton.snp.makeConstraints { make in
                make.top.left.bottom.equalToSuperview()
                make.right.equalTo(weekendButton.snp.left)
                make.width.equalTo(75)
            }
            
            weekendButton.snp.makeConstraints { make in
                make.top.right.bottom.equalToSuperview()
                make.width.equalTo(weekdayButton)
            }
        }
    }
    
    @objc private func changeDayTypeButtonTapped(sender: UIButton) {
        dayTypeButtonArray.forEach { button in
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .lightGray
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = .gray
        }
        
        if let dayTypeForButton = DayTypeForButton(rawValue: sender.tag), let dayType = dayTypeForButton.convertToDay(dayTypeForButton) {
            self.currentDayType = dayType
            self.timetableCollectionView.reloadData()
        }
    }
    
    // MARK: - CoreData 즐겨찾기
    private func addOnTapEventsForCoreData() {
        let saveOrUpdate = UITapGestureRecognizer(target: self, action: #selector(saveOrUpdateFavorited))
        favoriteButton.addGestureRecognizer(saveOrUpdate)
        favoriteButton.isUserInteractionEnabled = true
    }
    
    @objc private func saveOrUpdateFavorited() {
        coreDataManager.saveOrUpdateFavoriteBus(for: busData!, isUpbound: isUpbound)
        getFavoritedBus()
    }
    
    private func getFavoritedBus() {
        guard let busId = self.busData?.id else { return }
        
        if let favoritedData = coreDataManager.getFavoriteBus(for: busId) {
            self.favoritedData = favoritedData
        }
    }
}

// MARK: - Extensions
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: 상행 하행 바꾸기
        let upboundTimetable = busData?.upboundTimetable[currentDayType]?.count
        let downboundTimetable = busData?.downboundTimetable[currentDayType]?.count
        
        guard let timetableCount = self.isUpbound ? upboundTimetable : downboundTimetable else { return 0 }
        
        return timetableCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.detailCellIdentifier, for: indexPath) as? DetailTimetableCell else { return UICollectionViewCell() }
        
        let upboundTimetable = busData?.upboundTimetable[currentDayType]?[indexPath.row]
        let downboundTimetable = busData?.downboundTimetable[currentDayType]?[indexPath.row]
        cell.time = self.isUpbound ? upboundTimetable : downboundTimetable
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 60)
    }
}

#Preview {
    let vc = DetailViewController(homeViewController: nil)
    let manager = BusTimetableManager.shared
    vc.busData = manager.getAllBusTimetables()[0]
    
    return vc
}
