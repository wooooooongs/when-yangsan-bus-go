import UIKit

extension BusTimetableViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        let isResult = elementName == "result2"
        let isHeaderRow = isResult && attributeDict["SVR_NUM"] == nil
        let isDataRow = isResult && attributeDict["SVR_NUM"] != nil
                
        BusTimetableManager.setBusNumber(from: attributeDict, to: &busTimetables)
        
        if isHeaderRow {
            BusTimetableManager.setDeparture(from: attributeDict, toUpbound: &upboundTimetable, toDownbound: &downboundTimetable)
        }
        
        if isDataRow {
            let busTypeKeyArray = getBusTypeArray()
            print("busTypeKeyArray \(busTypeKeyArray)")
            
            BusTimetableManager.setBusTimeData(busTypeKeyArray, from: attributeDict, toUpbound: &upboundTimetable, toDownbound: &downboundTimetable)
        }
        
        /// - Returns: ["ST_DATA0_0", "ST_DATA0_1", "ST_DATA1_0", "ST_DATA1_1"]
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}
