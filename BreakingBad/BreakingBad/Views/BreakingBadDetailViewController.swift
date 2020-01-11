//
//  BreakingBadViewController.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit
import SDWebImage

class BreakingBadDetailViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var nickNameLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var appearanceLabel: UILabel!
  @IBOutlet weak var occupation: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  
  var viewModel: BreakingBadDetailViewModelUseCase!

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.character.bind { [unowned self] character in
      self.nameLabel.text = "Name - \(character.name)"
      self.nickNameLabel.text = "Best known as - \(character.nickname)"
      guard let imageUrl = URL(string: character.img) else { return }
      self.profileImageView?.sd_setImage(with: imageUrl, completed: nil)
      self.statusLabel.text = character.status
      self.occupation.text = "\(character.occupation.joined(separator: ","))"
      self.appearanceLabel.text = character.appearance.map{String($0)}.joined(separator: ",")
    }
  }
}
