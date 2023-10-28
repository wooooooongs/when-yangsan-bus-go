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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var refreshImage: UIImageView!
    
    let refreshControl = UIRefreshControl()
    
    var busLabels: [Int: (nextTimeLabel: UILabel, timeLeftLabel: UILabel)] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 새로고침 버튼
        let refreshTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRefreshControl))
        refreshImage.addGestureRecognizer(refreshTapGesture)
        refreshImage.isUserInteractionEnabled = true
        
        // 새로고침 스크롤
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: UIControl.Event.valueChanged)
        
        // 버스 레이블 매치 시키기
        busLabels = [
            8: (bus8NextTimeLabel, bus8TimeLeftLabel),
            1100: (bus1100NextTimeLabel, bus1100TimeLeftLabel),
            1200: (bus1200NextTimeLabel, bus1200TimeLeftLabel)
        ]
        
        // 앱 실행, 정보 가져오기
        updateAllBusInfo()
        
        // 30초마다 자동 새로고침
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(updateAllBusInfo), userInfo: nil, repeats: true)
    }
    
    @objc func updateAllBusInfo() {
        for busNum in [8, 1100, 1200] {
            updateBusInfo(busNum: busNum)
        }
    }
    
    @objc private func handleRefreshControl() {
        updateAllBusInfo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
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
