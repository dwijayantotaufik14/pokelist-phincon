//
//  DetailItem.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Foundation

struct DetailItem {
    let id = UUID()
    let title: String
    let value: String
}

// MARK: -
extension DetailItem: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
