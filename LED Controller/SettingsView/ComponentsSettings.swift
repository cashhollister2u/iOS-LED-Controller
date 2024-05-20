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

struct timeZoneField: View {
    @Binding var time_zone: String
    @Binding var country: String
    
    let America = [
        "Denver","Los_Angeles", "New_York", "Sitka", "Sao_Paulo", "Scoresbysund", "St_Johns", "Swift_Current", "Tegucigalpa", "Thule", "Tijuana", "Toronto", "Vancouver", "Whitehorse", "Winnipeg", "Yakutat"
    ]
    let Asia = [
        "Hong_Kong"
    ]
    let Australia = [
        "Sydney"
    ]
    let Europe = [
        "London", "Madrid", "Moscow", "Paris", "Rome"
    ]
    let Pacific = [
        "Guam", "Honolulu"
    ]
    
    var timeZones: [String] {
            switch country {
            case "America":
                return America
            case "Asia":
                return Asia
            case "Australia":
                return Australia
            case "Europe":
                return Europe
            case "Pacific":
                return Pacific
            default:
                return []
            }
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Time Zone")
                Spacer()
            }
            if time_zone == "" {
                Text("*Time Zone field required")
                    .foregroundStyle(Color(.red))
            }
            Picker("Select Time Zone", selection: $time_zone) {
                            ForEach(timeZones, id: \.self) { timeZone in
                                Text(timeZone).tag(timeZone)
                            }
                        }
            .onChange(of: time_zone) {UserDefaults.standard.set(self.time_zone, forKey: "time_zone")}
        }
    }
}
    
struct countryField: View {
    @Binding var country: String
    let countries = [
        "America", "Asia", "Australia", "Europe", "Pacific"
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Country")
                Spacer()
            }
            if country == "" {
                Text("*Country field required")
                    .foregroundStyle(Color(.red))
            }
            Picker("Select Country", selection: $country) {
                            ForEach(countries, id: \.self) { location in
                                Text(location).tag(location)
                            }
                        }
            .onChange(of: country) {UserDefaults.standard.set(self.country, forKey: "country")}
        }
    }
}

struct spotifyRefreshTokenField: View {
    @Binding var spotify_refresh_token: String
    @Binding var isSpotifyRefreshTokenVisible: Bool
    @Binding var isWebView: Bool
    @EnvironmentObject var apiModel: ApiConnectModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing:  10) {
            HStack {
                Text("Spotify Refresh Token")
                Spacer()
            }
            if spotify_refresh_token == "" {
                Text("*Spotify Refresh Token field required")
                    .foregroundStyle(Color(.red))
            }
            if isSpotifyRefreshTokenVisible {
                if let res = apiModel.refresh_token {
                    TextField(
                        "Spotify Refresh Token",
                        text: $spotify_refresh_token
                    )
                    .onAppear {
                        self.spotify_refresh_token = res
                    }
                } else {
                    TextField(
                        "Spotify Refresh Token",
                        text: $spotify_refresh_token
                    )
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: spotify_refresh_token) {UserDefaults.standard.set(self.spotify_refresh_token, forKey: "spotify_refresh_token")}
                }
            }
            
            
            HStack {
                if  isSpotifyRefreshTokenVisible {
                    Button("Get Refresh Token") {
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
        }
        HStack {
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

struct clientSecretField: View {
    @Binding var client_secret: String
    @Binding var isClientSecretVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing:  10) {
            HStack {
                Text("Client Secret")
                Spacer()
            }
            if client_secret == "" {
                Text("*Client Secret field required")
                    .foregroundStyle(Color(.red))
            }
            if isClientSecretVisible {
                
                TextField(
                    "Client Secret",
                    text: $client_secret
                )
                .textFieldStyle(.roundedBorder)
                .onChange(of: client_secret) { oldValue, newValue in
                    UserDefaults.standard.set(newValue, forKey: "client_secret")
                }
            }
        }
        HStack {
            Spacer()
            Button(action: {
                isClientSecretVisible.toggle()
            }) {
                Label(isClientSecretVisible ? "Hide" : "Show", systemImage: isClientSecretVisible ? "eye.slash" : "eye")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
    
