//
//  APIModels.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Networking

struct APIResponse: Decodable {
    let next: String
    let results: [APIItem]
}

// MARK: -
struct APIItem: Decodable {
    let name: String
    let url: String
}

// MARK: -
extension Network.Service {
    static var `default`: Network.Service {
        Network.Service(server: ServerConfig(baseURL: "https://pokeapi.co/api/v2/"))
    }
}
