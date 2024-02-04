//
//  HomeViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
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
        
        return collectionView
    }()
    
    // MARK: - Favorite TableView
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = HexColor.from("EEEEEE")
        
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
        view.addSubview(mainStackView)
        view.backgroundColor = HexColor.from("EEEEEE")
    }
    
    private func setCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: Cell.menuCellIdentifier)
    }
    
    private func setTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(FavoriteCell.self, forCellReuseIdentifier: Cell.favoriteCellIdentifier)
    }
    
    private func setAutoLayout() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(25)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            // TODO: 각 Row Hegiht x 줄 개수에 맞춰 계산하기
            make.height.equalTo(400)
        }
    }
}


#Preview {
    HomeViewController()
}
