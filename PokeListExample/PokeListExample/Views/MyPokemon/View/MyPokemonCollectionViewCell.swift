//
//  MyPokemonCollectionViewCell.swift
//  PokeListExample
//
//  Created by Opick Cobra on 07/05/23.
//

import UIKit
import Toast

protocol MyPokemonCellDelegate {
    func succedUpdate()
}

final class MyPokemonCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.backgroundColor = .systemGray4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(useAutolayout: true)
        let renameBtn = UIButton(useAutolayout: true)
        renameBtn.setTitleColor(.white, for: .normal)
        renameBtn.setTitle("Rename", for: .normal)
        renameBtn.backgroundColor = .lightGray
        renameBtn.addTarget(self, action: #selector(renamebtnAction(_:)), for: .touchUpInside)
        renameBtn.layer.cornerRadius = 12
        
        stack.addArrangedSubview(renameBtn)
        stack.setCustomSpacing(8.0, after: renameBtn)

        let releaseBtn = UIButton(useAutolayout: true)
        releaseBtn.setTitleColor(.white, for: .normal)
        releaseBtn.setTitle("Release", for: .normal)
        releaseBtn.backgroundColor = .lightGray
        releaseBtn.addTarget(self, action: #selector(releasebtnAction(_:)), for: .touchUpInside)
        releaseBtn.layer.cornerRadius = 12
        
        stack.addArrangedSubview(releaseBtn)
        
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    var delegate: MyPokemonCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = self.frame.height / 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func releasebtnAction(_ sender: UIButton) {
        if self.checkingPrimeNumber(num: self.generateRandomNumber()) {
            self.deletePokemonData(nickName: self.nameLabel.text!) { string in
                self.showToast(subtitle: string)
                self.delegate?.succedUpdate()
            }
        }else{
            self.showErrorToast(subtitle: "This is not Prime Number")
        }
        
    }
    
    @objc func renamebtnAction(_ sender: UIButton) {
        self.updatePokemonNickname(nickName: self.nameLabel.text!) { string in
            self.showToast(subtitle: string)
            self.delegate?.succedUpdate()
        }
    }
    
    private func showToast(subtitle: String) {
        let toast = Toast.default(
            image: UIImage(systemName: "checkmark.seal.fill")!,
            title: "Done!",
            subtitle: subtitle,
            config: .init(direction: .top, autoHide: true, enablePanToClose: true, displayTime: 3, animationTime: 0.2, enteringAnimation: .default, exitingAnimation: .default, attachTo: nil)
        )
        toast.show()
    }
    
    private func showErrorToast(subtitle: String) {
        let toast = Toast.default(
            image: UIImage(systemName: "checkmark.seal.fill")!,
            title: "Error!",
            subtitle: subtitle,
            config: .init(direction: .top, autoHide: true, enablePanToClose: true, displayTime: 3, animationTime: 0.2, enteringAnimation: .default, exitingAnimation: .default, attachTo: nil)
        )
        toast.show()
    }
    
    func configureCell(name: String, image: UIImage) {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(stackView)
        
        imageView.image = image
        nameLabel.text = name
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(4)
            make.top.equalToSuperview().offset(4)
            make.height.equalTo(imageView.snp.width)
        }
        imageView.layer.cornerRadius = self.layer.cornerRadius - 4
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(4)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(12)
        }
        
    }
}
