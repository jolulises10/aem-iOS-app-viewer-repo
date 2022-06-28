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

struct AEMSecurityCheckRequest: Codable {
    var user: String
    var pwd: String
    
    init() {
        self.user = "Initial values"
        self.pwd = "Initial values"
      }
}

class AemInputData : ObservableObject {
    @Published var aemIp: String = ""
    @Published var aemPort: String = ""
    @Published var isLoggedin: Bool = false
}
