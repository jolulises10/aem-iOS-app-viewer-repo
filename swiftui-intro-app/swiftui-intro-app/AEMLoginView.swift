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
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("aem.background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView (showsIndicators: false) { // give the option to navigate over all elements in landscape mode
                    VStack {
                        /*Spacer()
                            .frame(minHeight: 10, idealHeight: 110)
                            .fixedSize()*/
                        
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
                        NavigationLink(destination: ContentView(), isActive: $aemParams.isLoggedin) {
                            EmptyView()
                        }
                        //LoginButtonLabel()
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
        .navigationViewStyle(.stack)
    }
    
    private func performLogin() {
        /*var securityCheckTmp = AEMSecurityCheckRequest()
        securityCheckTmp.user = $username.wrappedValue
        securityCheckTmp.pwd = $password.wrappedValue*/
        
        Task {
            aemParams.isLoggedin = await callAuthPostAPI()
        }
        
        print("updating isLoggedin to true: \($aemParams.isLoggedin)")
    }
    
    private func callAuthPostAPI() async -> Bool {
        
        var loginSuccessful: Bool
        loginSuccessful = false
        
        let urlString: String = "http://"+$aemParams.aemIp.wrappedValue+":"+$aemParams.aemPort.wrappedValue+"/libs/granite/core/content/login.html/j_security_check"

        guard let url =  URL(string: urlString)
        else{
            return loginSuccessful
        }
        
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "j_username", value: $username.wrappedValue),
            URLQueryItem(name: "j_password", value: $password.wrappedValue),
            URLQueryItem(name: "_charset_", value: "UTF-8")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            print("reading data response: ")
            print(data)
            print("reading response: ")
            if let httpResponse = response as? HTTPURLResponse {
                //if statusCode is 200 ok, 401 not authorised and data is empty
                if (200...299).contains(httpResponse.statusCode) && data.count > 0 {
                    loginSuccessful = true
                }
                let cs = HTTPCookieStorage.shared//.cookies(for: url)
                print(cs.cookies!)
            }
        }catch let parsingError {
            print("Error", parsingError)
        }
        
        
        return loginSuccessful
    }
    
    /* init(){
        self.aemParams = AemInputData()
    }*/
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
