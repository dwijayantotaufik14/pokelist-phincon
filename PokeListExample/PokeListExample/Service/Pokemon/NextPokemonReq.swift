//
//  NextPokemonReq.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Networking

enum NextPokemonRequest: Requestable {
    case next(offset: String, limit: String)

    var endpoint: EndpointType { Endpoint.pokemon }
    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }

    var parameters: HTTP.Parameters {
        switch self {
        case .next(let offset, let limit): return ["offset": offset, "limit": limit]
        }
    }

    enum ParameterKey: String {
        case offset
        case limit
    }
}
