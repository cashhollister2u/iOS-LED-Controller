//
//  Components.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/18/24.
//

import SwiftUI


struct stockSymbolField: View {
    @Binding var stock_symbol: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Stock Symbol")
                Spacer()
            }
            if stock_symbol == "" {
                Text("*Stock Symbol field required")
                    .foregroundStyle(Color(.red))
            }
            TextField(
                "Stock Symbol",
                text: $stock_symbol
            )
            .textCase(.uppercase)
            .textFieldStyle(.roundedBorder)
            .onChange(of: stock_symbol) { oldValue, newValue in
                            let updatedValue = newValue.uppercased()
                            stock_symbol = updatedValue
                            UserDefaults.standard.set(updatedValue, forKey: "stock_symbol")
                        }
        }
    }
}

struct zipCodeField: View {
    @Binding var zip_code: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Zip Code")
                Spacer()
            }
            if zip_code == "" {
                Text("*Zip Code field required")
                    .foregroundStyle(Color(.red))
            }
            TextField(
                "Zip Code",
                text: $zip_code
            )
            .textFieldStyle(.roundedBorder)
            .onChange(of: zip_code) {UserDefaults.standard.set(self.zip_code, forKey: "zip_code")}
        }
    }
}


struct spotifyRefreshTokenField: View {
    @Binding var isSpotifyRefreshTokenVisible: Bool
    @Binding var isWebView: Bool
    @EnvironmentObject var apiModel: ApiConnectModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing:  10) {
            HStack {
                Text("Spotify Authentication")
                Spacer()
                
            }
            if isSpotifyRefreshTokenVisible && apiModel.Spot_Auth_Code == 204 {
                Text("* Authentication Successful")
                    .foregroundStyle(Color(.green))
            }
            HStack {
                if  isSpotifyRefreshTokenVisible {
                    Button("Authenticate") {
                        apiModel.get_user_spotify_auth_url()
                        isWebView = true
                    }
                    .frame(width: 200, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    isSpotifyRefreshTokenVisible.toggle()
                }) {
                    Label(isSpotifyRefreshTokenVisible ? "Hide" : "Show", systemImage: isSpotifyRefreshTokenVisible ? "eye.slash" : "eye")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}
        
struct clientIdField: View {
    @Binding var client_id: String
    @Binding var isClientIDVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing:  10) {
            HStack {
                Text("Client Id")
                Spacer()
            }
            if client_id == "" {
                Text("*Client Id field required")
                    .foregroundStyle(Color(.red))
            }
        }
        HStack {
           
            if isClientIDVisible {
                
                TextField(
                    "Client Id",
                    text: $client_id
                )
                .textFieldStyle(.roundedBorder)
                .onChange(of: client_id) {
                                UserDefaults.standard.set(self.client_id, forKey: "client_id")
                            }
            }
            Spacer()
            Button(action: {
                isClientIDVisible.toggle()
            }) {
                Label(isClientIDVisible ? "Hide" : "Show", systemImage: isClientIDVisible ? "eye.slash" : "eye")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

