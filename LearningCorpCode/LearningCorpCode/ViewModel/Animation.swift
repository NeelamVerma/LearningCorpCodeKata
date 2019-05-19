//
//  Animation.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 5/18/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

private let transformFan = { (layer: CALayer) -> CATransform3D in
    var transform = CATransform3DIdentity
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
    transform = CATransform3DRotate(transform, -CGFloat(Double.pi)/2.0, 0.0, 0.0, 1.0)
    transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0, 0.0, 0.0)
    return transform
}

struct AnimationFactory {
    
    static func makeSlideFall(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.contentView.layer.transform = transformFan(cell.layer)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseIn],
                animations: {
                    cell.contentView.layer.transform = CATransform3DIdentity
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
