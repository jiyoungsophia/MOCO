//
//  SearchViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit

class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.placeholder = "enter_location".localized()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        
        self.definesPresentationContext = true
        
    }
    
//    private func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel")
//    }
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
