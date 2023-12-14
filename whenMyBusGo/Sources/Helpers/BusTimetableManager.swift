//
//  BusTimetableManager.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/19.
//

import Foundation

class BusTimetableManager {
    func getData() -> [BusTimetable] {
        guard let jsonPath = Bundle.main.path(forResource: "busDatas", ofType: "json") else {
            return []
        }
        let decoder = JSONDecoder()
        
        do {
            let url = URL(filePath: jsonPath)
            let data = try Data(contentsOf: url)
            
            let decodedData = try decoder.decode(BusTimetables.self, from: data)
            
            return decodedData.result
        } catch {
            print("busDatas.json이 없는 거 같은데용")
            return []
        }
    }
    
}
