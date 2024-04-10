//
//  Timetable.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/10/24.
//

import SwiftUI

struct Timetable: View {
    @Binding var timetable: [String]?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        let morningTimes = timetable?.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            
            return hour < 12
        } ?? ["시간표가 비어있습니다."]
        
        let afternoonTimes = timetable?.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            
            return hour >= 12
        } ?? ["시간표가 비어있습니다."]
        
        ScrollView {
            VStack(alignment: .leading) {
                Text("오전")
                    .font(.title)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(morningTimes, id: \.self) { time in
                        Text(time)
                            .font(.title2)
                    }
                }
                
                Divider()
                    .padding([.top, .bottom])
                
                Text("오후")
                    .font(.title)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(afternoonTimes, id: \.self) { time in
                        Text(time)
                            .font(.title2)
                    }
                }
            }
            .padding()
        }
        .background(.white, ignoresSafeAreaEdges: [])
    }
}

#Preview {
    Timetable(timetable: .constant(        BusTimetableManager.shared.getAllBusTimetables()[0].upboundTimetable[.sat]
))
}
