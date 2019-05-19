//
//  SchoolService.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 17/05/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class SchoolService: NSObject {
    
    //MARK:- Pagination Vars
    var pageOffset = 0
    var limit = 10
    
    //MARK:- Network Vars
    var session = URLSession.shared
    var nycSchoolURL = Constants.NYC_SCHOOL_URL
    
    //MARK:- Network APIS
    /// To fetch NYC high Schools page by page , per page limit is set to 10
    /// https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$limit=10&$offset=0
    /// - Parameters:
    ///   - pageNumber: page offset
    ///   - completion: is all data gets fetched
    ///   - failure: failure
    func fetchListOfNYCSchools(completion: @escaping ([NYCSchool], Bool) -> (), failure: @escaping (String) -> ()) {
        guard var urlComponents = URLComponents(string: nycSchoolURL) else {
            self.resetPageOffsetToPrevious(failure: failure, error: "Unexpected error")
            return
        }
        urlComponents.query = "$limit=\(limit)&$offset=\(pageOffset)"
        guard let url = urlComponents.url else {
            self.resetPageOffsetToPrevious(failure: failure, error: "Unexpected error")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: request) { (schoolListData, response, error) in
            
            guard let data = schoolListData else {
                self.resetPageOffsetToPrevious(failure: failure, error: error?.localizedDescription)
                return
            }
            do {
                let listOfSchools =  try JSONDecoder().decode([NYCSchool].self, from: data)
                if listOfSchools.count < self.limit {
                    completion(listOfSchools, false)
                } else {
                    completion(listOfSchools, true)
                }
            } catch {
                self.resetPageOffsetToPrevious(failure: failure, error: error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
    //MARK:- Helper Methods
    /// Reset The page index to the previous if the current page fails to fetch next NYC Schools
    /// - Parameters:
    ///   - failure: failure
    ///   - error: error messsgae
    fileprivate func resetPageOffsetToPrevious(failure: (String) -> (), error: String?){
        if self.pageOffset > 0 {
            self.pageOffset = self.pageOffset - self.limit
        }
        failure("\(error ?? "Unexpected error:").")
    }

}
