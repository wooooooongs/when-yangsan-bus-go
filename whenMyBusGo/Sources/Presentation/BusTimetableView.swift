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
    @State var currentBus: BusTimetable? = nil
    
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
                                // TODO: 현재: Manager에 filter를 매번 요청함. 프론트에서 다루는 건 어떨까?
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
                    VStack(spacing: 12.5) {
                        ForEach(currentBusList, id: \.id) { item in
                            Button(action: {
                                currentBus = item
                            }) {
                                busItem(for: item)
                            }
                        }
                    }
                }
                .padding(.top, 10.0)
                .padding([.leading, .trailing], 25)
                
            }
            .padding(.top, 20)
        }
        .sheet(item: $currentBus, content: { bus in
            detailSheet(bus)
        })
        .navigationTitle("버스 목록")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func busItem(for bus: BusTimetable) -> some View {
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                VStack(alignment: .leading, spacing: 5.0) {
                    Text("\(bus.busNumber)")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    HStack {
                        Text("\(bus.busType)")
                        
                        Group {
                            Text("\(bus.upbound)")
                            Image(systemName: "repeat")
                            Text("\(bus.downbound)")
                        }
                        .lineLimit(1)
                        .truncationMode(.tail)
                    }
                    .font(.subheadline)
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
            }
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 15)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func detailSheet(_ bus: BusTimetable) -> some View {
        Text("\(bus.busNumber)")
    }
}

#Preview {
    //    ContentView()
    //        .tint(.black)
    BusTimetableView()
}
