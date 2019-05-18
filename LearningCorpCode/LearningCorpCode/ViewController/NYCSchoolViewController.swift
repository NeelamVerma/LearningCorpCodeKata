//
//  ViewController.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 15/05/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit
import MapKit

class NYCSchoolViewController: UIViewController {

    @IBOutlet weak var nycSchoolsTableView: UITableView!
    @IBOutlet weak var moreButton: UIButton!
    var viewModel = NYCSchoolViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func navigateToAddress(for sender: UIButton) {
        
        if let latitude = Double(viewModel.nycSchools[sender.tag].latitude ?? "0.0"), let longitude = Double(viewModel.nycSchools[sender.tag].longitude ?? "0.0") {
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = "\(viewModel.nycSchools[sender.tag].school_name ?? "UNKNOWN")"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
}

extension NYCSchoolViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfSchools(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NYC_SCHOOL_CELL_IDENTIFIER, for: indexPath) as? NYCSchoolCell {
            cell.schoolNameLabel.text = viewModel.schoolNameToDisplay(for: indexPath)
            cell.schoolEmailLabel.text = viewModel.schoolEmailToDisplay(for: indexPath)
            cell.schoolPhoneNumber.text = viewModel.schoolPhoneToDisplay(for: indexPath)
            cell.navigateToMap.tag = indexPath.row
            cell.navigateToMap.addTarget(self, action: #selector(self.navigateToAddress(for :)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
}


