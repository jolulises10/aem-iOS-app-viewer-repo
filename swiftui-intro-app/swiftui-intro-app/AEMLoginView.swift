//
//  AEMLoginView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 22/06/2022.
//

import SwiftUI

struct AEMLoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var aemIp: String = ""
    @FocusState private var focusedField: Bool
    
    var body: some View {
        ZStack {
            Image("aem.background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView (showsIndicators: false) {
                VStack {
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 110)
                        .fixedSize()
                    
                    Text("Welcome to Adobe Experience Manager Mobile")
                        .padding()
                        .font(.title)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                    
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
                    
                    Button(action: {print("Button tapped")}) {
                        Text("LOGIN")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
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
}

struct AEMLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AEMLoginView()
            .previewInterfaceOrientation(.portrait)
    }
}
