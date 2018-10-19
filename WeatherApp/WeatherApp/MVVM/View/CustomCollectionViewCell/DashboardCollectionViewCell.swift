//
//  DashboardCollectionViewCell.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 19/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configureCell(viewModel: DashboardViewModel) {
        monthLabel.text = viewModel.setMonthName()
        valueLabel.text = viewModel.setMonthValue()
    }
    
}
