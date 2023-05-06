//
//  PokemonListRouter.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

protocol PokemonRoutable: Routable {
    func routeToDetailView(withPokemonContainer container: PokemonContainer)
}

final class PokemonRouter: PokemonRoutable {

    // MARK: Public properties
    weak var navigationController: UINavigationController?

    // MARK: - Public functions
    func routeToDetailView(withPokemonContainer container: PokemonContainer) {
        let detailView = ModuleBuilder.shared.PokemonDetailBuild(fromContainer: container)
        navigationController?.present(detailView, animated: true)
    }
}
