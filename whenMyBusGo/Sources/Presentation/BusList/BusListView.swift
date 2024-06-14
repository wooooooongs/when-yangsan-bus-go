//
//  BusTimetableView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/5/24.
//

import SwiftUI

struct BusListView: View {
    @EnvironmentObject var busTimetableManager: BusTimetableManager
    @ObservedObject var viewModel = BusListViewModel()
    
    
    // MARK: - Body View
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            
            VStack {
                BusTypesView(viewModel: viewModel)
                
                Divider()
                
                BusItemsView(viewModel: viewModel)
            }
            .padding(.top, 20)
        }
        .sheet(item: $viewModel.currentBus) { bus in
            BusDetailSheetView(busData: .constant(bus))
                .transparentSheetBackground()
        }
        .navigationTitle("버스 목록")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.currentBusList = busTimetableManager.busTimetables
        }
    }
    
    // MARK: - Views
    private var background: Color {
        Color(hex: "EEEEEE")
    }
}

#Preview {
    BusListView()
        .environmentObject(BusTimetableManager())
        .tint(.black)
}
