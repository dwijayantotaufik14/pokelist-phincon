//
//  NavigationController.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

class NavigationController: UINavigationController, PresentableView {

    var transitionManager: UIViewControllerTransitioningDelegate?

    var receivingFrame: CGRect? {
        guard let detailView = topViewController as? DetailController else { return nil }
        return detailView.nib.tableView.tableHeaderView?.frame
    }
}

extension NavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle { visibleViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle }
    override var childForStatusBarStyle: UIViewController? { visibleViewController }
}

extension UINavigationController {
    /// Set the navigation bar appearence
    /// - parameter color: The given color to set the nav bar to
    func setNavbarApp(color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17.0), .foregroundColor: color.isLight ? UIColor.black : UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = attributes
        appearance.backgroundColor = color
        appearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
    }
}
