//
//  DispatcherMock.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation
@testable import DailyMotion

final class DispatchQueueMock: Dispatcher {
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
