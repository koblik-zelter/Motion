//
//  String + Extensions.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(data: data,
                                       options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                                       documentAttributes: nil)
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
