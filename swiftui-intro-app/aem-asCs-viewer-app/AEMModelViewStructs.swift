//
//  GeneralResponseJson.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 13/06/2022.
//

import Foundation

//this struct was for testing purposes with an external mock api. Leaving there for the moment
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

class AemInputData : ObservableObject {
    @Published var aemIp: String = ""
    @Published var aemPort: String = ""
}
