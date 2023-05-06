//
//  DetailRequest.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Networking

enum DetailRequest: Requestable {
    case details(String)

    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }

    var endpoint: EndpointType {
        switch self {
        case .details(let id): return Endpoint.details(id)
        }
    }
}
