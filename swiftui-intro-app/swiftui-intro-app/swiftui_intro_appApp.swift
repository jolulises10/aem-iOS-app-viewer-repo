//
//  swiftui_intro_appApp.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 07/06/2022.
//

import SwiftUI

@main
struct swiftui_intro_appApp: App {
    
    //@EnvironmentObject var userAuth: AemInputData
    
    var body: some Scene {
        WindowGroup {
            
            
            //if !userAuth.isLoggedin {
                AEMLoginView()
            //}
             /*else {
                ContentView()
            }*/
        }
    }
    
    /*init() {
        self.userAuth = AemInputData()
    }*/
}
