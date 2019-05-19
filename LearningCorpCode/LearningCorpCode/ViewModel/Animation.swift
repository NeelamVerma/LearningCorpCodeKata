//
//  Animation.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 5/18/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

enum AnimationFactory {
    
    static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseIn],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation
    
    init(animation: @escaping Animation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }
        
        animation(cell, indexPath, tableView)
        
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}
