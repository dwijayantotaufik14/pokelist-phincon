//
//  UICollectionViewCell+Extension.swift
//  PokeListExample
//
//  Created by Opick Cobra on 07/05/23.
//

import UIKit
import CoreData

extension UICollectionViewCell {
    func generateRandomNumber() -> Int {
        let randomInt = Int.random(in: 0..<50)
        return randomInt
    }
    
    func checkingPrimeNumber(num: Int) -> Bool{

       // Checking num for 1 or 0
       // because 1 and 0 are not prime number.
       if(num == 1 || num == 0){
          return false
       }
       // For loop starts from 2 to num - 1
       for j in 2..<num{
          // Checking the num is divisible by j, if yes
          // then the num is not prime number
          if(num % j == 0){
             return false
          }
       }
       // Else the number is prime number
       return true
    }
    
    func fibonacciSequence (n: Int) -> [Int]  {
        var fibonacciArray = [Int]()

        for n in 0 ... n {

            if n == 0 {
                fibonacciArray.append(0)
            }
            else if n == 1 {
                fibonacciArray.append(1)
            }
            else {
                fibonacciArray.append (fibonacciArray[n-1] + fibonacciArray[n-2] )
            }
        }
        return fibonacciArray
    }
    
    func getLastElement(n : [Int]) -> String {
        if let lastElement = n.last {
            return String(lastElement)
        }else{
            return ""
        }
    }
    
    func updatePokemonNickname(nickName: String, completion: @escaping(String) -> Void) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.predicate = NSPredicate(format: "nickname == %@", nickName)
        fetchRequest.returnsObjectsAsFaults = false
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [SavedPokemon]
        
        for object in resultData {
            var currentName = nickName
            var newName: String = ""
            let fibonacciValue = self.getLastElement(n: self.fibonacciSequence(n: Int(object.renameCount)))
            
            if nickName.contains("-") {
                if let range = nickName.range(of: "-") {
                    let fibo = nickName[range.upperBound...]
                    currentName.removeLast(fibo.count)
                    
                    newName = currentName+"\(fibonacciValue)"
                }
            }else{
                newName = nickName + "-\(fibonacciValue)"
            }
            object.setValue(newName, forKey: "nickname")
            object.setValue(object.renameCount+1, forKey: "renameCount")
        }
        
        do {
            try context.save()
            completion("\(nickName) rename success")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deletePokemonData(nickName: String, completion: @escaping(String) -> Void) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.predicate = NSPredicate(format: "nickname == %@", nickName)
        fetchRequest.returnsObjectsAsFaults = false
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [SavedPokemon]
        
        for object in resultData {
            context.delete(object)
        }
        
        do {
            try context.save()
            completion("\(nickName) was released")
        } catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}

extension String {
    var isNumber: Bool {
        return self.allSatisfy { character in
            character.isNumber
        }
    }
}
