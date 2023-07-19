//
//  ViewController.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bus8TimeLeftLabel: UILabel!
    @IBOutlet weak var bus8NextTimeLabel: UILabel!
    @IBOutlet weak var bus1100TimeLeftLabel: UILabel!
    @IBOutlet weak var bus1100NextTimeLabel: UILabel!
    @IBOutlet weak var bus1200TimeLeftLabel: UILabel!
    @IBOutlet weak var bus1200NextTimeLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAllBusInfo()
        
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(updateAllBusInfo), userInfo: nil, repeats: true)
        refreshButton.addTarget(self, action: #selector(updateAllBusInfo), for: .touchUpInside)
    }
    
    @objc func updateAllBusInfo() {
        updateBusInfo(busNum: 8)
        updateBusInfo(busNum: 1100)
        updateBusInfo(busNum: 1200)
    }
        
    func updateBusInfo(busNum: Int) {
        let currentBusDatas = BusTimetableManager.getTodayBusTime(busNum: busNum)
        let convertedBusDatas = BusTimetableManager.convertBusDatas(timeString: currentBusDatas)
        
        let currentTime = DateUtils.getCurrentTime()
        let convertedTime = TimeConverter.convertTimeToSeconds(time: currentTime)
        
        var minutesLeftText = ""
        var nextBusTimeText = ""
        
        guard let nextBusIndex = convertedBusDatas.firstIndex(where: {$0 > convertedTime}) else { return }
        
        let minutesLeft = convertedBusDatas[nextBusIndex] - convertedTime
        nextBusTimeText = currentBusDatas[nextBusIndex]
        minutesLeftText = (minutesLeft > 60) ? "막차 끊김" : "\(minutesLeft)분 남음"
                
        switch busNum {
        case 8:
            bus8NextTimeLabel.text = nextBusTimeText
            bus8TimeLeftLabel.text = minutesLeftText
        case 1100:
            bus1100NextTimeLabel.text = nextBusTimeText
            bus1100TimeLeftLabel.text = minutesLeftText
        case 1200:
            bus1200NextTimeLabel.text = nextBusTimeText
            bus1200TimeLeftLabel.text = minutesLeftText
        default:
            return
        }
    }
}
