//
//  BusTimetableView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/5/24.
//

import SwiftUI

struct BusTimetableView: View {
    let busTimetableManager = BusTimetableManager.shared
    
    let setBackground = Color(HexColor.from("EEEEEE"))
    let busTypes = BusType.allCases
    
    var body: some View {
        ZStack {
            setBackground
                .ignoresSafeArea()
            
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(busTypes, id: \.self) { busType in
                            Button(action: {
                            }) {
                                Text("\(busType)")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .foregroundColor(
                                        .white
                                    )
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Capsule().fill(
                                        .yangsan
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
