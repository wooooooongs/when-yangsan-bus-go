//
//  HomeFavoritedBusListView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/17/24.
//

import SwiftUI

struct HomeFavoritedBusListView: View {
    @EnvironmentObject var busTimetableManager: BusTimetableManager
    @EnvironmentObject var favoritedBusDataManager: FavoritedBusDataManager
    @FetchRequest(entity: FavoritedBus.entity(), sortDescriptors: [
        NSSortDescriptor(key: "savedDate", ascending: true)
    ]) private var favoritedBusDatas: FetchedResults<FavoritedBus>
    
    @State private var selectedBus: BusTimetable?
    @State private var isUpbound: Bool = true
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(favoritedBusDatas, id: \.id) { bus in
                Group {
                    if bus.isUpboundFavorited {
                        favoritedBusItem(for: bus, isUpbound: true)
                    }
                    
                    if bus.isDownboundFavorited {
                        favoritedBusItem(for: bus, isUpbound: false)
                    }
                }
            }
        }
        .sheet(item: $selectedBus) { busData in
            BusDetailSheetView(busData: .constant(busData), isUpbound: isUpbound)
                .transparentBackground()
        }
    }
    
    @ViewBuilder
    private func favoritedBusItem(for busData: FavoritedBus, isUpbound: Bool) -> some View {
        let directionName = isUpbound ? busData.upboundName : busData.downboundName
        
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if let busType = busData.busType,
               let busNumber = busData.busNumber {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(busType)
                                .font(.caption)
                                .offset(y: 2.5)
                            
                            Text(directionName ?? "")
                                .font(.caption)
                                .offset(y: 2.5)
                        }
                        
                        Text(busNumber)
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("막차 끊김")
                            .font(.callout)
                        Text("06:55 출발")
                            .font(.callout)
                    }
                }
                .padding([.vertical], 10)
                .padding([.horizontal], 15)
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            self.isUpbound = isUpbound
            self.selectedBus = busTimetableManager.convertToBusTimetable(from: busData)
        }
    }
}

#Preview {
    HomeFavoritedBusListView()
}
