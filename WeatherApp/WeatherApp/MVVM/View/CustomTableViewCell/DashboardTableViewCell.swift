//
//  DashboardTableViewCell.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var monthCollectionView: UICollectionView!{
        didSet {
            monthCollectionView.delegate = self
            monthCollectionView.dataSource = self
        }
    }
    
    var viewModel = DashboardViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        monthCollectionView.reloadData()
    }
}

extension DashboardTableViewCell :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForCollectionView(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
        viewModel.currentCollectionViewRow = indexPath.item
        cell.configureCell(viewModel: viewModel)
        return cell
}
}

extension DashboardTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: AppConstants.screenWidth * 100 / AppConstants.screenWidthForScaling, height:AppConstants.screenHeight * 43.5 / AppConstants.screenHeightForScaling)
        return cellSize
    }
}
