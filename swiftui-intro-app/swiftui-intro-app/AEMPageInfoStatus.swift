//
//  AEMPageInfoStatus.swift
//  swiftui-intro-app
//
//  Created by Jorge Rodriguez on 10/06/2022.
//

import Foundation

struct AEMPageInfoStatus:Codable{
    let path: String
    let isLocked: Bool
    let lockOwner: String
    let canUnlock: Bool
    let lastModifiedBy: String
}
