//
//  CoreDataReachable.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit
import CoreData

protocol CoreDataReachable where Self: UIViewController {}

extension CoreDataReachable {
    func savePokemonToFavorites(nickname: String, image: UIImage, completion: @escaping(String) -> Void) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.predicate = NSPredicate(format: "name == %@", nickname)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let existingPokemons = try context.fetch(fetchRequest)
            if let _ = existingPokemons.first {
                completion("Pokemon Exists")
                return
            }
            let pokemon = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
            let data = image.jpegData(compressionQuality: 1)
            pokemon.setValue(nickname, forKey: K.CoreData.nickname)
            pokemon.setValue(data, forKey: K.CoreData.image)
            try context.save()
            completion("Pokemon added to favorites")
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func fetchPokemon() -> [MyPokemonModel] {
        var arr = [MyPokemonModel]()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                let nickname = result.value(forKey: K.CoreData.nickname) as! String
                let data = result.value(forKey: K.CoreData.image) as! Data
                let image = UIImage(data: data)
                let dict : [String : Any] = [K.CoreData.nickname : nickname, K.CoreData.image: image!]
                let poke = MyPokemonModel(data: dict)
                arr.append(poke)
            }
        } catch  {
            
        }
        return arr
    }
}
