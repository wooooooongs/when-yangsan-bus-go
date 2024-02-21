//
//  HomeViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var favoritedBusDatas: [BusTimetableForHomeView] = []
    
    let busTimetableManager = BusTimetableManager.shared
    
    // MARK: - Views
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [menuCollectionView, favoriteTableView])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - Menu CollectionView
    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = HexColor.from("EEEEEE")
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    // MARK: - Favorite TableView
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = HexColor.from("EEEEEE")
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setCollectionView()
        setTableView()
        setAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateFavoritedBusData()
        setTableViewAutoLayout()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setCollectionViewAutoLayout()
    }
    
    // MARK: - Methods
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        view.backgroundColor = HexColor.from("EEEEEE")
    }
    
    private func setCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: Cell.menuCellIdentifier)
        menuCollectionView.isScrollEnabled = false
    }
    
    private func setTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: Cell.favoriteCellIdentifier)
        favoriteTableView.isScrollEnabled = false
    }
    
    private func setAutoLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(20)
            make.left.right.equalTo(view).inset(25)
        }
    }
    
    private func setTableViewAutoLayout() {
        let numberOfRows = favoriteTableView.numberOfRows(inSection: 0)
        let rowHeight = tableView(favoriteTableView, heightForRowAt: IndexPath(row: 0, section: 0))
        let totalHeight = numberOfRows * Int(rowHeight)
        
        favoriteTableView.snp.updateConstraints { make in
            make.height.equalTo(totalHeight)
        }
    }
    
    private func setCollectionViewAutoLayout() {
        // TODO: Section 수 자동 계산
        let numbersOfSections = 2
        let layout = menuCollectionView.collectionViewLayout
        let rowHeight = collectionView(menuCollectionView, layout: layout, sizeForItemAt: IndexPath(row: 0, section: 0)).height
        let spacingForSection = collectionView(menuCollectionView, layout: layout, minimumLineSpacingForSectionAt: 0)
        let totalHeight = CGFloat(numbersOfSections) * (rowHeight + spacingForSection)
        
        menuCollectionView.snp.makeConstraints { make in
            make.height.equalTo(totalHeight)
        }
    }
    
    func updateFavoritedBusData() {
        favoritedBusDatas = busTimetableManager.getConvertedFavoritedBusArray()
        favoriteTableView.reloadData()
    }
}

#Preview {
    HomeViewController()
}
