//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {
    @IBOutlet weak var selectedLocationLabel: UILabel!
    @IBOutlet weak var selectedMetricLabel: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Internals
    var dashboardViewModel = DashboardViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        closureSetUp()
        configureTableView()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom Methods
    private func configureView() {
        selectedLocationLabel.text = dashboardViewModel.setLocationString()
        selectedMetricLabel.text = dashboardViewModel.setMetricString()
        
        activityIndicator.startAnimating()
        dashboardViewModel.prepareToCallWeatherAPI(moc: context)
    }
    
    private func configureTableView() {
        dataTableView.dataSource = self
        dataTableView.delegate = self
    }
    
    func closureSetUp() {
        dashboardViewModel.reloadList = {
              DispatchQueue.main.async {
                self.selectedLocationLabel.text = self.dashboardViewModel.setLocationString()
                self.selectedMetricLabel.text = self.dashboardViewModel.setMetricString()
                self.activityIndicator.stopAnimating()
                self.dataTableView.reloadData()
            }
        }
    }
    
    // MARK: - Button Actions
    @IBAction func onTapRightNavigationBarButton(_ sender: Any) {
        let popoverContent = PopOverViewController(nibName: "PopOverViewController", bundle: nil)
        popoverContent.preferredContentSize = CGSize(width: AppConstants.screenWidth/2, height: AppConstants.screenHeight/4)
        popoverContent.title = "Select one"
        popoverContent.popOverDidDismiss = { param in
            self.activityIndicator.startAnimating()
            self.dashboardViewModel.paramObject = param
            self.dashboardViewModel.prepareToCallWeatherAPI(moc: self.context)
        }
        
        let navController = UINavigationController(rootViewController: popoverContent)
        navController.modalPresentationStyle = .popover
        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.barButtonItem = sender as? UIBarButtonItem
        self.present(navController, animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dashboardViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "DashboardHeaderTableViewCell") as! DashboardHeaderTableViewCell
        dashboardViewModel.currentSection = section
        headerCell.configureCell(viewModel: dashboardViewModel)
        headerView.addSubview(headerCell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //Always showing one row for one section, as Month and Year are co-related
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as? DashboardTableViewCell
        cell?.configureCell(viewModel: dashboardViewModel)
        return cell!
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension DashboardViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
