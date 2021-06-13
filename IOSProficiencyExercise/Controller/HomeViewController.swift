//
//  HomeViewController.swift
//  IOSProficiencyExercise
//
//  Created by Jaydip Godhani on 13/06/21.
//

import UIKit

class HomeViewController: UITableViewController {

    //MARK:- Variable
    
    //// Init the `HomeViewModel` for further user
    let viewModel = HomeViewModel()
    
    //MARK:- Start
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultProperties()
    }
    
    //// Use this function to set the default properties in viewDidLoad
    private func setDefaultProperties() {
        //// set the footer view as a blank view for remove unnecessary separation
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        //// Register facts cell for tableview
        self.tableView.register(TblFactsCell.self, forCellReuseIdentifier: factsCellIdentifier)
        
        //// Add pull to refresh controller
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
        //// Get facts
        viewModel.getFacts()
        
        //// View model observer
        viewModel.observerFactsFetchSuccess = { [weak self] in
            //// End the refresh controller
            self?.refreshControl?.endRefreshing()
            
            //// Call weak self because this is lazy and memory release
            self?.navigationItem.title = self?.viewModel.title
            ///// Reload the tableview because the facts are fetched
            self?.tableView.reloadData()
        }
    }
    
    //// Refresh controller hander
    
    /// Refresh controller handler
    /// - Parameter sender: sender description
    @objc func refresh(sender: UIRefreshControl) {
       //// Get the new facts
        viewModel.getFacts()
    }
    
    // MARK: - Table view data source and Delegate methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFacts
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: factsCellIdentifier, for: indexPath) as! TblFactsCell
        cell.facts = viewModel.facts(index: indexPath.row)
        return cell
    }
}
