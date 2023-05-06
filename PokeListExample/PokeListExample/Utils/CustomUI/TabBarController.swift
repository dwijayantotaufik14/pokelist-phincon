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

        let myPokemon = ModuleBuilder.shared.MyPokemonBuild()
        myPokemon.tabBarItem = UITabBarItem(title: "My Pokemon", image: nil, tag: 1)
        setViewControllers([pokedexView, myPokemon], animated: false)
    }

}
