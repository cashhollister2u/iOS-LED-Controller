//
//  ContentViewModel.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/17/24.
//

import Foundation

class ApiConnectModel: ObservableObject {
    @Published var statusCode: Int?
    @Published var responseBody: String?
    @Published var authUrl: String?
    @Published var refresh_token: String?
    //change when api moves to production env
    let baseUrl = "http://127.0.0.1:6000"
    
    func start_user_thread(client_id:String, stock_symbol:String, zip_code:String, time_zone:String, country:String, spotify_refresh_token:String, channel:String) {
        let urlString = "\(baseUrl)/start/\(client_id)/\(stock_symbol)/\(zip_code)/\(time_zone)/\(country)/\(spotify_refresh_token)/\(channel)"
        NetworkManager.shared.fetchData(from: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self.statusCode = message.statusCode
                    self.responseBody = message.responseBody
                case .failure(let error):
                    self.responseBody = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func update_user_thread(client_id:String, stock_symbol:String, zip_code:String, time_zone:String, country:String, completion: @escaping (Int) -> Void) {
        let urlString = "\(baseUrl)/update/\(client_id)/\(stock_symbol)/\(zip_code)/\(time_zone)/\(country)"
        NetworkManager.shared.fetchData(from: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self.statusCode = message.statusCode
                    self.responseBody = message.responseBody
                    completion(message.statusCode)
                case .failure(let error):
                    self.responseBody = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func update_user_channel(client_id:String, channel:String, completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseUrl)/channel/\(client_id)/\(channel)"
        NetworkManager.shared.fetchData(from: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self.statusCode = message.statusCode
                    self.responseBody = message.responseBody
                    completion(true)
                case .failure(let error):
                    self.responseBody = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func get_user_spotify_auth_url() {
        let urlString = "\(baseUrl)/auth_url"
        NetworkManager.shared.fetchData(from: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self.statusCode = message.statusCode
                    self.authUrl = message.responseBody
                case .failure(let error):
                    self.responseBody = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func get_user_spotify_refresh_token(auth_code:String) {
        let urlString = "\(baseUrl)/spotify_refresh/\(auth_code)"
        NetworkManager.shared.fetchData(from: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self.statusCode = message.statusCode
                    self.refresh_token = message.responseBody
                    UserDefaults.standard.set(message.responseBody, forKey: "spotify_refresh_token")
                    print("apiconnect\(message.responseBody)")
                case .failure(let error):
                    self.responseBody = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
