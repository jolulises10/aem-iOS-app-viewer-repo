//
//  AEMContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 08/06/2022.
//

import SwiftUI

struct AEMContentView: View {
    var body: some View {
        VStack(spacing: 25) {
            Text("Complete this part")
                .fontWeight(.semibold)
                .font(.title)
        }
        .onAppear{
            print("ContentView appeared!")
            callAPI()
        }
    }
}

struct AEMContentView_Previews: PreviewProvider {
    static var previews: some View {
        AEMContentView()
    }
}

func callAPI(){
    guard let url = URL(string: "http://localhost:4504/libs/wcm/core/content/pageinfo.json") else{
        return
    }

    var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Cookie", forHTTPHeaderField: "AMCV_EEA6EA7B543CE7D30A4C98A1%40AdobeOrg=359503849%7CMCIDTS%7C19082%7CMCMID%7C13225104974095461246688007225583112046%7CMCOPTOUT-1648644653s%7CNONE%7CMCAID%7CNONE%7CMCAAMLH-1649242253%7C7%7CMCAAMB-1649242253%7Cj8Odv6LonN4r3an7LhD3WZrU1bUpAkFkkiY1ncBR96t2PTI%7CMCCIDH%7C1734795468%7CMCSYNCSOP%7C411-19089%7CvVersion%7C5.0.1; mbox=PC#f29271fdd07149a58585046e747e327e.34_0#1711887493|session#adab726114094ce581039eb8098f9b22#1648643824; visitorID=13225104974095461246688007225583112046; s_vnum=1681152800260%26vn%3D6; liveagent_oref=http://localhost:4502/libs/granite/core/content/login.html?resource=%2Fcontent%2Fnissan%2Fen_GB%2Findex%2Fdashboard2%2Fyour-vehicle.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown; liveagent_vc=4; liveagent_ptid=22077f76-10d1-4ecb-8db9-234200a09ebd; AMCV_8F99160E571FC0427F000101%40AdobeOrg=-1124106680%7CMCIDTS%7C19154%7CMCMID%7C56091632092150107670614316395338511028%7CMCAAMLH-1655459190%7C6%7CMCAAMB-1655459190%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1654861590s%7CNONE%7CMCAID%7CNONE%7CMCSYNCSOP%7C411-19159%7CvVersion%7C5.2.0; s_fid=36B0BDAD4D84AB4D-1EACC74F0D1803F8; apt.uid=AP-AULLRFDZLJ9K-2-1-1652358669923-13533973.0.2.e667cb2a-c5b5-442e-92e9-a8d5356d7804; cq-authoring-mode=TOUCH; s_cc=true; AMCVS_8F99160E571FC0427F000101%40AdobeOrg=1; s_sq=%5B%5BB%5D%5D; cq-sites-pages-pages=column; wcmmode=preview; cq-editor-layer.page=Preview; cq-editor-sidepanel=closed; login-token=c9c2fd0e-188d-4bcf-a97e-e4ebfbe368a4%3a45dfa230-a602-4d17-b9fb-fc76b6c76c54_08d2e9e16b18ba976e7211aab8849eba%3acrx.default; apt.sid=AP-AULLRFDZLJ9K-2-1-1654854390433-36897562")
    
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    let queryItemPath = URLQueryItem(name: "path", value: "%2Fcontent%2Fwknd%2Flanguage-masters%2Fen%2Fpage-content-jur")
    let queryItemCharset = URLQueryItem(name: "_charset_", value: "UTF-8")

    components?.queryItems = [queryItemPath, queryItemCharset]

    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        if let data = data, let string = String(data: data, encoding: .utf8){
            print(string)
        }
    }

    task.resume()
}
