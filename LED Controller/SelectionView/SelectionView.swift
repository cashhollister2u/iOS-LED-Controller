//
//  SelectionView.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/18/24.
//

import SwiftUI

struct SelectionView: View {
    @State private var channel: String = UserDefaults.standard.string(forKey: "channel") ?? ""
    @EnvironmentObject var apiModel: ApiConnectModel
    @State private var isLoading: Bool = false
    @State private var progressText: String = "Loading Display..."
    
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
                        clockButton(channel: $channel, isLoading: $isLoading, progressText: $progressText)
                        stockButton(channel: $channel, isLoading: $isLoading, progressText: $progressText)
                        spotifyButton(channel: $channel, isLoading: $isLoading, progressText: $progressText)
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
                ProgressView(progressText)
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
        }
    }
}
