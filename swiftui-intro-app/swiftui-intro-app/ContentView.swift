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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack(alignment: .bottom) {
                    Text("AEM Path Validation")
                        .fontWeight(.medium)
                        .font(.title)
                    Spacer()
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
                    .onSubmit {
                        print("Validating resource path")
                    }
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
                NavigationLink(destination: AEMContentView(apiTitle: "",
                                                           apiText: "",
                                                           apiMessage: "",
                                                           aemPath: $path)) {
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
        }
    }
    
    init(){
        path = ""
        focusedField = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
