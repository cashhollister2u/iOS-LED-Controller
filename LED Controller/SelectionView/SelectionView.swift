//
//  SelectionView.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/18/24.
//

import SwiftUI

struct SelectionView: View {
    @State private var channel: String = UserDefaults.standard.string(forKey: "channel") ?? "clock"
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Display")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    Divider()
                        .colorInvert()
                    
                    VStack {
                        HStack {
                            Text("Select Display")
                                .font(.title2)
                                .padding(.vertical, 50)
                        }
                        clockButton(channel: $channel, isLoading: $isLoading)
                        stockButton(channel: $channel, isLoading: $isLoading)
                        spotifyButton(channel: $channel, isLoading: $isLoading)
                    }
                    .padding(.vertical, 40)
                    
                    if let statusCode = apiModel.statusCode {
                        if statusCode == 204 {
                            Text(channel)
                        }
                    }
                }
                .padding(.all, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            if isLoading {
                Color.black.opacity(0.85)
                    .edgesIgnoringSafeArea(.all)
                ProgressView("Loading Display...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
        }
    }
}
