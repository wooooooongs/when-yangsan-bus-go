//
//  BusTimetableViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/28/23.
//

import UIKit
import SnapKit

class BusTimetableViewController: UIViewController {
    private let tableView = UITableView()
    private let busTimetableManager = BusTimetableManager.shared
    var allBusTimetables: [BusTimetable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setTableView()
        setAutoLayout()
        
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.backgroundColor = .white
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BusCell.self, forCellReuseIdentifier: Cell.busCellIdentifier)
        
        allBusTimetables = busTimetableManager.getAllBusTimetables()
    }
    
    private func setAutoLayout() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
}

extension BusTimetableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBusTimetables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.busCellIdentifier, for: indexPath) as? BusCell else {
            return UITableViewCell()
        }
        
        let busData = allBusTimetables[indexPath.row]
        cell.busData = busData
        
        return cell
    }
}

#Preview {
    BusTimetableViewController()
}
