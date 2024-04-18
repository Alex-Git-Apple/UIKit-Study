//
//  Constants.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/14/24.
//

import UIKit
import DeviceKit

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum DeviceType {
    static func isIPhoneSE() -> Bool {
        let device = Device.current
        return device == .iPhoneSE || device == .iPhoneSE2 || device == .iPhoneSE3
    }
}
