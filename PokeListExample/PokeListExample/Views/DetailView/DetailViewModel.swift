//
//  DetailViewModel.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

extension DetailView {
    /// A data structure for the detail view model
    struct ViewModel {
        let pokemon: PokemonDetails
        let color: UIColor
    }
}

// MARK: -
extension DetailView.ViewModel {
    var title: String { pokemon.name.capitalized }
    var id: String { "#\(pokemon.id)" }
    var isLight: Bool { color.isLight }

    var abilities: DetailItem {
        let abilities = pokemon.abilities.map { $0.ability.name.cleaned }.joined(separator: "\n\n")
        return DetailItem(title: "Abilities", value: abilities)
    }

    var moves: DetailItem {
        let limit = 16
        let tooMany = pokemon.moves.count > limit
        var values = tooMany ? Array(pokemon.moves[0 ..< limit]) : pokemon.moves
        if tooMany { values.append(Move(move: APIItem(name: ". . .", url: ""))) }
        let moves = values.map { $0.move.name.cleaned }.joined(separator: "\n\n")
        return DetailItem(title: "Moves", value: moves)
    }
}

extension String {

    var cleaned: String {
        let e = replacingOccurrences(of: "é", with: "e")
        let dash = e.replacingOccurrences(of: "-", with: " ").capitalized
        return dash
    }

    func lineHeight(_ height: CGFloat) -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = height
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }

    func foundMatch(for string: String) -> Bool {
        (cleaned as NSString).range(of: string, options: .caseInsensitive).location != NSNotFound
    }

    static func types(from types: [Type]) -> String {
        types.compactMap { $0.type.name.cleaned }.joined(separator: "\n")
    }
}
