//
//  UITableView+Extensions.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

extension UITableView {

    typealias DetailViewDataSource = UITableViewDiffableDataSource<DetailView.Section, DetailView.Item>

    /// A diffable data source object registered with `DetailCell` cells and `StatCell` cells. Used in the table view in the `DetailView`.
    /// - parameters:
    ///     - viewModel: The view model of the view
    ///     - delegate: The delegate for the table view
    /// - returns: A diffable data source for the table view
    func detailViewDataSource(viewModel: DetailView.ViewModel, delegate del: UITableViewDelegate) -> DetailViewDataSource {
        contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
        registerCell(DetailCell.self)
        delegate = del

        let dataSource = DetailViewDataSource(tableView: self) { tableView, indexPath, item in
            switch DetailView.Section(rawValue: indexPath.section) {
            case .details:
                let cell = tableView.dequeueCell(for: DetailCell.self)
                cell.configure(withItem: item as? DetailItem)
                self.rowHeight = UITableView.automaticDimension
                return cell
            default:
                fatalError("Cell can't be dequeued. Shouldn't happen")
            }
        }

        var snapshot = Snapshot<DetailView.Section, DetailView.Item>()
        snapshot.appendSections([.details])
        snapshot.appendItems([viewModel.abilities])
        snapshot.appendItems([viewModel.moves])
        dataSource.apply(snapshot, animatingDifferences: false)
        return dataSource
    }
}

extension UITableView {
    /// Register a cell in the table view
    /// - parameter cell: The cell to register
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    /// Dequeue a cell in the table view
    /// - parameter type: The type cell to dequeue
    /// - returns: The dequeued cell
    func dequeueCell<Cell: UITableViewCell>(for type: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: type.identifier) as! Cell
    }
}
