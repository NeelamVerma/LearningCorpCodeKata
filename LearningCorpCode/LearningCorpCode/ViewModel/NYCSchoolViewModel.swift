//
//  NYCSchoolViewModel.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 5/17/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class NYCSchoolViewModel: NSObject {
    var nycSchools = [NYCSchool]()
    var selectedNYCSchool: NYCSchool?
    var schoolService = SchoolService()
    var isMore = false
    
    func getSchoolList(completion:@escaping () -> Void, failure: @escaping (String) -> Void){
        schoolService.fetchListOfNYCSchools(completion: { (listOfSchool, isMore) in
            DispatchQueue.main.async {
                self.nycSchools.append(contentsOf: listOfSchool)
                self.isMore = isMore
                completion()
            }
            
        }) { error in
            failure(error)
        }
    }
    
    func getNumberOfSchools(in section: Int) -> Int {
        return nycSchools.count
    }
    
    func schoolNameToDisplay(for IndexPath: IndexPath) -> String {
        return nycSchools[IndexPath.row].school_name ?? "UNKNOWN"
    }
    
    func schoolEmailToDisplay(for IndexPath: IndexPath) -> String {
        return nycSchools[IndexPath.row].school_email ?? "UNKNOWN"
    }
    
    func schoolPhoneToDisplay(for IndexPath: IndexPath) -> String {
        return nycSchools[IndexPath.row].phone_number ?? "UNKNOWN"
    }
}

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}