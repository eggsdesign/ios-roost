//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 KeyboardChangeHelper helps with listening to keyboard frame changes,
 and moving your view controller content away from under the keyboard.
 
 Usage:
 
 private var keyboardChangeHelper: KeyboardChangeHelper!
 
 override func viewDidLoad() {
    super.viewDidLoad()
    sel
 }
 
 */

public typealias KeyboardChangeHelperAnimationBlock = (_ isKeyboardBeingShown: Bool) -> Void

public class KeyboardChangeHelper {
    let constraints: [NSLayoutConstraint]
    public private(set) var isListeningToKeyboardChanges: Bool = false
    public private(set) var isKeyboardVisible: Bool = false
    private var initialConstraintConstants: [CGFloat]!
    
    public var alongsideAnimationBlock: KeyboardChangeHelperAnimationBlock?
    
    public convenience init(constraint: NSLayoutConstraint) {
        self.init(constraints: [constraint])
    }
    
    public init(constraints: [NSLayoutConstraint]) {
        self.constraints = constraints
        self.initialConstraintConstants = constraints.map({ $0.constant })
    }
    
    deinit {
        self.stopListening()
    }
    
    public func startListening() {
        if !self.isListeningToKeyboardChanges {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardChanged(notification:)),
                                                   name: Notification.Name.UIKeyboardWillChangeFrame,
                                                   object: nil)
            self.isListeningToKeyboardChanges = true
        }
    }
    
    public func stopListening() {
        NotificationCenter.default.removeObserver(self)
        self.isListeningToKeyboardChanges = false
    }
    
    @objc private func keyboardChanged(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        let viewsNeedingLayout = self.apply(keyboardFrame: keyboardFrame, toConstraints: self.constraints)
        
        guard let window = viewsNeedingLayout.first?.window else {
            return
        }
        
        self.isKeyboardVisible = keyboardFrame.origin.y < window.frame.size.height
        
        guard let animationOptionsRaw = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: animationOptionsRaw), animations: {
            viewsNeedingLayout.forEach({ $0.layoutIfNeeded() })
            self.alongsideAnimationBlock?(self.isKeyboardVisible)
        }, completion: nil)
    }
    
    private func apply(keyboardFrame: CGRect, toConstraints constraints: [NSLayoutConstraint]) -> [UIView] {
        return constraints.enumerated().flatMap({ (index, constraint) -> UIView? in
            guard let containingView = self.findContainingView(for: constraint) else {
                return nil
            }
            
            let convertedEndFrame = containingView.convert(keyboardFrame, from: containingView.window)
            let keyboardOffset = containingView.frame.size.height - convertedEndFrame.origin.y
            let isTopConstraint = self.isTopConstraint(constraint, in: containingView)
            let shouldInvertConstant = isTopConstraint
            let initialConstant = self.initialConstraintConstants[index]
            if shouldInvertConstant {
                constraint.constant = min(initialConstant, initialConstant - keyboardOffset)
            } else {
                constraint.constant = max(initialConstant, initialConstant + keyboardOffset)
            }
            return containingView
        }).orderedSet
    }
    
    private func isTopConstraint(_ constraint: NSLayoutConstraint, in view: UIView) -> Bool {
        if constraint.secondItem?.conforms(to: UILayoutSupport.self) ?? false {
            return (constraint.firstAttribute == .top || constraint.firstAttribute == .topMargin) &&
                (constraint.secondAttribute == .bottom || constraint.firstAttribute == .bottomMargin)
        } else if (constraint.secondItem as? UIView == view) {
            return (constraint.firstAttribute == .top || constraint.firstAttribute == .topMargin) &&
                (constraint.secondAttribute == .top || constraint.firstAttribute == .topMargin)
        }
        
        return false
    }
    
    private func findContainingView(for constraint: NSLayoutConstraint) -> UIView? {
        guard let firstView = self.findView(for: constraint, isFirstItem:true), let secondView = self.findView(for: constraint, isFirstItem:false) else {
            return nil
        }
        
        let isSecondChildOfFirst = secondView.superview == firstView
        if isSecondChildOfFirst {
            return firstView
        }
        
        let isFirstChildOfSecond = firstView.superview == secondView
        if isFirstChildOfSecond {
            return secondView
        }
        
        // The two items are siblings, and we need to return the superview
        return firstView.superview
    }
    
    private func findView(for constraint: NSLayoutConstraint, isFirstItem: Bool) -> UIView? {
        let item = isFirstItem ? constraint.firstItem : constraint.secondItem
        if let view = item as? UIView {
            return view
        }
        
        if let constraint = item as? NSLayoutConstraint {
            return self.findView(for:constraint, isFirstItem:isFirstItem)
        } else if let layoutGuide = item as? UILayoutGuide {
            return layoutGuide.owningView
        }

        return nil
    }
}
