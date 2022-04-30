//
//  TransitionDriver.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 11.04.2022.
//

import UIKit

final class TransitionDriver: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Types
    
    enum TransitionDirection {
        case present, dismiss
    }
    
    
    // MARK: - Properties

    private weak var presentedController: UIViewController?
    
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        
        set { }
    }
    
    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    
    var direction: TransitionDirection = .present
    
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
    private var panRecognizer: UIPanGestureRecognizer?
    
    
    // MARK: - Public methods
    
    func link(to controller: UIViewController) {
        presentedController = controller
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer ?? UIPanGestureRecognizer())
    }
    
    
    // MARK: - Private methods
    
    private func handlePresentation(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
            
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }
            
        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
    private func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            
            if !isRunning {
                presentedController?.dismiss(animated: true)
            }
        
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
            
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }

        case .failed:
            cancel()
            
        default:
            break
        }
    }

    
    // MARK: - Actions
    
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: r)
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
}


// MARK: - UIPanGestureRecognizer
private extension UIPanGestureRecognizer {
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2
        
        return isPresentationCompleted
    }
    
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)
        
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
}
