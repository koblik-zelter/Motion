//
//  UITableView + Extensions.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, file: StaticString = #file, line: UInt = #line) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Cannot dequeue cell with \(T.reuseId)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(file: StaticString = #file, line: UInt = #line) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseId) as? T else {
            fatalError("Cannot dequeue headerFooterView with \(T.reuseId)")
        }
        return headerFooterView
    }

    func register(_ cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseId)
    }

    func register(_ headerFooterView: UITableViewHeaderFooterView.Type) {
        register(headerFooterView, forHeaderFooterViewReuseIdentifier: headerFooterView.reuseId)
    }

}
