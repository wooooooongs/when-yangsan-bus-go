//
//  HomeViewController+UITableViewDelegate.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/3/24.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100 
    }
}
