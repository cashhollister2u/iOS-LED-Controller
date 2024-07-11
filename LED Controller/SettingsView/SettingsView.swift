//
//  ContentView.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/17/24.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var apiModel: ApiConnectModel
    @EnvironmentObject var dataModel: DataModel
    
    @State private var client_id: String = "cc3c15a0cadf9c"
    @State private var channel: String = UserDefaults.standard.string(forKey: "channel") ?? "weather"
    @State private var isLoading: Bool = false
    @State private var progressText: String = "Updating Display Data..."
    @State private var showConfirmationDialog = false
    @State private var isSpotifyRefreshTokenVisible: Bool = false
    @State private var isWebView = false
    
    //note
    
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack {
                    HStack {
                        Text("Settings")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    
                    Divider()
                        .colorInvert()
                    
                    HStack {
                        Text("User Inputs")
                            .font(.title3)
                            .padding()
                    }
                    
                    Group {
                        
                        stockSymbolField(stock_symbol: $dataModel.stockSymbol)
                        zipCodeField(zip_code: $dataModel.zipCode)
                        //brightnessSlider(brightness: $dataModel.brightness)
                        
                    }
                    .padding(.vertical, 5)
                    
                    Divider()
                        .colorInvert()
                    
                    HStack {
                        Text("Secrets")
                            .font(.title3)
                            .padding()
                    }
                    Group{
                        spotifyRefreshTokenField(isSpotifyRefreshTokenVisible: $isSpotifyRefreshTokenVisible,
                                                 isWebView: $isWebView
                        )
                    }
                    .fullScreenCover(isPresented: $isWebView) {
                        if let urlString = apiModel.authUrl, let url = URL(string: urlString) {
                            FullScreenWebView(url: url) {
                                self.isWebView = false
                            }
                        }
                    }
                    Spacer()
                }
                VStack {
                    Text("* Updates trigger additional api requests")
                        .foregroundStyle(Color(.red))
                        .padding(.bottom, 10)

                    Button("Save") {
                        showConfirmationDialog = true
                    }
                    .disabled(dataModel.stockSymbol.isEmpty || dataModel.zipCode.isEmpty)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .confirmationDialog(
                                    "This will trigger a request from the altered api(s)",
                                    isPresented: $showConfirmationDialog,
                                    titleVisibility: .visible
                                ) {
                                    Button("Update Data", role: .destructive) {
                                        dataModel.saveDefaults()
                                        update_display_data()
                                        
                                    }
                                    Button("Cancel", role: .cancel) { }
                                }
                }
                .padding(.top, 30)
                
            }
            .scrollDismissesKeyboard(.interactively)
            .padding(.all, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            if isLoading {
                
                Color.black.opacity(0.85)
                    .edgesIgnoringSafeArea(.all)
                ProgressView(progressText)
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
    
    // Function to start the shutdown process
    private func update_display_data() {
        isLoading = true
        progressText = "Display Data Updated"
        
        apiModel.update_user_thread(client_id: client_id, stock_symbol: dataModel.stockSymbol, zip_code: dataModel.zipCode, brightness: dataModel.brightness)
            
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in isLoading = false }
        
    }
    
    
}
