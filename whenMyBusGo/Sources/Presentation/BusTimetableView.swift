//
//  BusTimetableView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/5/24.
//

import SwiftUI

struct BusTimetableView: View {
    let busTimetableManager = BusTimetableManager.shared
    
    @State var currentBusType: BusType = .전체
    @State var currentBusList: [BusTimetable] = []
    
    let setBackground = Color(HexColor.from("EEEEEE"))
    let busTypes = BusType.allCases
    
    init() {
        _currentBusList = State(initialValue: busTimetableManager.getAllBusTimetables())
    }
    
    var body: some View {
        ZStack {
            setBackground
                .ignoresSafeArea()
            
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(busTypes, id: \.self) { busType in
                            Button(action: {
                                currentBusType = busType
                                currentBusList = busTimetableManager.getBusTimetables(forType: busType)
                            }) {
                                Text("\(busType)")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .foregroundColor(
                                        currentBusType == busType ? .white : .black
                                    )
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Capsule().fill(
                                        currentBusType == busType ? .yangsan : .white
                                    ))
                            }
                        }
                    }
                }
                
                Divider()
                
                ScrollView(.vertical) {
                }
                .padding(.top, 30.0)
                
                Spacer()
            }
            .padding(.top, 100.0)
        }
        .navigationTitle("버스 목록")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    //    ContentView()
    //        .tint(.black)
    BusTimetableView()
}
