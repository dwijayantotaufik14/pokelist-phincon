//
//  ViewController.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit
import Combine

class ViewController<View>: UIViewController where View: ViewModable & Interactable {

    var interaction: AnyPublisher<View.Interaction, Never> { nib.interaction }
    var viewModel: View.ViewModel { nib.viewModel }

    /// The nib for the view
    private(set) var nib: View

    // MARK: - Init
    /// Initialize the nib from the given view and initialize a new `ViewController`
    /// - parameter viewModel: The view model for the view
    init(viewModel: View.ViewModel) {
        self.nib = View.instanceFromNib()
        self.nib.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func loadView() {
        view = nib
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
}

