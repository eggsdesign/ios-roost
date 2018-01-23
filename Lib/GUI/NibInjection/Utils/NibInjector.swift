//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 This utility class helps you inject the contents of a nib file into a content view.
 */
class NibInjector {
    
    /**
     @param name The name of the nib file whose content is to be injected
     @param bundle The bundle where the nib file is located. Leave as nil to use main bundle.
     @param intoContainer The UIView to inject the contents into.
     @param owner The file that will be used as owner for all the connected IBOutlets and IBActions
     */
    static func inject(firstViewInNibNamed name: String,
                       inBundle bundle: Bundle?,
                       intoContainer container: UIView,
                       withOwner owner: Any?) -> UIView {
        return self.inject(firstViewInNib: UINib(nibName: name, bundle: bundle),
                           intoContainer: container, withOwner: owner)
    }
    
    /**
     @param nib The UINib whose content is to be injected into the container
     @param intoContainer The UIView to inject the contents into.
     @param owner The file that will be used as owner for all the connected IBOutlets and IBActions
     */
    static func inject(firstViewInNib nib: UINib,
                       intoContainer container: UIView,
                       withOwner owner: Any?) -> UIView {
        let view = nib.instantiate(withOwner: owner, options: nil).first as! UIView
        ViewInjector.inject(view: view, intoContainer: container)
        return view
    }
}
