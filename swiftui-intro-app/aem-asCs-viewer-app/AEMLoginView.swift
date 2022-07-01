//
//  AEMLoginView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 22/06/2022.
//

import SwiftUI

struct AEMLoginView: View {
    
    @FocusState private var focusedField: Bool
    @StateObject var aemParams = AemInputData()
    @StateObject var aemLogin = AemLogin()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("aem.background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView (showsIndicators: false) { // give the option to navigate over all elements in landscape mode
                    VStack {
                        WelcomeTextLabel()
                        HStack{
                            TextField("IP AEM instance", text: $aemParams.aemIp)
                                .padding()
                                .focused($focusedField)
                                .background(Color(.systemGray6))
                                .cornerRadius(5.0)
                            TextField("Port", text: $aemParams.aemPort)
                                .padding()
                                .frame(maxWidth: 120)
                                .focused($focusedField)
                                .background(Color(.systemGray6))
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 20)
                        
                        TextField("Username", text: $aemLogin.aemUser)
                            .padding()
                            .focused($focusedField)
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        SecureField("Password", text: $aemLogin.aemPassword)
                            .padding()
                            .focused($focusedField)
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        NavigationLink(destination: ContentView(), isActive: $aemLogin.isLoggedin) {
                            EmptyView()
                        }
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
        .environmentObject(aemParams)
        .environmentObject(aemLogin)
        .navigationViewStyle(.stack)
    }
    
    private func performLogin() {
        aemLogin.callAuthPostAPI(aemParams: aemParams)
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
