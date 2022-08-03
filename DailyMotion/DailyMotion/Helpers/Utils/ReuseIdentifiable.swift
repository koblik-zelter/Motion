//
//  ReuseIdentifiable.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable where Self: UIView {
    static var reuseId: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: ReuseIdentifiable { }
extension UITableViewCell: ReuseIdentifiable { }
extension UITableViewHeaderFooterView: ReuseIdentifiable { }
