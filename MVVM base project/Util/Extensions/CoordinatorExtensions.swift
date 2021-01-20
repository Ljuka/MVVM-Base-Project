//
//  CoordinatorExtensions.swift
//  GoPlant.me
//
//  Created by Ljubo Maricevic on 19/02/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import XCoordinator

extension Transition {

    static func presentFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
        presentable.viewController?.modalPresentationStyle = .fullScreen
        return .present(presentable, animation: animation)
    }

    static func presentOverFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
        presentable.viewController?.modalPresentationStyle = .overFullScreen
        return .present(presentable, animation: animation)
    }

    static func dismissAll() -> Transition {
        return Transition(presentables: [], animationInUse: nil) { rootViewController, options, completion in
            guard let presentedViewController = rootViewController.presentedViewController else {
                completion?()
                return
            }
            presentedViewController.dismiss(animated: options.animated) {
                Transition.dismissAll()
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }

}


let defaultAnimationDuration: TimeInterval = 0.35

extension CGFloat {
    static let verySmall: CGFloat = 0.0001
}


extension Animation {
    static let fade = Animation(
        presentation: InteractiveTransitionAnimation.fade,
        dismissal: InteractiveTransitionAnimation.fadeOut
    )
    static let fadeInstant = Animation(
        presentation: InteractiveTransitionAnimation.fade,
        dismissal: InteractiveTransitionAnimation.fade
    )
    static let push = Animation(
        presentation: InteractiveTransitionAnimation.push,
        dismissal: InteractiveTransitionAnimation.pop
    )
}

extension InteractiveTransitionAnimation {
    fileprivate static let fade = InteractiveTransitionAnimation(duration: defaultAnimationDuration) { transitionContext in
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to) != nil ? transitionContext.view(forKey: .to)! : (transitionContext.viewController(forKey: .to)?.view)!
        
        toView.alpha = 0.0
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: [.curveLinear], animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    fileprivate static let fadeOut = InteractiveTransitionAnimation(duration: defaultAnimationDuration) { transitionContext in
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        fromView.alpha = 1.0
        
        UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: [.curveLinear], animations: {
            fromView.alpha = 0.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    fileprivate static let fadeInstat = InteractiveTransitionAnimation(duration: 0) { transitionContext in
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        toView.alpha = 0.0
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: 0, delay: 0, options: [.curveLinear], animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


extension Animation {
    static let modal = Animation(presentation: InteractiveTransitionAnimation.modalPresentation,
                                 dismissal: InteractiveTransitionAnimation.modalDismissal)
}

extension InteractiveTransitionAnimation {
    private static let duration: TimeInterval = 0.35

    fileprivate static let modalPresentation = InteractiveTransitionAnimation(duration: duration) { context in
        let toView: UIView = context.view(forKey: .to)!
        let fromView: UIView = context.view(forKey: .from)!

        var startToFrame = fromView.frame
        startToFrame.origin.y += startToFrame.height
        context.containerView.addSubview(toView)
        context.containerView.bringSubviewToFront(toView)
        toView.frame = startToFrame

        UIView.animate(withDuration: duration, animations: {
            toView.frame = fromView.frame
        }, completion: { _ in
            context.completeTransition(!context.transitionWasCancelled)
        })
    }

    fileprivate static let modalDismissal = InteractiveTransitionAnimation(duration: duration) { context in
        let toView: UIView = context.view(forKey: .to)!
        let fromView: UIView = context.view(forKey: .from)!

        context.containerView.addSubview(toView)
        context.containerView.sendSubviewToBack(toView)
        var newFromFrame = toView.frame
        newFromFrame.origin.y += toView.frame.height

        UIView.animate(withDuration: duration, animations: {
            fromView.frame = newFromFrame
        }, completion: { _ in
            context.completeTransition(!context.transitionWasCancelled)
        })
    }
}
