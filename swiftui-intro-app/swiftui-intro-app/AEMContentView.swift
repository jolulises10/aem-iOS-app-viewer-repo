//
//  AEMContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 08/06/2022.
//

import SwiftUI

struct AEMContentView: View {
    @State var apiMessageText : String
    @Binding var aemPath : String
    
    var body: some View {
        VStack(spacing: 25) {
            Text(apiMessageText)
                .fontWeight(.semibold)
                .font(.title)
        }
        .task {
            print("Path set by user: "+aemPath)
            let myModel = await callAPI(aemPathToSearch: aemPath)
            print("ContentView appeared!"+myModel.message)
            apiMessageText = "Title: "+myModel.title
            + " Text: "+myModel.text
            + " Message: "+myModel.message
        }
    }
}

struct AEMContentView_Previews: PreviewProvider {
    static let apiMessageTextPreview = "Title: title Text: Text Message: Message"
    static let aemPathPreview = "Preview Purposes Only"
    
    static var previews: some View {
        AEMContentView(apiMessageText: apiMessageTextPreview, aemPath: .constant(aemPathPreview))
    }
}

func callAPI(aemPathToSearch: String) async -> AEMPageResponse {
    
    var objResponse = AEMPageResponse()
    
   //"https://run.mocky.io/v3/94678605-61a1-4b74-bc0d-b4221f06192c"

    /*var request = URLRequest(url: url)
        request.httpMethod = "GET"*/
        /*request.setValue("Cookie", forHTTPHeaderField: "AMCV_EEA6EA7B543CE7D30A4C98A1%40AdobeOrg=359503849%7CMCIDTS%7C19082%7CMCMID%7C13225104974095461246688007225583112046%7CMCOPTOUT-1648644653s%7CNONE%7CMCAID%7CNONE%7CMCAAMLH-1649242253%7C7%7CMCAAMB-1649242253%7Cj8Odv6LonN4r3an7LhD3WZrU1bUpAkFkkiY1ncBR96t2PTI%7CMCCIDH%7C1734795468%7CMCSYNCSOP%7C411-19089%7CvVersion%7C5.0.1; mbox=PC#f29271fdd07149a58585046e747e327e.34_0#1711887493|session#adab726114094ce581039eb8098f9b22#1648643824; visitorID=13225104974095461246688007225583112046; s_vnum=1681152800260%26vn%3D6; liveagent_oref=http://localhost:4502/libs/granite/core/content/login.html?resource=%2Fcontent%2Fnissan%2Fen_GB%2Findex%2Fdashboard2%2Fyour-vehicle.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown; liveagent_vc=4; liveagent_ptid=22077f76-10d1-4ecb-8db9-234200a09ebd; AMCV_8F99160E571FC0427F000101%40AdobeOrg=-1124106680%7CMCIDTS%7C19157%7CMCMID%7C56091632092150107670614316395338511028%7CMCAAMLH-1655722862%7C6%7CMCAAMB-1655722862%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1655125262s%7CNONE%7CMCAID%7CNONE%7CMCSYNCSOP%7C411-19159%7CvVersion%7C5.2.0; s_fid=36B0BDAD4D84AB4D-1EACC74F0D1803F8; apt.uid=AP-AULLRFDZLJ9K-2-1-1652358669923-13533973.0.2.e667cb2a-c5b5-442e-92e9-a8d5356d7804; cq-authoring-mode=TOUCH; cq-sites-pages-pages=column; cq-editor-layer.page=Edit; cq-editor-sidepanel=closed; login-token=c9c2fd0e-188d-4bcf-a97e-e4ebfbe368a4%3ae1727378-7038-402f-9b9c-4dd6790bc58d_3cddccf341a3af0e3349074ebb076337%3acrx.default; s_cc=true; apt.sid=AP-AULLRFDZLJ9K-2-1-1655202462453-29969255; wcmmode=edit")*/
    
    var components = URLComponents(string: "http://192.168.1.101:4504/bin/helloWorldComponentServlet")
    let queryItemPath = URLQueryItem(name: "aemPath", value: aemPathToSearch)
    //let queryItemCharset = URLQueryItem(name: "_charset_", value: "UTF-8")

    components?.queryItems = [queryItemPath]

    do{
        let (data, _) = try await URLSession.shared.data(from: (components?.url)!)
        let decoder = JSONDecoder()
        objResponse = try decoder.decode(AEMPageResponse.self, from: data)
        print(data)
        print(objResponse.message)
    }catch let parsingError {
        print("Error", parsingError)
    }
    return objResponse
}
