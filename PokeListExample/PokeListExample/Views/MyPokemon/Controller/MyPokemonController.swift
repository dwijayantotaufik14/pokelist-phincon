//
//  MyPokemonController.swift
//  PokeListExample
//
//  Created by Opick Cobra on 07/05/23.
//

import UIKit
import CoreData

class MyPokemonController: UIViewController {

    private var collectionView : UICollectionView!
    lazy var pokemonArr = fetchPokemon()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureUI() {
         let width = view.frame.size.width
         let height = view.frame.size.height
        view.backgroundColor = .systemGray6
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: width / 2 - 20, height: height / 3 - 50)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(MyPokemonCollectionViewCell.self, forCellWithReuseIdentifier: K.MyPokemonCell)
        
        view.addSubview(collectionView)
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

extension MyPokemonController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.MyPokemonCell, for: indexPath) as! MyPokemonCollectionViewCell
            let pokemon = pokemonArr[indexPath.row]
        cell.configureCell(name: pokemon.nickname, image: pokemon.image)
        return cell
    }
    
    
}

