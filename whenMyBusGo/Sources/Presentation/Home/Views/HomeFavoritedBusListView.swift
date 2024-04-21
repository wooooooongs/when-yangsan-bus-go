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
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(favoritedBusDatas, id: \.id) { bus in
                favoritedBusRows(for: bus)
                    .onTapGesture {
                        self.selectedBus = busTimetableManager.convertToBusTimetable(from: bus)
                    }
            }
        }
        .sheet(item: $selectedBus) { busData in
            BusDetailSheetView(busData: .constant(busData))
        }
    }
    
    @ViewBuilder
    private func favoritedBusRows(for busData: FavoritedBus) -> some View {
        let isBothFavorited = busData.isUpboundFavorited && busData.isDownboundFavorited
        let isUpboundFavorited = busData.isUpboundFavorited && !busData.isDownboundFavorited
        let isDownboundFavorited = !busData.isUpboundFavorited && busData.isDownboundFavorited
        
        if isBothFavorited {
            favoritedBusItem(for: busData, direction: busData.upboundName ?? "상행")
            favoritedBusItem(for: busData, direction: busData.downboundName ?? "하행")
        }
        
        if isUpboundFavorited {
            favoritedBusItem(for: busData, direction: busData.upboundName ?? "상행")
        }
        
        if isDownboundFavorited {
            favoritedBusItem(for: busData, direction: busData.downboundName ?? "하행")
        }
    }
    
    
    @ViewBuilder
    private func favoritedBusItem(for busData: FavoritedBus, direction: String) -> some View {
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
                            
                            Text(direction)
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
    }
}

#Preview {
    HomeFavoritedBusListView()
}
