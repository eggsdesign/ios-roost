//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 Add a ShadowView beneath a view you want to cast shadows.
 The ShadowView will ensure that the shadows are rasterized and performant, yet still update when the size of the view updates.
 */
public class ShadowView: UIView {
    private var shadowBounds: CGRect!

    public required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPathIfNeeded(with: self.bounds)
    }
    
    open override var bounds: CGRect {
        didSet {
            self.updateShadowPathIfNeeded(with: bounds)
        }
    }

    private func updateShadowPathIfNeeded(with bounds: CGRect) {
        if let oldBounds = self.shadowBounds, oldBounds == self.bounds {
            return
        }

        self.shadowBounds = bounds
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                             cornerRadius: self.layer.cornerRadius).cgPath
    }
}

