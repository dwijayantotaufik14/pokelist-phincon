//
//  PokemonController.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit
import Combine

protocol PokemonListProtocol: AnyObject {
    var interaction: AnyPublisher<PokemonListView.Interaction, Never> { get }
    var viewModel: PokemonListView.ViewModel { get }
}

final class PokemonController: ViewController<PokemonListView>, PokemonListProtocol {
    // MARK: Private properties
    private let interactor: PokemonInteractable

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Init
    /// Init the `PokedexController`
    /// - parameters:
    ///     - viewModel: The given view model for the view
    ///     - interactor: The interactor object used to interact with the view
    init(viewModel: PokemonListView.ViewModel, interactor: PokemonInteractable) {
        self.interactor = interactor
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        interactor.loadPokemon()
    }
}
