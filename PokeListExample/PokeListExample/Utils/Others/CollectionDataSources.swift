//
//  CollectionDataSources.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

typealias DiffableDataSource = UICollectionViewDiffableDataSource
typealias Snapshot = NSDiffableDataSourceSnapshot

// MARK: -
extension UICollectionView {

    typealias SearchDataSource = DiffableDataSource<PokemonListView.Section, PokemonListView.Item>

    /// A diffable data source object with a `PokemonListCell` cell and a `SpinnerFooterView` footer view.
    /// Used in the collection view in the `PokemonListView`.
    /// - parameters:
    ///     - data: The given pokemon array
    ///     - delegate: The collection view delegate
    /// - returns: A diffable data source for the collection view
    func pokedexDataSource(data: [PokemonDetails], delegate del: UICollectionViewDelegate) -> SearchDataSource {
        setCollectionViewLayout(.pokedexLayout, animated: false)
        registerFooterView(SpinnerFooterView.self)
        registerCell(PokemonListCell.self)
        delegate = del

        let dataSource = SearchDataSource(collectionView: self) { collectionView, indexPath, pokemon in
            let cell = collectionView.dequeueCell(PokemonListCell.self, at: indexPath)
            cell.titleLabel.text = pokemon.name.capitalized
            cell.indexLabel.text = "#\(pokemon.id)"

            ImageCache.default.loadImage(from: pokemon.sprite.url, item: pokemon) { fetchedPokemon, image in
                guard let currentPokemon = fetchedPokemon as? PokemonDetails, currentPokemon == pokemon else { return }
                cell.setupImage(image)
            }
            return cell
        }

        dataSource.supplementaryViewProvider = { _, _, indexPath in
            self.dequeueFooterView(SpinnerFooterView.self, at: indexPath)
        }

        var snapshot = Snapshot<PokemonListView.Section, PokemonListView.Item>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(data)
        dataSource.apply(snapshot)
        return dataSource
    }
}

extension UICollectionView {
    static let footer = UICollectionView.elementKindSectionFooter
    
    func cell<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell? {
        cellForItem(at: indexPath) as? Cell
    }
    
    func registerCell<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func registerFooterView<View: UICollectionReusableView>(_ view: View.Type) {
        register(view.self, forSupplementaryViewOfKind: UICollectionView.footer, withReuseIdentifier: view.identifier)
    }
    
    func dequeueCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, at indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? Cell else { fatalError("Error") }
        return cell
    }
    
    func dequeueFooterView<View: UICollectionReusableView>(_ view: View.Type, at indexPath: IndexPath) -> UICollectionReusableView {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.footer, withReuseIdentifier: view.identifier, for: indexPath)
    }
}

private typealias SupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem
private typealias CompositionalLayout = UICollectionViewCompositionalLayout
private typealias EdgeInsets = NSDirectionalEdgeInsets
private typealias Section = NSCollectionLayoutSection
private typealias Group = NSCollectionLayoutGroup
private typealias Size = NSCollectionLayoutSize
private typealias Item = NSCollectionLayoutItem

typealias Layout = UICollectionViewLayout

// MARK: -
extension Layout {
    /// The collection view layout for the `PokedexView`
    static var pokedexLayout: Layout {
        let itemSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = Item(layoutSize: itemSize)
        let groupSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160.0))
        let group = Group.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let padding: CGFloat = 20.0
        let spacing = CGFloat(padding)
        group.interItemSpacing = .fixed(spacing)
        let section = Section(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = EdgeInsets(top: padding, leading: padding, bottom: 30.0, trailing: padding)
        let headerSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60.0))
        let sectionHeader = SupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.footer, alignment: .bottom)
        section.boundarySupplementaryItems = [sectionHeader]
        return CompositionalLayout(section: section)
    }
}
