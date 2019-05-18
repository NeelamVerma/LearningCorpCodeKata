//
//  NYCSchoolCell.swift
//  LearningCorpCode
//
//  Created by Neelam Verma on 17/05/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class NYCSchoolCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolEmailLabel: UILabel!
    @IBOutlet weak var schoolPhoneNumber: UILabel!
    @IBOutlet weak var navigateToMap: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        renderCellView()
    }
    
    func renderCellView() {
        let view = cellView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }
    
}
