//
//  FetchService.swift
//  BBQuotes
//
//  Created by Oleh on 18.12.2024.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch url
        let quoteUrl = baseURL.appendingPathComponent("quotes/random")
        let fetchURL = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch data
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200  else { throw FetchError.badResponse }
        
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterUrl = baseURL.appendingPathComponent("characters")
        let fetchURL = characterUrl.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200  else { throw FetchError.badResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appendingPathComponent("deaths")
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200  else { throw FetchError.badResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths  {
            if death.character == character {
                return death
            }
        }
        return nil
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeUrl = baseURL.appendingPathComponent("episodes")
        let fetchURL = episodeUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200  else { throw FetchError.badResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
}
