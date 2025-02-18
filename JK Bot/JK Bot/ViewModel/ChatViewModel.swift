//
//  ChatViewModel.swift
//  JK Bot
//
//  Created by Janak Khadka on 18/02/2025.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []  //publised le chai view lai notify garxa if they change
    @Published var userInput: String = ""
    private let networkManager = NetworkManager()
    
    func sendMessage() {
        let userMessage = Message(text: userInput, isUser: true)
        messages.append(userMessage)
        userInput = ""
        
        networkManager.sendMessage(message: userMessage.text){ reply in
            DispatchQueue.main.async {
                let botMessage = Message(text: reply, isUser: false)
                self.messages.append(botMessage)
            }
        }
    }
}

