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
        }
    }
}


struct spotifyRefreshTokenField: View {
    @Binding var isSpotifyRefreshTokenVisible: Bool
    @Binding var isWebView: Bool
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var isfirstView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing:  10) {
            HStack {
                Text("Spotify Authentication")
                Spacer()
                
            }
            if isSpotifyRefreshTokenVisible && apiModel.Spot_Auth_Code == 204 && isfirstView{
                Text("* Authentication Successful")
                    .foregroundStyle(Color(.green))
            }
            HStack {
                if  isSpotifyRefreshTokenVisible {
                    Button("Authenticate") {
                        apiModel.get_user_spotify_auth_url()
                        isWebView = true
                        isfirstView = true
                    }
                    .frame(width: 200, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.vertical, 10)
                }
                
                Spacer()
                
                Button(action: {
                    isSpotifyRefreshTokenVisible.toggle()
                    if isSpotifyRefreshTokenVisible {
                        isfirstView = false
                    }
                }) {
                    Label(isSpotifyRefreshTokenVisible ? "Hide" : "Show", systemImage: isSpotifyRefreshTokenVisible ? "eye.slash" : "eye")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}
        


