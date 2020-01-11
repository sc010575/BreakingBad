//
//  ViewController.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

class BreakingListViewController: UIViewController {

  var viewModel: BreakingListViewModelUseCase!
  private var badCharecters = [BreakingListCellViewModel]()
  private let spacing: CGFloat = 16.0

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  weak var collectionView: UICollectionView!
  var alert:UIAlertController!
  
  override func loadView() {
    super.loadView()
    setupNavigationBar()
    setupViews()
  }

  override func viewDidLoad() {
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    title = viewModel.controllerTitle
    loadingView()
  }
  
  private func setupViews() {
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
     collectionView.translatesAutoresizingMaskIntoConstraints = false
     self.view.addSubview(collectionView)
     NSLayoutConstraint.activate([
       collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
       collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
       collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
       collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
       ])
     self.collectionView = collectionView
     self.collectionView.register(BreakingBadCell.self, forCellWithReuseIdentifier: "BreakingBadCell")
     viewModel.fetchBadCharacters { (badResult) in
       self.removeLoadingView()
       switch badResult {
       case .success(let results):
         self.badCharecters = results
         self.collectionView.reloadData()
       case .failure(let appError):
         print(appError.localizedDescription)
       }
     }
  }
  
  private func setupNavigationBar() {
    let filterButtonItem = UIBarButtonItem.menuButton(self, action: #selector(handleFilter), imageName:"filter-edit" , tintColor: .black)
    navigationItem.rightBarButtonItems = [filterButtonItem]
    navigationController?.hidesBarsOnSwipe = true
  }
  
  @objc func handleFilter() {
   //   settingLauncher.showSettingView()
  }

}


extension BreakingListViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return badCharecters.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreakingBadCell", for: indexPath) as? BreakingBadCell else { return UICollectionViewCell() }
    let cellViewModel = badCharecters[indexPath.row]
    cell.setupCell(cellViewModel)
    return cell
  }
}

extension BreakingListViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.itemAtIndexPath(indexPath.row)
  }
}

extension BreakingListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfItemsPerRow: CGFloat = 2

    let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacing) //Amount of total spacing in a row

    let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
    let height = width + 20
    return CGSize(width: width, height: height)
  }
  func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }

  func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 8, left: spacing, bottom: 8, right: spacing)
  }
}

private extension BreakingListViewController {
  
  func loadingView() {
    alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.color = .gray
    if #available(iOS 13.0, *) {
      loadingIndicator.style = .medium
    } else {
      // Fallback on earlier versions
    }
    loadingIndicator.startAnimating();

    alert.view.addSubview(loadingIndicator)
    present(alert, animated: true, completion: nil)
  }
  
  func removeLoadingView() {
   alert.dismiss(animated: true, completion: nil)
  }
}

//MARK:- Only for debuging purpose for testing
#if DEBUG
extension BreakingListViewController {
    public func exposePrivateBadCharecters() -> [BreakingListCellViewModel] {
        return self.badCharecters
    }
}
#endif
