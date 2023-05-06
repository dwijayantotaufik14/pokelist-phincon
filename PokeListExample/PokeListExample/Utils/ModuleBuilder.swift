//
//  ModuleBuilder.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

class ModuleBuilder {
    
    static let shared = ModuleBuilder()
    
    private init() {}
    
    func PokemonListBuild() -> UINavigationController {
        let router = PokemonRouter()
        let interactor = PokemonInteractor(router: router, service: .default)
        let viewController = PokemonController(viewModel: .init(), interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.setNavbarApp(color: .cyan)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
    
    func PokemonDetailBuild(fromContainer container: PokemonContainer) -> NavigationController {
        let color = container.cell.backgroundColor ?? .clear
        let viewModel = DetailView.ViewModel(pokemon: container.pokemon, color: color)
        let detailView = DetailController(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: detailView)
        let interaction = Transition.Interaction(viewController: navigationController, cell: container.cell, image: container.image)
        let transitionManager = Transition(interaction: interaction, cell: container.cell)
        navigationController.transitioningDelegate = transitionManager
        navigationController.transitionManager = transitionManager
        navigationController.modalPresentationStyle = .custom
        navigationController.setNavbarApp(color: color)
        return navigationController
    }
}

///ModuleBuilder.shared.createEditProfileNewViewController()
