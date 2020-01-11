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

  lazy private var textLabel: UILabel = {
    let textLabel = UILabel(frame: .zero)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.textColor = .white
    textLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    textLabel.numberOfLines = 2
    textLabel.textAlignment = .center
    return textLabel
  }()

  lazy private var imageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 8.0
    imageView.clipsToBounds = true
    return imageView
  }()

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
    self.contentView.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      ])
    guard let url = URL(string: cellViewModel.imageUrl) else { return }
    imageView.sd_setImage(with: url, completed: nil)

    self.contentView.backgroundColor = .clear

    self.contentView.addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      ])
    textLabel.text = cellViewModel.name
    contentView.backgroundColor = .clear

  }
}
