//
//  UIView + AccessibilityIdentifier.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import UIKit

extension UIView {
    func firstSubview(withAccessibilityIdentifier identifier: String) -> UIView? {
        if accessibilityIdentifier == identifier {
            return self
        }

        for subview in subviews {
            if let viewWithIdentifier = subview.firstSubview(withAccessibilityIdentifier: identifier) {
                return viewWithIdentifier
            }
        }

        return nil
    }
}
