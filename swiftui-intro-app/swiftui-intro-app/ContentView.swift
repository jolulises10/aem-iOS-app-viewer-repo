//
//  ContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 07/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                    Text("AEM Consumer")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                    //Spacer()
                NavigationLink(destination: AEMContentView()) {
                    HStack {
                        Image(systemName: "key")
                            .font(.title)
                        Text("Click me")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }
                .foregroundColor(Color.black.opacity(0.7))
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
