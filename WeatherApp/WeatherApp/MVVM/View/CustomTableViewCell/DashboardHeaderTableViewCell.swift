//
//  DashboardHeaderTableViewCell.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import UIKit

class DashboardHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(viewModel: DashboardViewModel) {
        yearLabel.text = viewModel.setYearString()
    }
}
