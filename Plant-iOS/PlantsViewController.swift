//
//  ViewController.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit

class PlantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // TableView
    @IBOutlet weak var plantsTableView: UITableView!
    
    // Plant Model
    var plants = [Plant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantsTableView.delegate = self
        plantsTableView.dataSource = self
        
    }
    
    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = plantsTableView.dequeueReusableCell(withIdentifier: "plantCell") as? PlantTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }


}

