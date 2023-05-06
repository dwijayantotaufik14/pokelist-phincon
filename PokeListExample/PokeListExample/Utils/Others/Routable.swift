//
//  Routable.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

/// A protocol for creating routable objects
@objc protocol Routable: AnyObject {
    /// An optional weak navigation controller used for navigating in the router
    weak var navigationController: UINavigationController? { get }
}
