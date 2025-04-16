//
//  DebugView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/15/25.
//

import SwiftUI

struct DebugView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: RecipesListViewModel
    @State private var enableDebugHappyPath = true
    @State private var enableDebugMisformed = false
    @State private var enableDebugEmpty = false
    
    var networkManager = NetworkManager.shared
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Toggle("Enable Debug Mode - Happy Path", isOn: $viewModel.enableDebugHappyPath)
                }
                .padding(.horizontal)
                .padding(.top)
                HStack {
                    Toggle("Enable Debug Mode - Misformed", isOn: $viewModel.enableDebugMisformed)
                }
                .padding(.horizontal)
                HStack {
                    Toggle("Enable Debug Mode - Empty", isOn: $viewModel.enableDebugEmpty)
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarTitle(Text("Debug Settings"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if viewModel.enableDebugMisformed {
                            viewModel.loadData(url: NetworkManager.Constants.URL.APIMalformedPath)
                        } else if viewModel.enableDebugEmpty {
                            viewModel.loadData(url: NetworkManager.Constants.URL.APIEmptyPath)
                        } else {
                            viewModel.loadData(url: NetworkManager.Constants.URL.APIHappyPath)
                        }
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing)
                            .padding(.top)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
