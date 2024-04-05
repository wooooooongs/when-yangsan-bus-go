//
//  HomeViewController+UICollectionViewDataSource.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/4/24.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let fetchedMenuDatas: [MenuData] = MenuDatas.shared.getMenuDatas()
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.menuCellIdentifier, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        
        cell.menuData = fetchedMenuDatas[indexPath.row]
                
        return cell
    }
}
