//
//  ViewController.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/07.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var bus8TimeLeftLabel: UILabel!
    @IBOutlet weak var bus8NextTimeLabel: UILabel!
    @IBOutlet weak var bus1100TimeLeftLabel: UILabel!
    @IBOutlet weak var bus1100NextTimeLabel: UILabel!
    @IBOutlet weak var bus1200TimeLeftLabel: UILabel!
    @IBOutlet weak var bus1200NextTimeLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    var busLabels: [Int: (nextTimeLabel: UILabel, timeLeftLabel: UILabel)] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busLabels = [
            8: (bus8NextTimeLabel, bus8TimeLeftLabel),
            1100: (bus1100NextTimeLabel, bus1100TimeLeftLabel),
            1200: (bus1200NextTimeLabel, bus1200TimeLeftLabel)
        ]
        
        updateAllBusInfo()
        
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(updateAllBusInfo), userInfo: nil, repeats: true)
        refreshButton.addTarget(self, action: #selector(updateAllBusInfo), for: .touchUpInside)
    }
    
    @objc func updateAllBusInfo() {
        for busNum in [8, 1100, 1200] {
            updateBusInfo(busNum: busNum)
        }
    }
        
    func updateBusInfo(busNum: Int) {
        let currentBusDatas = BusTimetableManager.getTodayBusTime(busNum: busNum)
        let convertedBusDatas = BusTimetableManager.convertBusDatas(timeString: currentBusDatas)
        
        let currentTime = DateUtils.getCurrentTime()
        let convertedTime = TimeConverter.convertTimeToSeconds(time: currentTime)
        
        var minutesLeftText = ""
        var nextBusTimeText = ""
        var nextBusIndex = 0
        var minutesLeft = 0
        
        nextBusIndex = convertedBusDatas.firstIndex(where: {$0 > convertedTime}) ?? 0
        nextBusTimeText = currentBusDatas[nextBusIndex]
        minutesLeft = convertedBusDatas[nextBusIndex] - convertedTime
        minutesLeftText = (minutesLeft < 0 || minutesLeft > 120) ? "막차 끊김" : "\(minutesLeft)분 남음"
        
        if let labels = busLabels[busNum] {
            labels.nextTimeLabel.text = nextBusTimeText
            labels.timeLeftLabel.text = minutesLeftText
            labels.timeLeftLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
}
