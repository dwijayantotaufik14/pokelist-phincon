//
//  Endpoints.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Networking

/// An enumeration for all the possible endpoints for the backend
enum Endpoint {
    case details(String)
    case pokemon
}

// MARK: -
extension Endpoint: EndpointType {
    
    var path: String {
        switch self {
        case .details(let id): return "pokemon/\(id)"
        case .pokemon: return "pokemon"
        }
    }
}
