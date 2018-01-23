//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

class ViewInjector {
    /**
     Injects a view into a containing and makes it "stick" to all edges using
     0-length layout constraints with priority 1000
     */
    static func inject(view: UIView, intoContainer container: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
}
