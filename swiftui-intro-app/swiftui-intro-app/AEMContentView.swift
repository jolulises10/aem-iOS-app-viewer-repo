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

    var components = URLComponents(string: "http://172.25.26.162:4504/bin/helloWorldComponentServlet")
    let queryItemPath = URLQueryItem(name: "aemPath", value: aemPathToSearch)

    components?.queryItems = [queryItemPath]

    do{
        let (data, _) = try await URLSession.shared.data(from: (components?.url)!)
        let decoder = JSONDecoder()
        objResponse = try decoder.decode(AEMPageResponse.self, from: data)
    }catch let parsingError {
        print("Error", parsingError)
    }
    return objResponse
}
