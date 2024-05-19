//
//  LED_ControllerApp.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/17/24.
//

import SwiftUI

@main
struct LED_Controller: App {
    var apiModel = ApiConnectModel()
    var body: some Scene {
        WindowGroup {
            TabView {
                SelectionView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .background(Color.black)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .background(Color.black)
            }
            .background(Color.black)
            .accentColor(.white)
            .environment(\.colorScheme, .dark)
            .environmentObject(apiModel)
            
        }
    }
}
