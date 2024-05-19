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
    
    var body: some View {
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
                    clockbutton(channel: $channel)
                    stockButton(channel: $channel)
                    spotifyButton(channel: $channel)
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
    }
}
