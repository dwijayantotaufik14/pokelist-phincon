//
//  DetailCell.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

final class DetailCell: UITableViewCell {

    // MARK: Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        let padding: CGFloat = 20.0

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            titleLabel.widthAnchor.constraint(equalToConstant: 140.0)
        ])

        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public functions
    func configure(withItem item: DetailItem?) {
        guard let item = item else { return }
        titleLabel.text = item.title
        valueLabel.text = item.value
        selectionStyle = .none
    }
}
