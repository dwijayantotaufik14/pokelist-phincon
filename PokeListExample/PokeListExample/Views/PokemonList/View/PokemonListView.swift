//
//  PokemonListView.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit
import Combine

class PokemonListView: UIView, ViewModable, Interactable, CollectionViewable {
    typealias Item = PokemonDetails
    typealias Section = String

    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet private weak var pokemonCollectionView: UICollectionView!
    
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var collectionView: UICollectionView { pokemonCollectionView }
    var dataSource: DiffableDataSource<Section, Item>!

    enum Interaction {
        case selectPokemon(PokemonContainer)
        case scrollToBottom
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = collectionView.pokedexDataSource(data: viewModel.pokemon, delegate: self)
        collectionView.backgroundColor = UIColor(hex: "222222")

        viewModel.$pokemon.sink { [weak self] pokemon in
            self?.appendData(pokemon)
        }.store(in: &cancellables)
    }

    // MARK: - Private functions
    private func appendData(_ data: [PokemonDetails]) {
        var snapshot = dataSource.snapshot()
        var items = snapshot.itemIdentifiers
        items.append(contentsOf: data)
        items.sort(by: { $0.id < $1.id })
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PokemonListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let cell = collectionView.cell(at: indexPath) as? PokemonListCell,
              let pokemon = dataSource.itemIdentifier(for: indexPath)
        else { return }

        ImageCache.default.loadImage(from: pokemon.sprite.url, item: pokemon) { [weak self] _, image in
            let container = PokemonContainer(pokemon: pokemon, cell: cell, image: image)
            self?.subject.send(.selectPokemon(container))
        }
    }
}

extension PokemonListView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.hasScrolledToBottom else { return }
        subject.send(.scrollToBottom)
    }
}

extension UIScrollView {
    /// A boolean value that is true if the scroll view has scrolled to the bottom of the view
    var hasScrolledToBottom: Bool {
        contentSize.height - contentOffset.y < frame.size.height * 1.6
    }
}
