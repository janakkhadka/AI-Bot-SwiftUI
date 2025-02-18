//
//  Message.swift
//  JK Bot
//
//  Created by Janak Khadka on 18/02/2025.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
