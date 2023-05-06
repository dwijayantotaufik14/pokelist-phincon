//
//  PokemonListCell.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

final class PokemonListCell: UICollectionViewCell {
    // MARK: Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        return imageView
    }()

    // MARK: - Public properties
    lazy var indexLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.alpha = 0.0
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.alpha = 0.0
        return label
    }()

    enum CornerRadius {
        static let large: CGFloat = 40.0
        static let small: CGFloat = 20.0
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = PokemonListCell.CornerRadius.small
        backgroundColor = .darkGray
        clipsToBounds = true

        contentView.addSubview(imageView)
        imageView.pinToSuperview(with: UIEdgeInsets(top: 0, left: 0, bottom: 14.0, right: 0), edges: .all)

        contentView.addSubview(indexLabel)
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            indexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14.0)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        prepareCellForReuse()
    }

    // MARK: - Public functions
    /// Set the sprite image to the cell. Calculate the dominant color of the sprite on a background thread.
    /// - parameter image: An optional image to set to the cell
    func setupImage(_ image: UIImage?) {
        DispatchQueue.global(qos: .userInteractive).async {
            let color = UIColor.darkGray
            
            DispatchQueue.main.async {
                self.imageView.image = image

                self.titleLabel.textColor = color.isLight ? .black : .white
                self.indexLabel.textColor = color.isLight ? .black : .white
                self.imageView.image = image
                self.backgroundColor = color

                guard self.imageView.alpha != 1.0 else { return }

                UIView.animate(withDuration: 0.2) {
                    self.imageView.alpha = 1.0
                    self.indexLabel.alpha = 1.0
                    self.titleLabel.alpha = 1.0
                }
            }
        }
    }

    // MARK: - Private functions
    private func prepareCellForReuse() {
        backgroundColor = .darkGray
        indexLabel.alpha = 0.0
        titleLabel.alpha = 0.0
        imageView.alpha = 0.0
        imageView.image = nil
    }
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        let hexStart = hex[hex.startIndex] == "#"
        let current = String.Index(utf16Offset: hexStart ? 1 : 0, in: hex)
        scanner.currentIndex = current

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat((rgb & 0xFF)) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    var isLight: Bool {
        guard let components = cgColor.components, components.count > 2 else { return false }
        let r = components[0] * 299
        let b = components[1] * 587
        let g = components[2] * 114
        let brightness = (r + b + g) / 1000
        return brightness > 0.7
    }
}
