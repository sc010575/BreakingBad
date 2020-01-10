//
//  BreakingBadCell.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit
import SDWebImage

class BreakingBadCell: UICollectionViewCell {

  weak private var textLabel: UILabel!
  weak private var imageView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    fatalError("Interface Builder is not supported!")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.textLabel.text = nil
  }

  func setupCell(_ cellViewModel: BreakingListCellViewModel) {
    let imageView = UIImageView(frame: .zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      ])
    guard let url = URL(string: cellViewModel.imageUrl) else { return }
    imageView.sd_setImage(with: url, completed: nil)
    self.imageView = imageView

    self.contentView.backgroundColor = .clear

    let textLabel = UILabel(frame: .zero)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.textColor = .white
    textLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    textLabel.numberOfLines = 2
    self.contentView.addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      ])
    self.textLabel = textLabel
    self.textLabel.text = cellViewModel.name
    self.contentView.backgroundColor = .clear
    self.textLabel.textAlignment = .center

  }
}
