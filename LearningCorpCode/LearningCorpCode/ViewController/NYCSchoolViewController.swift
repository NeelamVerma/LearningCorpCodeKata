//
//  ViewController.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 15/05/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class NYCSchoolViewController: UIViewController {

    @IBOutlet weak var nycSchoolsTableView: UITableView!
    @IBOutlet weak var moreButton: UIButton!
    var viewModel = NYCSchoolViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSchoolList(completion: reloadTableView, failure: failure)
    }
    
    @IBAction func fetchMoreSchools(_ sender: Any) {
        if viewModel.nycSchools.count > 0 {
            viewModel.schoolService.pageOffset = viewModel.schoolService.pageOffset + viewModel.schoolService.limit
        }
        viewModel.getSchoolList(completion: reloadTableView, failure: failure)
    }
    
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.nycSchoolsTableView.reloadData()
            self.nycSchoolsTableView.isHidden = self.viewModel.nycSchools.count == 0
            self.moreButton.isEnabled = self.viewModel.isMore
        }
    }

    fileprivate func failure(errorMessage: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Constants.ERROR, message: errorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension NYCSchoolViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfSchools(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowIn(tableView, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.animateCellIn(tableView, cell: cell, forRowAt: indexPath)
    }
    
}


