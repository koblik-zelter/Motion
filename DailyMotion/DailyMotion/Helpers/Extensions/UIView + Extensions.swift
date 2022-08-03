//
//  UIView + Extensions.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

extension UIView {

    func addSubview(_ subview: UIView, filling container: LayoutGuideProvider, insets: NSDirectionalEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(subview.constraints(filling: container, insets: insets))
    }

    func constraints(filling container: LayoutGuideProvider, insets: NSDirectionalEdgeInsets = .zero) -> [NSLayoutConstraint] {
        [leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.leading),
         topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
         trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: insets.trailing),
         bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: insets.bottom)]
    }

    func addSubview(_ subview: UIView, with constraints: [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraints)
    }

}
