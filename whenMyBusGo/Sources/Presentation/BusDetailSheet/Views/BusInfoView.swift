//
//  BusInfoView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/13/24.
//

import SwiftUI

struct BusInfoView: View {
    @FetchRequest(entity: FavoritedBus.entity(), sortDescriptors: [])
    private var favoritedBusDatas: FetchedResults<FavoritedBus>

    @EnvironmentObject var favoritedBusDataManager: FavoritedBusDataManager
    @Binding var busData: BusTimetable
    @Binding var isUpbound: Bool
    @State var isFavorited: Bool?
    
    var body: some View {
        ZStack {
            Color.yangsan
                .roundedCorner([.topLeft, .topRight], 20)
            
            VStack(spacing: 0) {
                Capsule()
                    .frame(width: 35, height: 5)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("\(busData.busType)")
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            favoritedBusDataManager.createOrUpdateFavoriteBus(for: busData, isUpbound: isUpbound)
                            checkIfBusIsFavorited()
                        }, label: {
                            Image(systemName: isFavorited ?? false ? "star.fill" : "star")
                            
                            if isUpbound {
                                Text("\(busData.upbound)")
                                    .fontWeight(.bold)
                            } else {
                                Text("\(busData.downbound)")
                                    .fontWeight(.bold)
                            }
                        })
                    }
                    .padding([.top, .bottom], 5)
                    .padding([.leading, .trailing], 7.5)
                    .background(Color.black.opacity(0.25), in: Capsule())
                }
                
                HStack {
                    Text("\(busData.busNumber)")
                        .font(.largeTitle)
                    
                    Spacer()
                }
            }
            .padding()
            .padding(.bottom, 15)
            .foregroundStyle(.white)
            .onChange(of: isUpbound) {
                checkIfBusIsFavorited()
            }
            .onAppear() {
                checkIfBusIsFavorited()
            }
        }
        .frame(maxHeight: 100)
    }
    
    func checkIfBusIsFavorited() {
        if let favoritedBus = favoritedBusDatas.first(where: { $0.busId == busData.id }) {
            self.isFavorited = isUpbound ? favoritedBus.isUpboundFavorited : favoritedBus.isDownboundFavorited
        } else {
            self.isFavorited = false
        }
    }
}
