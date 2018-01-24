//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 Defines a protocol that can be used by views to easily inject contents from a nib file as a subview.
 
See NibCollectionViewCell for a usage example
 
 */
public protocol NibInjectedView {
    var nibName: String { get }
    var nibBundle: Bundle? { get }
    var targetContainerView: UIView { get }
    func injectNib() -> UIView
    func setup(with injectedView: UIView)
}

public extension NibInjectedView {
    func setup(with injectedView: UIView) {
        
    }
}

public extension NibInjectedView where Self : UIView {
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    var nibBundle: Bundle? {
        return nil
    }
    
    var targetContainerView: UIView {
        return self
    }
    
    func injectNib() -> UIView {
        let injectedView = NibInjector.inject(firstViewInNibNamed: self.nibName,
                                  inBundle: self.nibBundle,
                                  intoContainer: self.targetContainerView,
                                  withOwner: self)
        
        self.setup(with: injectedView)
        
        return injectedView
    }
}

public extension NibInjectedView where Self : UITableViewCell {
    var targetContainerView: UIView {
        return self.contentView
    }
}

public extension NibInjectedView where Self : UICollectionViewCell {
    var targetContainerView: UIView {
        return self.contentView
    }
}
