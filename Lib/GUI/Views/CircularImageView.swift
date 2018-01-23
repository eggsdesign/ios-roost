//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 An UIImageView subclass that automatically adjusts
 its corner radius to stay circular at all square sizes.
 */
open class CircularImageView: UIImageView {
    private var oldCircleBounds: CGRect!

    public required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.clipsToBounds = true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateCornerRadiusIfNeeded()
    }
    
    open override var bounds: CGRect {
        didSet {
            self.updateCornerRadiusIfNeeded()
        }
    }

    private func updateCornerRadiusIfNeeded() {
        if let oldBounds = self.oldCircleBounds, oldBounds == self.bounds {
            return
        }

        self.oldCircleBounds = bounds
        self.applyCornerStyle(.circle)
    }
}
