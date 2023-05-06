//
//  PokemonViewModel.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

extension PokemonListView {
    /// A data structure for the pokedex view model
    final class ViewModel {
        @Published var pokemon = [PokemonDetails]()
        @Published var state: State = .idle

        enum State {
            case idle, loading
        }
    }
}

// MARK: -
extension PokemonListView.ViewModel {
    var title: String { "Pokemon List" }
}
