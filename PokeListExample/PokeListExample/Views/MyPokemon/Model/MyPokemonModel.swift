//
//  MyPokemonModel.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit


struct MyPokemonModel {
    let nickname: String
    let image : UIImage
    
    init(data: [String : Any]) {
        self.nickname = data[K.CoreData.nickname] as! String
        self.image = data[K.CoreData.image] as! UIImage
        
    }
    
}
