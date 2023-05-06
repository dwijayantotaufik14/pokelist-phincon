//
//  Interactable.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Combine

/// A protocol for making views interactable
protocol Interactable {
    /// The associated interaction type. Often an enum with interactions in a view.
    associatedtype Interaction
    /// The interaction publisher that communicates the interactions.
    var interaction: AnyPublisher<Interaction, Never> { get }
}
