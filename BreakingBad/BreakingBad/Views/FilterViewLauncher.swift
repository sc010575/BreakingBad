//
//  FilterViewLauncher.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 11/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

protocol FilterViewLauncherDelegate: class {
    func filterViewLauncherDelegate(_ launcher: FilterViewLauncher, appearance: [Int])
}

class FilterViewLauncher: NSObject {

  let backgroundView: UIView = {
    let view = UIView()
    return view
  }()

  let tableView: UITableView = {
    let tv = UITableView(frame: .zero)
    tv.backgroundColor = UIColor.white
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()

  let cellHeight: CGFloat = 50
  private var appearanceLists = [Int]()
  weak var delegate: FilterViewLauncherDelegate?
  
  override init() {
    super.init()
    tableView.delegate = self
    tableView.dataSource = self
  }


  func showFilterView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    if let window = UIApplication.shared.keyWindow {
      window.addSubview(backgroundView)
      window.addSubview(tableView)
      let height: CGFloat = CGFloat(5) * cellHeight
      tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

      backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      backgroundView.frame = window.frame
      backgroundView.alpha = 0
      let y = window.frame.height - height
      animateBackground(with: 1, yPosition: y)
    }
  }

  @objc func handleDismiss() {
    if let window = UIApplication.shared.keyWindow {
      animateBackground(with: 0, yPosition: window.frame.height)
    }
  }

  fileprivate func animateBackground(with appha: CGFloat, yPosition: CGFloat) {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.backgroundView.alpha = appha
      self.tableView.frame = CGRect(x: 0, y: yPosition, width: self.tableView.frame.width, height: self.tableView.frame.height)

    }, completion: nil)
  }
}


extension FilterViewLauncher: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    cell.textLabel?.text = "Season appearance - \(indexPath.row + 1)"
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
}

extension FilterViewLauncher: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else {
      return
    }

    cell.accessoryType = cell.accessoryType == .checkmark ? .none : .checkmark
    if cell.accessoryType == .checkmark {
      appearanceLists.append(indexPath.row + 1)
    }else {
      appearanceLists.removeAll { $0 == indexPath.row + 1}
    }
    delegate?.filterViewLauncherDelegate(self, appearance: appearanceLists.sorted())
  }
}
