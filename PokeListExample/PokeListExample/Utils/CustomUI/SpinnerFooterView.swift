//
//  SpinnerFooterView.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

class SpinnerFooterView: UICollectionReusableView {
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(useAutolayout: true)
        spinner.color = .white
        return spinner
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(spinner)
        spinner.pinToSuperview(with: .init(top: -30, left: 0, bottom: 0, right: 0))
        spinner.startAnimating()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
