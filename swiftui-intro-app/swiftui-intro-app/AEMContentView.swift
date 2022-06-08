//
//  AEMContentView.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 08/06/2022.
//

import SwiftUI

struct AEMContentView: View {
    var body: some View {
        Text("Pending - show response from AEM")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
    }
}

struct AEMContentView_Previews: PreviewProvider {
    static var previews: some View {
        AEMContentView()
    }
}
