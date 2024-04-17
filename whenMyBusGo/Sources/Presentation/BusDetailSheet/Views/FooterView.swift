//
//  FooterView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/16/24.
//

import SwiftUI

struct FooterView: View {
    @Binding var busData: BusTimetable
    @Binding var selectedDayType: Day
    @Binding var isUpbound: Bool
    
    var dayTypeArray: [Day] {
        var isSeperated: Bool? {
            busData.isDayTypeSeperated
        }
        
        if isSeperated ?? true {
            return [.weekday, .sat, .sun]
        } else {
            return [.weekday, .weekend]
        }
    }
    
    var body: some View {
        HStack {
            ForEach(dayTypeArray, id: \.self) { dayType in
                Button(action: {
                    selectedDayType = dayType
                }, label: {
                    CategoryButton(title: dayType.localizedStringKey, selectedItem: $selectedDayType, item: dayType)
                })
                .overlay {
                    Capsule()
                        .strokeBorder(.yangsan, lineWidth: 1.0)
                }
            }
            
            Spacer()
            
            Button(action: {
                isUpbound.toggle()
            }, label: {
                Image(systemName: "arrow.left.arrow.right")
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
                    .background(.yangsan, ignoresSafeAreaEdges: [])
                    .clipShape(Circle())
            })
        }
        .padding([.top, .leading, .trailing], 20)
        .background(.white, ignoresSafeAreaEdges: [.bottom])
    }
}
