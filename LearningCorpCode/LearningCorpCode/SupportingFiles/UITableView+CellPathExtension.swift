
//
//  UITableView+CellPathExtension.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 5/19/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

extension UITableView {
    
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
