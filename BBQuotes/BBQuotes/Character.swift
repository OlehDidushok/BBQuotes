//
//  Character.swift
//  BBQuotes
//
//  Created by Oleh on 18.12.2024.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupation: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
}
