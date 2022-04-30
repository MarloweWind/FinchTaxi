//
//  Extension + UIFont.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 08.02.2022.
//

import UIKit

extension UIFont {
    
    // MARK: - Types
    
    enum SFProDisplay: String {
        case bold = "SFProDisplay-BOLD"
        case regular = "SFProDisplay-REGULAR"
        case medium = "SFProDisplay-MEDIUM"
    }
    
    
    // MARK: - Init
    
    convenience init?(name fontName: SFProDisplay, size fontSize: CGFloat) {
        self.init(name: fontName.rawValue, size: fontSize)
    }
}
