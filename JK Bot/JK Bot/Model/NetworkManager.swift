import Foundation

class NetworkManager {
    private let apiKey = "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"
    private let apiURL = "https://openrouter.ai/api/v1/chat/completions"
    
    func sendMessage(message: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: apiURL) else {
            print("URL milena")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        // Creating request body
        let requestBody: [String: Any] = [
            "model": "deepseek/deepseek-chat:free",
            "messages": [
                ["role": "user", "content": message]
            ]
        ]

        // Convert dictionary to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to encode request body: \(error.localizedDescription)")
            return
        }
        
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

            // Parse JSON response
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Parsed JSON: \(json)")
                    
                    if let choices = json["choices"] as? [[String: Any]],
                       let firstChoice = choices.first,
                       let messageDict = firstChoice["message"] as? [String: Any],
                       let reply = messageDict["content"] as? String {
                        completion(reply)
                    } else {
                        print("Key 'message.content' not found in response")
                    }
                }
            } catch {
                print("Failed to parse response as JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
