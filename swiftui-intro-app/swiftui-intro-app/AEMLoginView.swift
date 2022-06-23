//
//  AEMLoginView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 22/06/2022.
//

import SwiftUI

struct AEMLoginView: View {
    
    @FocusState private var focusedField: Bool
    @State var aemIp: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Image("aem.background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView (showsIndicators: false) { // give the option to navigate over all elements in landscape mode
                VStack {
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 110)
                        .fixedSize()
                    
                    WelcomeTextLabel()
                    TextField("IP AEM instance", text: $aemIp)
                        .padding()
                        .focused($focusedField)
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    TextField("Username", text: $username)
                        .padding()
                        .focused($focusedField)
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    SecureField("Password", text: $password)
                        .padding()
                        .focused($focusedField)
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button(action: performLogin) {
                        LoginButtonLabel()
                    }
                }
                .padding()
                .frame(width: 410)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = false
                        }
                    }
                }
            }
        }
    }
    
    func performLogin(){
        print("Values: ")
        print($aemIp)
        print($username)
        print($password)
        print("Values END ")
        ContentView(aemIpParam: $aemIp)
    }
}

struct AEMLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AEMLoginView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct WelcomeTextLabel: View {
    var body: some View {
        Text("Welcome to Adobe Experience Manager Mobile")
            .padding()
            .font(.title)
            .background(Color.black.opacity(0.5))
            .foregroundColor(.white)
            .padding(.bottom, 50)
    }
}

struct LoginButtonLabel: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
