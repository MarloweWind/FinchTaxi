//
//  PresentationController.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 11.04.2022.
//

import UIKit

class PresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    var driver: TransitionDriver?
    
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else {
            return CGRect()
        }
        let halfHeight = bounds.height / 2
        var keyBoardSize = 0.0
        if halfHeight < 290 {
            keyBoardSize = 216.0
        } else if halfHeight == 333.5 {
            keyBoardSize = 216.0
        } else if halfHeight == 358.0 {
            keyBoardSize = 226.0
        } else if halfHeight == 368.0{
            keyBoardSize = 226.0
        } else {
            keyBoardSize = 290.0
        }
        
        return CGRect(x: 0,
                      y: halfHeight - keyBoardSize,
                      width: bounds.width,
                      height: halfHeight)
    }
    
    
    // MARK: - Public methods
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.addSubview(presentedView ?? UIView())
        
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            driver?.direction = .dismiss
        }
    }
}
