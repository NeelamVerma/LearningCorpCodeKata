//
//  NYCSchoolViewModel.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 5/17/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit
import MapKit

class NYCSchoolViewModel: NSObject {
    var nycSchools = [NYCSchool]()
    var schoolService = SchoolService()
    var isMore = false
    
    func getSchoolList(completion:@escaping () -> Void, failure: @escaping (String) -> Void){
        schoolService.fetchListOfNYCSchools(completion: { (listOfSchool, isMore) in
            self.nycSchools.append(contentsOf: listOfSchool)
            self.isMore = isMore
            completion()
        }) { error in
            failure(error)
        }
    }
    
    func getNumberOfSchools(in section: Int) -> Int {
        return nycSchools.count
    }
    
    @objc func navigateToMap(for sender: UIButton)  {
        if let latitude = Double(nycSchools[sender.tag].latitude ?? "0.0"), let longitude = Double(nycSchools[sender.tag].longitude ?? "0.0") {
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = "\(nycSchools[sender.tag].school_name ?? Constants.UNKNOWN)"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    func cellForRowIn(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NYC_SCHOOL_CELL_IDENTIFIER, for: indexPath) as? NYCSchoolCell ?? NYCSchoolCell()
        cell.setContent(withSchool: nycSchools[indexPath.row])
        cell.navigateToMap.tag = indexPath.row
        cell.navigateToMap.addTarget(self, action: #selector(navigateToMap(for:)), for: .touchUpInside)
        return cell
    }
    
    func animateCellIn(_ tableView: UITableView, cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeSlideFall(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}
