//
//  DismissAnimation.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 11.04.2022.
//

import UIKit

final class DismissAnimation: NSObject {
    
    // MARK: - Properties
    
    let duration: TimeInterval = 0.2
    
    
    // MARK: - Private methods
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let from = transitionContext.view(forKey: .from)
        let initialFrame = transitionContext.initialFrame(for: transitionContext.viewController(forKey: .from) ?? UIViewController())
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            from?.frame = initialFrame.offsetBy(dx: 0, dy: initialFrame.height)
        }
        
        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}


// MARK: - UIViewControllerAnimatedTransitioning
extension DismissAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}
