//
//  DetailView.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit
import Combine

protocol TableViewable where Self: UIView {
    /// The associated section type
    associatedtype Section: Hashable
    /// The associated item type
    associatedtype Item: Hashable

    /// The data source for the collection view
    var dataSource: UITableViewDiffableDataSource<Section, Item>! { get }
    /// The table view in the view
    var tableView: UITableView { get }
}

/// The `DetailView` implementation
final class DetailView: UIView, ViewModable, Interactable, TableViewable {
    typealias Item = AnyHashable
    
    // MARK: Private properties
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet private weak var detailTableView: UITableView!
    
    // MARK: - Public properties
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    var tableView: UITableView { detailTableView }
    
    enum Interaction {}
    
    enum Section: Int {
        case details
        
        var description: String {
            switch self {
            case .details: return "Info"
            }
        }
    }
    
    // MARK: - Public functions
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = tableView.detailViewDataSource(viewModel: viewModel, delegate: self)
        tableView.backgroundColor = UIColor(hex: "222222")
        
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300.0)
        let header = DetailHeaderView(frame: frame, pokemon: viewModel.pokemon, color: viewModel.color)
        tableView.tableHeaderView = header
    }
}

extension DetailView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView.tableHeader(title: Section(rawValue: section)?.description, in: tableView)
    }
}
