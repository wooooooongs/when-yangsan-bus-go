//
//  HomeViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setCollectionView()
        setTableView()
        setAutoLayout()
    }
    
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(20)
            make.left.right.equalTo(view).inset(25)
        }
    }
}

#Preview {
    HomeViewController()
}
