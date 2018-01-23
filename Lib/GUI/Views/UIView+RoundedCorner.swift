//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import UIKit

/**
 Utility class for rounding a views corners
 */
public extension UIView {
    public enum RoundedCornerStyle {
        case none
        case fixedAmount(cornerRadius: CGFloat)
        case relativeAmount(cornerRadiusRatio: CGFloat)
        case circle
        
        static func cornerRadius(forView view: UIView, withStyle style: RoundedCornerStyle) -> CGFloat {
            switch (style) {
            case .none:
                return 0
            case .fixedAmount(cornerRadius: let radius):
                return radius
            case .relativeAmount(cornerRadiusRatio: let ratio):
                let size = view.frame.size
                return min(size.width, size.height) * ratio
            case .circle:
                let size = view.frame.size
                return size.width * 0.5
            }
        }
    }

    public func applyCornerStyle(_ style: RoundedCornerStyle) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = RoundedCornerStyle.cornerRadius(forView: self, withStyle: style)
    }
}
