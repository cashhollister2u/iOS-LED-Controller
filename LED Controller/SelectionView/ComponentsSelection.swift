//
//  Components.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/18/24.
//

import SwiftUI

let button_width:CGFloat = 300
let button_height:CGFloat = 45

struct clockbutton: View {
    @Binding var channel: String
    @EnvironmentObject var apiModel: ApiConnectModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                channel = "clock"
                apiModel.update_user_channel(channel: "clock") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread()
                        }
                    }
                }) {
                Text("Clock")
                    .font(.title3)
                    .frame(width: button_width, height: button_height)
                    .contentShape(Rectangle())
                    .padding(20)
            }
            .background(channel == "clock" ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color(red: 0.10, green: 0.10, blue: 0.10))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
        }
    }
}

struct stockButton: View {
    @Binding var channel: String
    @EnvironmentObject var apiModel: ApiConnectModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                channel = "stock"
                apiModel.update_user_channel(channel: "stock") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread()
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

struct spotifyButton: View {
    @Binding var channel: String
    @EnvironmentObject var apiModel: ApiConnectModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                channel = "spotify"
                apiModel.update_user_channel(channel: "spotify") { success in
                        if success && apiModel.statusCode == 404 {
                            apiModel.start_user_thread()
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

