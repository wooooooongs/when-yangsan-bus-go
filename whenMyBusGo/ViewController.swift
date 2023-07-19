//
//  ViewController.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {

    var currentBusDatas: [String] = []
    var convertedBusDatas: [Int] = []
    var nextBusIndex = 0
    @IBOutlet weak var bus8TimeLeftLabel: UILabel!
    @IBOutlet weak var bus8NextTimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 
        
        currentBusDatas = BusTimetableManager.getTodayBusTime(busNum: 8)
        convertedBusDatas = convertBusDatas()
        getNextBusInfo()
        
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(getNextBusInfo), userInfo: nil, repeats: true)
    }
    
    func convertBusDatas() -> [Int] {
        return currentBusDatas.map(TimeConverter.convertTimeToSeconds)
    }
    
    @objc func getNextBusInfo() {
        let currentTime = DateUtils.getCurrentTime()
        let convertedTime = TimeConverter.convertTimeToSeconds(time: currentTime)
        
        guard let nextBusIndex = convertedBusDatas.firstIndex(where: {$0 > convertedTime}) else {
            bus8TimeLeftLabel.text = "막차 끊김"
            bus8NextTimeLabel.text = currentBusDatas[0]
            return
        }
        
        let nextBusTime = currentBusDatas[nextBusIndex]
        bus8NextTimeLabel.text = nextBusTime
        
        let minutesLeft = convertedBusDatas[nextBusIndex] - convertedTime
        bus8TimeLeftLabel.text = "\(minutesLeft)분 남음"
    }


}

