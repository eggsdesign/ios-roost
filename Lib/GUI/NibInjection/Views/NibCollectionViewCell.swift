//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit


/**
 A UICollectionViewCell class that automatically injects a nib with the same name as the
 class into its contentView
 */
open class NibCollectionViewCell: UICollectionViewCell, NibInjectedView {
    public private(set) var injectedView: UIView!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    private func commonInit() {
        self.injectedView = self.injectNib()
    }
    
    open func setup(with injectedView: UIView) {
        
    }
}
