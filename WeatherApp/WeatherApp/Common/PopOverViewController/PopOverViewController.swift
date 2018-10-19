//
//  PopOverViewController.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 17/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var popOverTableView: UITableView!
    var popOverValueArray = [ParamType]()
    var paramObject = Parameter()
    var popOverDidDismiss: ((_ param: Parameter) -> Void )?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        popOverValueArray = [.EN,.UK,.WA,.SCO]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Custom Method
    func configureTableView() {
        popOverTableView.delegate = self
        popOverTableView.dataSource = self
    }
}

extension PopOverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return popOverValueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PopOverTableViewCell") as? PopOverTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("PopOverTableViewCell", owner: self, options: nil)?.first as? PopOverTableViewCell
        }
        cell?.selectionStyle = .none
        cell?.parameterLabel?.text = popOverValueArray[indexPath.row].rawValue
        return cell!
    }
}

extension PopOverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.paramObject.isReadyToSet {
            self.paramObject.location = popOverValueArray[indexPath.row]
            popOverValueArray.removeAll()
            self.paramObject.isReadyToSet = true
            popOverValueArray = [.Tmax,.Tmin,.Rainfall]
        } else {
            self.paramObject.metric = popOverValueArray[indexPath.row]
            self.dismiss(animated: false, completion: {
                self.popOverDidDismiss!(self.paramObject)
            })
        }
        popOverTableView.reloadData()
    }
}

