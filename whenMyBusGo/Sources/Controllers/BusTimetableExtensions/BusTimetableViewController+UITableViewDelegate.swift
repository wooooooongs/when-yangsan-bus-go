//
//  BusTimetableViewController+UITableViewDelegate.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/7/24.
//

import UIKit

extension BusTimetableViewController: UITableViewDelegate {
    // MARK: - DetailView 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let busData = allBusTimetables[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.busData = busData
        
        present(detailVC, animated: true)
    }
}
