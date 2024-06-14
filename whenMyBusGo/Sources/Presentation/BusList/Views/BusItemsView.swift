//
//  BusItemsView.swift
//  whenMyBusGo
//
//  Created by Oscar on 6/15/24.
//

import SwiftUI

struct BusItemsView: View {
    @ObservedObject var viewModel: BusListViewModel

    
    // MARK: - Body View
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 12.5) {
                ForEach(viewModel.selectedBusList, id: \.id) { item in
                    Button(action: {
                        viewModel.selectedBus = item
                    }) {
                        busItem(for: item)
                    }
                }
            }
        }
        .padding(.top, 10.0)
        .padding([.leading, .trailing], 25)
    }
    
    // MARK: - Views
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
                        Text("\(bus.busType.rawValue)")
                        
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
            .padding(15)
        }
        .frame(maxWidth: .infinity)
    }
}
