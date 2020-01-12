//
//  SearchTableViewController.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 12/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

  var viewModel: SearchViewModelUseCase!

  private(set) var badCharecters = [BreakingListCellViewModel]()
  private(set) var filteredBadCharecters = [BreakingListCellViewModel]()

  private let searchController = UISearchController(searchResultsController: nil)

  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    viewModel.searchCharacter.bind { cellViewModels in
      self.badCharecters = cellViewModels
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.hidesSearchBarWhenScrolling = false
  }

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredBadCharecters.count : badCharecters.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

    let cellViewModel = isFiltering ? filteredBadCharecters[indexPath.row] : badCharecters[indexPath.row]
    cell.textLabel?.text = cellViewModel.name
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    guard let cell = tableView.cellForRow(at: indexPath) else {
      return
    }
    cell.accessoryType = .checkmark
    let cellViewModel = isFiltering ? filteredBadCharecters[indexPath.row] : badCharecters[indexPath.row]
    viewModel.onSelectRow(cellViewModel: cellViewModel)
    navigationController?.popViewController(animated: true)
  }
  // MARK: - Searchbar
  fileprivate func setupSearchBar() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search by name"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
}

extension SearchTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }

  func filterContentForSearchText(_ searchText: String) {
    filteredBadCharecters = badCharecters.filter { (cellViewModel: BreakingListCellViewModel) -> Bool in
      return cellViewModel.name.lowercased().contains(searchText.lowercased())
    }
    tableView.reloadData()
  }
}

