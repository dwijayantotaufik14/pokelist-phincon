//
//  TabBarController.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    

    private func setupTabbar() {
        let pokedexView = ModuleBuilder.shared.PokemonListBuild()
        pokedexView.tabBarItem = UITabBarItem(title: "Pokemon List", image: nil, tag: 0)

        /*let itemsView = ItemListBuilder.build()
        itemsView.tabBarItem = UITabBarItem(title: "My Pokemon List", image: UIImage(named: "items-icon"), tag: 1)*/
        setViewControllers([pokedexView/*, itemsView*/], animated: false)
    }

}
