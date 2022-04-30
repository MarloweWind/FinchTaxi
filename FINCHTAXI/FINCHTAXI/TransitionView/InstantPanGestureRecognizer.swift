//
//  InstantPanGestureRecognizer.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 11.04.2022.
//

import UIKit

final class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    // MARK: - Public methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
