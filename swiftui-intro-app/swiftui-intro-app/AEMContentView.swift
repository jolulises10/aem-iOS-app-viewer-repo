//
//  AEMContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 08/06/2022.
//

import SwiftUI

struct AEMContentView: View {
    @State private var apiTitle : String
    @State private var apiText : String
    @State private var apiMessage : String
    @Binding private var aemPath : String
    
    @EnvironmentObject var aemParams : AemInputData
    //@ObservedObject var aemParams : AemInputData
    
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
            let myModel = await callAPI(aemPathToSearch: aemPath, aemIP: $aemParams.aemIp, aemPort: $aemParams.aemPort)
            apiTitle = "Title: "+myModel.title
            apiText = " Text: "+myModel.text
            apiMessage = " Message: "+myModel.message
        }
    }
    
    init(aemPathParam: Binding<String>/*, aemIpParam: Binding<String>*/){
        self.apiTitle = ""
        self.apiText = ""
        self.apiMessage = ""
        self._aemPath = aemPathParam
        //self.aemParams = AemInputData()
    }
}

struct AEMContentView_Previews: PreviewProvider {
    
    static let aemPathPreview = "Preview Purposes Only"
    static let aemIpPreview = "Preview Purposes Only"
    
    static var previews: some View {
        AEMContentView(aemPathParam: .constant(aemPathPreview)/*, aemIpParam: .constant(aemIpPreview)*/)
    }
}

func callAPI(aemPathToSearch: String, aemIP: Binding<String>, aemPort: Binding<String>) async -> AEMPageResponse {
    
    var objResponse = AEMPageResponse()
    
    print("IP value: "+aemIP.wrappedValue)
    print("Port value: "+aemPort.wrappedValue)
    
    var components = URLComponents(string: "http://"+aemIP.wrappedValue+":"+aemPort.wrappedValue+"/bin/helloWorldComponentServlet")
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
