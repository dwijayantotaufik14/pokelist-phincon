//
//  PresentableView.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

protocol PresentableView: UIViewController {
    /// The transition delegate object for the presentable view
    var transitionManager: UIViewControllerTransitioningDelegate? { get }
    /// The final receiving frame of the custom transition
    var receivingFrame: CGRect? { get }
}
