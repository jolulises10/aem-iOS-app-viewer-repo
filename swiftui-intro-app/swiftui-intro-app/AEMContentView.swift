//
//  AEMContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 08/06/2022.
//

import SwiftUI

struct AEMContentView: View {
    @State var apiTitle : String
    @State var apiText : String
    @State var apiMessage : String
    @Binding var aemPath : String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .bottom) {
                Text(apiTitle)
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
            }.padding()
            HStack(alignment: .bottom) {
                Text(apiText)
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
            }.padding()
            HStack(alignment: .bottom) {
                Text(apiMessage)
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
            }.padding()
        }
        .task {
            let myModel = await callAPI(aemPathToSearch: aemPath)
            apiTitle = "Title: "+myModel.title
            apiText = " Text: "+myModel.text
            apiMessage = " Message: "+myModel.message
        }
    }
}

struct AEMContentView_Previews: PreviewProvider {
    static let apiTitle = "Title: title"
    static let apiText = "Text: Text"
    static let apiMessage = "Message: Message"
    static let aemPathPreview = "Preview Purposes Only"
    
    static var previews: some View {
        AEMContentView(apiTitle: apiTitle,
                       apiText: apiTitle,
                       apiMessage: apiMessage,
                       aemPath: .constant(aemPathPreview))
    }
}

func callAPI(aemPathToSearch: String) async -> AEMPageResponse {
    
    var objResponse = AEMPageResponse()

    var components = URLComponents(string: "http://192.168.1.110:4504/bin/helloWorldComponentServlet")
    let queryItemPath = URLQueryItem(name: "aemPath", value: aemPathToSearch)

    components?.queryItems = [queryItemPath]

    var securityCheckTmp = AEMSecurityCheckRequest()
    securityCheckTmp.user = "admin"
    securityCheckTmp.pwd = "admin"
    
    var tmpCookieResponse = await callAuthPostAPI(securityRequest: securityCheckTmp)
    
    do{
        let (data, _) = try await URLSession.shared.data(from: (components?.url)!)
        let decoder = JSONDecoder()
        objResponse = try decoder.decode(AEMPageResponse.self, from: data)
    }catch let parsingError {
        print("Error", parsingError)
    }
    return objResponse
}

func callAuthPostAPI(securityRequest: AEMSecurityCheckRequest) async -> Bool {
    
    var loginSuccessful: Bool
    loginSuccessful = false

    guard let url =  URL(string:"http://192.168.1.110:4504/libs/granite/core/content/login.html/j_security_check")
    else{
        return loginSuccessful
    }
    
    var requestBodyComponents = URLComponents()
    requestBodyComponents.queryItems = [
        URLQueryItem(name: "j_username", value: "admin"),
        URLQueryItem(name: "j_password", value: "admin"),
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
        if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
            print(httpResponse.statusCode)
            //if statusCode is 200 ok, 401 not authorised and data is empty
            if (200...299).contains(httpResponse.statusCode) && data.count > 0 {
                loginSuccessful = true
            }
            /*let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.url!))
            for header in fields {
                print("Headers")
                print(header)
                print(header.key)
                print(header.value)
            }
            for cookie in cookies {
                print("Cookies")
                print(cookie.name)
                print(cookie.value)
            }*/
        }
        //let httpResponse = response as? HTTPURLResponse
    }catch let parsingError {
        print("Error", parsingError)
    }
    
    
    return loginSuccessful
}
