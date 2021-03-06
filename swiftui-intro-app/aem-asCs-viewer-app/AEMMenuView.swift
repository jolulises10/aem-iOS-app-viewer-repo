//
//  ContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 07/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var path : String
    @FocusState private var focusedField: Bool
    @EnvironmentObject var aemLogin: AemLogin
    @EnvironmentObject var aemParams: AemInputData
    
    var body: some View {
        //NavigationView {
            VStack(spacing: 10) {
                HStack {
                    Text("AEM Path Validation")
                        .fontWeight(.medium)
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: AEMLoginView()) {
                        EmptyView()
                    }
                    Button (action: performLogout) {
                       Image(systemName:  "rectangle.portrait.and.arrow.right")
                   }
                }.padding()
                /*Spacer()
                    .frame(minHeight: 10, idealHeight: 200, maxHeight: 600)
                    .fixedSize()*/
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(
                        "AEM JCR resource path",
                        text: $path
                    )
                    .focused($focusedField)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = false
                        }
                    }
                }
                NavigationLink(destination: AEMContentView(aemPathParam: $path)) {
                    HStack {
                        Image(systemName: "icloud")
                            .font(.title)
                        Text("Validate Path")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(20)
                }
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.top, 50)
                Spacer()
                /*Spacer()
                    .frame(minHeight: 10, idealHeight: 200, maxHeight: 600)
                    .fixedSize()*/
            }
        //}
        .navigationBarBackButtonHidden(true)
    }
    
    func performLogout() {
        aemLogin.callLogoutGetAPI(urlString: aemParams.returnLogoutUrl())
    }
    
    init(/* aemData: Binding<AemInputData> */){
        self.path = ""
        //self._aemData = aemData
        self.focusedField = true
    }
}

struct ContentView_Previews: PreviewProvider {
    
    //static let aemIpPreview = "Preview Purposes Only"
    
    static var previews: some View {
        ContentView(/* aemIpParam: .constant(aemIpPreview) */)
            .previewInterfaceOrientation(.portrait)
    }
}
