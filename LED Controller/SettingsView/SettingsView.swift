//
//  ContentView.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/17/24.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var stock_symbol: String = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
    @State private var zip_code: String = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    @State private var spotify_refresh_token: String = UserDefaults.standard.string(forKey: "spotify_refresh_token") ?? ""
    @State private var client_id: String = UserDefaults.standard.string(forKey: "client_id") ?? ""
    @State private var client_secret: String = UserDefaults.standard.string(forKey: "client_secret") ?? ""
    @State private var channel: String = UserDefaults.standard.string(forKey: "channel") ?? "clock"
    @State private var isSpotifyRefreshTokenVisible: Bool = false
    @State private var isClientIDVisible: Bool = false
    @State private var isClientSecretVisible: Bool = false
    @State private var isWebView = false
    
    
    var body: some View {
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
                    
                    stockSymbolField(stock_symbol: $stock_symbol)
                    zipCodeField(zip_code: $zip_code)
                    
                }
                .padding(.vertical, 10)
                
                Divider()
                    .colorInvert()
                
                HStack {
                    Text("Secrets")
                        .font(.title3)
                        .padding()
                }
                
                Group{
                    spotifyRefreshTokenField(spotify_refresh_token: $spotify_refresh_token,
                                             isSpotifyRefreshTokenVisible: $isSpotifyRefreshTokenVisible,
                                             isWebView: $isWebView
                    )
                    clientIdField(client_id: $client_id, isClientIDVisible: $isClientIDVisible)
                    clientSecretField(client_secret: $client_secret, isClientSecretVisible: $isClientSecretVisible)
                }
                .padding(.vertical, 10)
                .fullScreenCover(isPresented: $isWebView) {
                    if let urlString = apiModel.authUrl, let url = URL(string: urlString) {
                        FullScreenWebView(url: url) {
                            self.isWebView = false
                        }
                    }
                }
                
                    
                Spacer()
                
                Button("Update") {
                    apiModel.update_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code) { statusCode in
                        if statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, spotify_refresh_token: spotify_refresh_token ,channel: channel) { threadSuccess in }
                        }
                    }
                }
                .disabled(stock_symbol.isEmpty || zip_code.isEmpty || client_id.isEmpty || client_secret.isEmpty)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            }
            .padding(.all, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    

