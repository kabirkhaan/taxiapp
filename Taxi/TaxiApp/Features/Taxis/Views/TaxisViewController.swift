//
//  TaxisViewController.swift
//  TaxiApp
//
//  Created by Kabir Khan on 04.12.20.
//

import Foundation
import UIKit

final class TaxisViewController: UITableViewController {
    
    private let viewModel: TaxisViewModel
    var segmentControl: UISegmentedControl?
    
    init(with viewModel: TaxisViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("Should be initialized with view model")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        configureRefreshControl()
        configureSegmentControl()
        registerStateChangeEvent()
        viewModel.refresh()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaxiTableViewCell.reusableIdentifier) as! TaxiTableViewCell
        cell.configure(with: viewModel.object(at: indexPath)!)
        
        return cell
    }
}

private extension TaxisViewController {
    
    func registerCells() {
        tableView.register(TaxiTableViewCell.self,
                           forCellReuseIdentifier: TaxiTableViewCell.reusableIdentifier)
    }
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
 
    func configureSegmentControl() {
        let viewData = viewModel.filtersViewData()
        segmentControl = UISegmentedControl(items: viewData.filters)
        segmentControl?.sizeToFit()
        segmentControl?.selectedSegmentIndex = viewData.selectedIndex
        segmentControl?.addTarget(self, action: #selector(filterValueDidChange), for: .valueChanged)
        self.navigationItem.titleView = segmentControl
    }
    
    func registerStateChangeEvent() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            self.tableView.refreshControl?.endRefreshing()
            
            switch state {
            case .changeFilter(let index):
            self.segmentControl?.selectedSegmentIndex = index
            case .loading:
               break
            case .updated:
                self.tableView.reloadData()
            case .error(let message):
                self.showAlert(title: nil, message: message)
            }
        }
    }
    
    @objc func filterValueDidChange(sender: UISegmentedControl) {
        viewModel.apply(filter: sender.selectedSegmentIndex)
    }
    
    @objc func refresh() {
        viewModel.refresh()
    }
}
