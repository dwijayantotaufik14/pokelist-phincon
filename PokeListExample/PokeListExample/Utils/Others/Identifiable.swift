//
//  Identifiable.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import Foundation

protocol Identifiable {
    /// A static string that identifies the object
    static var identifier: String { get }
}

// MARK: -
extension Identifiable {
    static var identifier: String { String(describing: self) }
}
