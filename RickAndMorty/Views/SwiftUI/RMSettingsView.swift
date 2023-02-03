//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 03.02.2023.
//

import SwiftUI

struct RMSettingsView: View {
    
    // MARK: - Private Properties
    private let viewModel: RMSettingsViewViewModel
    
    var body: some View {
        List(viewModel.cellViewModels) { cellViewModel in
            HStack {
                if let image = cellViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(cellViewModel.iconContainerView))
                        .cornerRadius(6)
                }
                Text(cellViewModel.title)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.bottom, 3)
            .onTapGesture {
                cellViewModel.onDidTapHandler(cellViewModel.type)
            }
        }
    }
    
    // MARK: - Init
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: RMSettingsViewViewModel(viewModels: RMSettingsOption.allCases.compactMap({
            RMSettingsCellViewModel(type: $0) { option in
        }
        })))
    }
}
