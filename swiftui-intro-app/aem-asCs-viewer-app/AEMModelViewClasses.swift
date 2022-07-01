//
//  intro-app-classes.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 01/07/2022.
//

import Foundation

class AemLogin : ObservableObject {
    @Published var aemUser: String = ""
    @Published var aemPassword: String = ""
    @Published var isLoggedin: Bool = false
    
    func callAuthPostAPI(aemParams: AemInputData) {
        
        Task {
            let urlString: String = "http://"+aemParams.aemIp+":"+aemParams.aemPort+"/libs/granite/core/content/login.html/j_security_check"

            guard let url =  URL(string: urlString)
            else{
                return
            }
            
            var requestBodyComponents = URLComponents()
            requestBodyComponents.queryItems = [
                URLQueryItem(name: "j_username", value: aemUser),
                URLQueryItem(name: "j_password", value: aemPassword),
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
                        isLoggedin = true
                    }
                }
            }catch let parsingError {
                if isLoggedin == true {
                    isLoggedin = false
                }
                print("Error in authentication request:", parsingError)
            }
        }
    }
}
