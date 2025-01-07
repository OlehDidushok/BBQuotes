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
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupation
        case images
        case aliases
        case status
        case portrayedBy
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        birthday = try container.decode(String.self, forKey: .birthday)
        occupation = try container.decode([String].self, forKey: .occupation)
        images = try container.decode([URL].self, forKey: .images)
        aliases = try container.decode([String].self, forKey: .aliases)
        status = try container.decode(String.self, forKey: .status)
        portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        death = try deathDecoder.decode(Death.self, from: deathData)
    }
}
