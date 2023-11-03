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
    
    var busTimetables = BusTimetables()
    var upboundTimetable = BusTimetable()
    var downboundTimetable = BusTimetable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setTableView()
        setAutoLayout()
        
        Task {
            let requestUrl = Bundle.main.requestUrl
            
            await getBusTimetableData(from: requestUrl)
        }
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.register(BusCell.self, forCellReuseIdentifier: Cell.busCellIdentifier)
    }
    
    private func setAutoLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getBusTimetableData(from urlString: String) async {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (safeData, _) = try await URLSession.shared.data(from: url)
            let parser = XMLParser(data: safeData)
            
            parser.delegate = self
            parser.parse()
            await updateBusTimetables()
        } catch {
            
        }
    }
    private func updateBusTimetables() async {
        busTimetables.timetable.append(upboundTimetable)
        busTimetables.timetable.append(downboundTimetable)
    }
}

extension BusTimetableViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        let isResult = elementName == "result2"
        let isHeaderRow = isResult && attributeDict["SVR_NUM"] == nil
        let isDataRow = isResult && attributeDict["SVR_NUM"] != nil
                
        BusTimetableManager.setBusNumber(attributeDict, &busTimetables)
        
        if isHeaderRow {
            BusTimetableManager.setDeparture(attributeDict, &upboundTimetable, &downboundTimetable)
        }
        
        if isDataRow {
            let busTypeKeyArray = getBusTypeArray()
            
            BusTimetableManager.setBusTimeData(busTypeKeyArray, attributeDict, &upboundTimetable, &downboundTimetable)
        }
        
        func getBusTypeArray() -> [String]{
            let pattern = "ST_DATA\\d+_\\d+"
            
            let filteredArray = attributeDict.keys.filter { departure in
                if let range = departure.range(of: pattern, options: .regularExpression) {
                    return range.lowerBound == departure.startIndex
                }
                return false
            }
            
            return filteredArray
        }
    }
    }
}

extension BusTimetableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.busCellIdentifier, for: indexPath) as! BusCell
        
        return cell
    }
}

#Preview {
    BusTimetableViewController()
}
