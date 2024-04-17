//
//  Timetable.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/10/24.
//

import SwiftUI

struct TimetableView: View {
    @Binding var timetable: [String]?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        let morningTimetable = timetable?.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            
            return hour < 12
        } ?? ["시간표가 비어있습니다."]
        
        let afternoonTimetable = timetable?.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            
            return hour >= 12
        } ?? ["시간표가 비어있습니다."]
        
        ScrollView {
            VStack(alignment: .leading) {
                Text("오전")
                    .font(.title)
                    .fontWeight(.semibold)
                
                timetableGrid(columns: columns, for: morningTimetable)
                
                Divider()
                    .padding([.top, .bottom])
                
                Text("오후")
                    .font(.title)
                    .fontWeight(.semibold)
                
                timetableGrid(columns: columns, for: afternoonTimetable)
            }
            .padding()
        }
        .background(.white, ignoresSafeAreaEdges: [])
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func timetableGrid(columns: [GridItem], for timetable: [String]) -> some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(timetable, id: \.self) { time in
                let isBusPassed = TimeUtils.shared.isBusPassed(time)
                
                Text(time)
                    .font(.title2)
                    .foregroundStyle(isBusPassed ? Color.gray : Color.black)
            }
        }
    }
}

#Preview {
    TimetableView(timetable: .constant(        BusTimetableManager.shared.getAllBusTimetables()[0].upboundTimetable[.sat]
))
}
