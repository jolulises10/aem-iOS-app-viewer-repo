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
    
    private var aemBusinessClass = AemBusinessData()
    
    @EnvironmentObject var aemParams : AemInputData
    
    
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
            let myModel = await getAemModel(aemPathToSearch: aemPath)
            apiTitle = "Title: "+myModel.title
            apiText = " Text: "+myModel.text
            apiMessage = " Message: "+myModel.message
        }
    }
    
    func getAemModel(aemPathToSearch: String) async -> AEMPageResponse {
        return await aemBusinessClass.callAPI(aemPathToSearch: aemPathToSearch, aemUrl: aemParams.returnBusinessUrl())
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
