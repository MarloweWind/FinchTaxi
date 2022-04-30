//
//  Extension + UIColor.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 09.02.2022.
//

import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let finchGrey = rgb(r: 142, g: 142, b: 147)
    static let separatorColor = rgb(r: 228, g: 228, b: 228)
    static let buttonColor = rgb(r: 233, g: 233, b: 233)
    static let fincWhite = rgb(r: 247, g: 247, b: 247)
    static let bordersButtonColor = rgb(r: 204, g: 204, b: 204)
    static let finchLighGrey = rgb(r: 175, g: 175, b: 175)
}
