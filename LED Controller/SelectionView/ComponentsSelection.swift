//
//  Components.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/18/24.
//

import SwiftUI

let button_width:CGFloat = 300
let button_height:CGFloat = 45


struct off_button: View {
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var client_id: String = "cc3c15a0cadf9c"
    @State private var showConfirmationDialog = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                showConfirmationDialog = true
                }) {
                Image(systemName: "power.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(5)
            }
            .cornerRadius(10)
            .shadow(radius: 10)
            .foregroundColor(.gray)
            .confirmationDialog(
                            "Are you sure you want to shut down the display?",
                            isPresented: $showConfirmationDialog,
                            titleVisibility: .visible
                        ) {
                            Button("Shut Down", role: .destructive) {
                                startShutdownProcess()
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                    }
                }
    
    // Function to start the shutdown process
    private func startShutdownProcess() {
        isLoading = true
        progressText = "Shutting Down Display..."
        
        let timeoutTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            if isLoading {
                progressText = "Failed to Shut Down Display"
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in isLoading = false }
            }
        }
        apiModel.turn_off_display(client_id: client_id) { success in
            timeoutTimer.invalidate()
            if success {
                progressText = "Shut Down Successful"
            } else {
                progressText = "Failed to Shut Down Display"
            }
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in isLoading = false }
        }
    }
}

struct clockButton: View {
    @Binding var stock_symbol: String
    @Binding var zip_code: String
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @EnvironmentObject var dataModel: DataModel
    @State private var client_id: String = "cc3c15a0cadf9c"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "weather"
                progressText = "Loading Display..."
                
                Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in isLoading = false }
                
                apiModel.update_user_channel(client_id: client_id, channel: "weather") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel, brightness: dataModel.brightness) { threadSuccess in
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
    @Binding var stock_symbol: String
    @Binding var zip_code: String
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @EnvironmentObject var dataModel: DataModel
    @State private var client_id: String = "cc3c15a0cadf9c"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "stock"
                progressText = "Loading Display..."
                
                Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in isLoading = false }
                
                apiModel.update_user_channel(client_id: client_id, channel: "stock") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel, brightness: dataModel.brightness) { threadSuccess in
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
    @Binding var stock_symbol: String
    @Binding var zip_code: String
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @EnvironmentObject var dataModel: DataModel
    @State private var client_id: String = "cc3c15a0cadf9c"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "clock_stock"
                progressText = "Loading Display..."
                
                Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in isLoading = false }
                
                apiModel.update_user_channel(client_id: client_id, channel: "clock_stock") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel, brightness: dataModel.brightness) { threadSuccess in
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


struct spotify_2_Button: View {
    @Binding var stock_symbol: String
    @Binding var zip_code: String
    @Binding var channel: String
    @Binding var isLoading: Bool
    @Binding var progressText: String
    @EnvironmentObject var apiModel: ApiConnectModel
    @EnvironmentObject var dataModel: DataModel
    @State private var client_id: String = "cc3c15a0cadf9c"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                isLoading = true
                channel = "spotify2"
                progressText = "Loading Display..."
                
                Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in isLoading = false }
                
                apiModel.update_user_channel(client_id: client_id, channel: "spotify2") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread(client_id: client_id, stock_symbol: stock_symbol, zip_code: zip_code, channel: channel, brightness: dataModel.brightness) { threadSuccess in
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
