//
//  Components.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/18/24.
//

import SwiftUI

let button_width:CGFloat = 300
let button_height:CGFloat = 45

struct clockButton: View {
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var stock_symbol: String = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
    @State private var zip_code: String = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    @State private var client_id: String = UserDefaults.standard.string(forKey: "client_id") ?? ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "weather"
                progressText = "Loading Display..."
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
                                progressText = "Manually reset led display"
                            }
                apiModel.update_user_channel(client_id: client_id, channel: "weather") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel) { threadSuccess in
                                isLoading = false
                            }
                        } else {
                            isLoading = false
                        }
                    }
                }) {
                Text("Clock / Weather")
                    .font(.title3)
                    .frame(width: button_width, height: button_height)
                    .contentShape(Rectangle())
                    .padding(20)
            }
            .background(channel == "weather" ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color(red: 0.10, green: 0.10, blue: 0.10))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
        }
    }
}

struct stockButton: View {
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var stock_symbol: String = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
    @State private var zip_code: String = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    @State private var client_id: String = UserDefaults.standard.string(forKey: "client_id") ?? ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "stock"
                progressText = "Loading Display..."
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
                                progressText = "Manually reset led display"
                            }
                apiModel.update_user_channel(client_id: client_id, channel: "stock") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel) { threadSuccess in
                                isLoading = false
                            }
                        } else{
                            isLoading = false
                        }
                    }
                
                }) {
                Text("Stock")
                    .font(.title3)
                    .frame(width: button_width, height: button_height)
                    .contentShape(Rectangle())
                    .padding(20)
            }
            .background(channel == "stock" ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color(red: 0.10, green: 0.10, blue: 0.10))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
        }
    }
}

struct stock_clock_Button: View {
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var stock_symbol: String = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
    @State private var zip_code: String = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    @State private var client_id: String = UserDefaults.standard.string(forKey: "client_id") ?? ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "clock_stock"
                progressText = "Loading Display..."
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
                                progressText = "Manually reset led display"
                            }
                apiModel.update_user_channel(client_id: client_id, channel: "clock_stock") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel) { threadSuccess in
                                isLoading = false
                            }
                        } else{
                            isLoading = false
                        }
                    }
                
                }) {
                Text("Clock / Stock")
                    .font(.title3)
                    .frame(width: button_width, height: button_height)
                    .contentShape(Rectangle())
                    .padding(20)
            }
            .background(channel == "clock_stock" ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color(red: 0.10, green: 0.10, blue: 0.10))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
        }
    }
}

struct spotifyButton: View {
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var stock_symbol: String = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
    @State private var zip_code: String = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    @State private var client_id: String = UserDefaults.standard.string(forKey: "client_id") ?? ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "spotify"
                progressText = "Loading Display..."
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
                                progressText = "Manually reset led display"
                            }
                apiModel.update_user_channel(client_id: client_id, channel: "spotify") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel) { threadSuccess in
                                isLoading = false
                            }
                        } else {
                            isLoading = false
                        }
                    }
                
                }) {
                Text("Spotify")
                    .font(.title3)
                    .frame(width: button_width, height: button_height)
                    .contentShape(Rectangle())
                    .padding(20)
            }
            .background(channel == "spotify" ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color(red: 0.10, green: 0.10, blue: 0.10))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
        }
    }
}

struct spotify_2_Button: View {
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var stock_symbol: String = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
    @State private var zip_code: String = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    @State private var client_id: String = UserDefaults.standard.string(forKey: "client_id") ?? ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "spotify2"
                progressText = "Loading Display..."
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
                                progressText = "Manually reset led display"
                            }
                apiModel.update_user_channel(client_id: client_id, channel: "spotify2") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel) { threadSuccess in
                                isLoading = false
                            }
                        } else {
                            isLoading = false
                        }
                    }
                
                }) {
                Text("Spotify")
                    .font(.title3)
                    .frame(width: button_width, height: button_height)
                    .contentShape(Rectangle())
                    .padding(20)
            }
            .background(channel == "spotify2" ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color(red: 0.10, green: 0.10, blue: 0.10))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
        }
    }
}
