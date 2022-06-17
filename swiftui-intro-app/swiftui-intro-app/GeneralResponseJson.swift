//
//  GeneralResponseJson.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 13/06/2022.
//

import Foundation

struct MockResponse: Codable {
    let message: String
    let errorMessage: String
    
    init() {
        self.message = "Initial values"
        self.errorMessage = "Initial values"
      }
}

struct AEMPageResponse: Codable {
    let title: String
    let text: String
    let message: String
    
    init() {
        self.title = "Initial values"
        self.text = "Initial values"
        self.message = "Initial values"
      }
}
