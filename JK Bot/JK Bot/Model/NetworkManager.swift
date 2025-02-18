//
//  NetworkManager.swift
//  JK Bot
//
//  Created by Janak Khadka on 18/02/2025.
//

import Foundation

class NetworkManager {
    private let apiKey = "sk-c2a8ab90f8f446269dad0d961a8a9973"
    private let apiURL = "https://api.deepseek.com"
    
    func sendMessage(message: String, completion: @escaping (String) ->Void){
        guard let url = URL(string: apiURL) else {
            print("URL milena")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            // Print raw response data as a string
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw API Response: \(rawResponse)")
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print("Parsed JSON: \(json)")
                if let reply = json["reply"] as? String {
                    completion(reply)
                } else {
                    print("Key 'reply' not found in response")
                }
            } else {
                print("Failed to parse response as JSON")
            }
        }
        task.resume()
    }
}
