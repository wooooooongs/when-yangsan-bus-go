//
//  HomeViewController+UITableViewDataSource.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favoritedBusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.favoriteCellIdentifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.busData = favoritedBusArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoritedBusData = favoritedBusDatas[indexPath.row]
        let busData = busTimetableManager.getBusTimetableToBusId(favoritedBusData.busId)
        
        let detailVC = DetailViewController(homeViewController: self)
        detailVC.busData = busData
        
        present(detailVC, animated: true)
    }
}
