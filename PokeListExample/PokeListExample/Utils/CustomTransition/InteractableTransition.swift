//
//  InteractableTransition.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

/// A protocol for the interactable transition
protocol InteractableTransition: UIViewControllerInteractiveTransitioning {
    /// A boolean that determines if a interaction is in progress.
    var interactionInProgress: Bool { get }
    /// The initial frame for the custom transition
    var initialFrame: CGRect { get }
    /// An optional image used for the custom transition
    var image: UIImage? { get }
}
