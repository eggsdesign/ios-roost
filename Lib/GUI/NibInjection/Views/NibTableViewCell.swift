//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 A UITableViewCell class that automatically injects a nib with the same name as the
 class into its contentView
 */
class NibTableViewCell: UITableViewCell, NibInjectedView {
    private(set) var injectedView: UIView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        self.injectedView = self.injectNib()
    }
}
