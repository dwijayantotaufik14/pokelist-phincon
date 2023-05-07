//
//  DetailController.swift
//  PokeListExample
//
//  Created by Opick Cobra on 06/05/23.
//

import UIKit
import Combine
import Toast
import CoreData

/// The `DetailController` implementation
final class DetailController: ViewController<DetailView>, UITextFieldDelegate {

    // MARK: Private properties
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        let color: UIColor = viewModel.isLight ? .black : .white
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 17.0), .foregroundColor: color], for: .normal)
        return button
    }()
    
    private lazy var catchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Catch", style: .plain, target: self, action: #selector(catchPokemon))
        let color: UIColor = viewModel.isLight ? .black : .white
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 17.0), .foregroundColor: color], for: .normal)
        return button
    }()

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let nav = navigationController else { fatalError("No navigation here, should never happen!") }
        return nav.isBeingDismissed ? .lightContent : viewModel.isLight ? .darkContent : .lightContent
    }

    // MARK: - Init
    /// Init the `DetailController`
    /// - parameter viewModel: The given view model for the view
    override init(viewModel: DetailView.ViewModel) {
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "222222")
        title = viewModel.title
        
        

        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = catchButton
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavbarApp(color: .cyan)
    }

    // MARK: - Private functions
    @objc private func close() {
        dismiss(animated: true)
    }
    
    weak var buttonActionToEnable: UIAlertAction?
    
    //MARK: - CATCH POKEMON
    @objc private func catchPokemon() {
        let numbers = [1, 2]
        let randomNum = numbers.randomElement()
        
        
        if randomNum == 1 {
            var nicknameTextfield: UITextField?
            // Declare Alert message
            let dialogMessage = UIAlertController(title: "Alert Title", message: "Please provide your ID", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                if !self.viewModel.pokemon.sprite.url.isEmpty {
                    ImageCache.default.loadImage(from: self.viewModel.pokemon.sprite.url, item: self.viewModel.pokemon) { [weak self] _, image in
                        self?.savePokemonToFavorites(nickname: (nicknameTextfield?.text)!, image: image!) { string in
                            self?.showToast(subtitle: string)
                        }
                    }
                }else{
                    print("ERROR GET IMAGE")
                }
            })
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Add Input TextField to dialog message
            dialogMessage.addTextField { (textField) -> Void in
                nicknameTextfield = textField
                nicknameTextfield?.delegate = self
                nicknameTextfield?.placeholder = "Type in your ID"
                nicknameTextfield?.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
            }
            
            self.buttonActionToEnable = ok
            ok.isEnabled = false
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert Title", message: "Catch Failed", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func textFieldChanged(_ sender: Any) {
        let textfield = sender as! UITextField
        self.buttonActionToEnable?.isEnabled = textfield.text!.count > 0
    }
    
    func showToast(subtitle: String) {
        let toast = Toast.default(
            image: UIImage(systemName: "checkmark.seal.fill")!,
            title: "Done!",
            subtitle: subtitle,
            config: .init(direction: .top, autoHide: true, enablePanToClose: true, displayTime: 3, animationTime: 0.2, enteringAnimation: .default, exitingAnimation: .default, attachTo: nil)
        )
        toast.show()
    }
    
    func savePokemonToFavorites(nickname: String, image: UIImage, completion: @escaping(String) -> Void) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.predicate = NSPredicate(format: "nickname == %@", nickname)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let existingPokemons = try context.fetch(fetchRequest)
            if let _ = existingPokemons.first {
                completion("Pokemon Exists")
                return
            }
            let pokemon = NSEntityDescription.insertNewObject(forEntityName: "SavedPokemon", into: context)
            let data = image.jpegData(compressionQuality: 1)
            pokemon.setValue(nickname, forKey: K.CoreData.nickname)
            pokemon.setValue(data, forKey: K.CoreData.image)
            pokemon.setValue(0, forKey: K.CoreData.renameCount)
            try context.save()
            completion("Pokemon added to favorites")
        } catch  {
            print(error.localizedDescription)
        }
    }
}
