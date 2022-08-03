//
//  Dispatcher.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation

protocol Dispatcher {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: Dispatcher {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
