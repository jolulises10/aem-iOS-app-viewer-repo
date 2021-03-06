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
    
    func callAuthPostAPI(urlString: String) {
        
        Task {
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
                //let (data, response) = try await urlSession.data(for: request)
                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse {
                    //if statusCode is 200 ok, 401 not authorised and data is empty
                    if (200...299).contains(httpResponse.statusCode) && data.count > 0 {
                        DispatchQueue.main.async {
                            self.isLoggedin = true
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.isLoggedin = false
                        }
                    }
                }
            }catch let parsingError {
                if isLoggedin == true {
                    DispatchQueue.main.async {
                        self.isLoggedin = false
                    }
                }
                print("Error in authentication request:", parsingError)
            }
        }
    }
    
    func callLogoutGetAPI(urlString: String) {
        
        guard let url =  URL(string: urlString)
        else{
            return
        }
        
        Task {
            do{
                let ( _, response) = try await URLSession.shared.data(from: url)
                if let httpResponse = response as? HTTPURLResponse {
                    if (401...403).contains(httpResponse.statusCode){
                        DispatchQueue.main.async {
                            self.isLoggedin = false
                        }
                    }
                }
            }catch let parsingError {
                DispatchQueue.main.async {
                    self.isLoggedin = true
                }
                print("Error in logout request:", parsingError)
            }
        }
    }
}

class AemInputData : ObservableObject {
    @Published var aemIp: String = ""
    @Published var aemPort: String = ""
    
    func returnLoginUrl() -> String {
        return "http://"+aemIp+":"+aemPort+"/libs/granite/core/content/login.html/j_security_check"
    }
    
    func returnLogoutUrl() -> String {
        return "http://"+aemIp+":"+aemPort+"/system/sling/logout.html"
    }
    
    func returnBusinessUrl() -> String {
        return "http://"+aemIp+":"+aemPort+"/bin/helloWorldComponentServlet"
    }
}

// this class doesn't implement the ObservableObject protocol class as no other view requires the object so far. Therefore,
// this implementation is async await approach
class AemBusinessData {
    
    private var objResponse: AEMPageResponse?
    
    func callAPI(aemPathToSearch: String, aemUrl: String) async -> AEMPageResponse {
        
        objResponse = AEMPageResponse()
            
        var components = URLComponents(string: aemUrl)
        let queryItemPath = URLQueryItem(name: "aemPath", value: aemPathToSearch)

        components?.queryItems = [queryItemPath]
    
        do{
            let (data, _) = try await URLSession.shared.data(from: (components?.url)!)
            let decoder = JSONDecoder()
            objResponse = try decoder.decode(AEMPageResponse.self, from: data)
        }catch let parsingError {
            print("Error calling business AEM method:", parsingError)
        }
        
        return objResponse!
    }
    
}
