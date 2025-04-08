//
//  StringExt.swift
//  BBQuotes
//
//  Created by Oleh on 08.04.2025.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpaces() -> String {
        self.removeSpaces().lowercased()
    }
}
