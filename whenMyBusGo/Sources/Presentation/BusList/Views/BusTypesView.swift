//
//  BusTypesView.swift
//  whenMyBusGo
//
//  Created by Oscar on 6/14/24.
//

import SwiftUI

struct BusTypesView: View {
    @EnvironmentObject var busTimetableManager: BusTimetableManager
    @ObservedObject var viewModel: BusListViewModel

    
    // MARK: - Body View
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(BusType.allCases, id: \.self) { busType in
                    Button(action: {
                        viewModel.currentBusType = busType
                        viewModel.currentBusList = busTimetableManager.getBusTimetableDatas(forType: busType)
                        // TODO: 현재: Manager에 filter를 매번 요청함. 프론트에서 다루는 건 어떨까?
                    }) {
                        CategoryButton(title: busType.caseName, selectedItem: $viewModel.currentBusType, item: busType)
                    }
                }
            }
            .padding(.horizontal, 30)
        }
        .scrollIndicators(.hidden)
    }
    
    
    // MARK: - Views
    
    
    
    // MARK: - Methods
    
}
