//
//  UIImageExtension.swift
//  BRTest
//
//  Created by Diego Curumaco on 3/10/21.
//

import UIKit

enum AssetName: String {
    case iconClose = "ic_close"
    case iconWebBack = "ic_webBack"
    case iconWebForward = "ic_webForward"
    case iconWebRefresh = "ic_webRefresh"
    case iconMap = "icon_map"
    case iconTabLunch = "tab_lunch"
    case iconTabInternets = "tab_internets"
}

extension UIImage {
    convenience init?(assetName: AssetName) {
        self.init(named: assetName.rawValue)
    }
}
