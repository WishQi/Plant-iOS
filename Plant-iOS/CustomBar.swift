//
//  CustomBar.swift
//  Plant-iOS
//
//  Created by 赵一达 on 2016/11/27.
//  Copyright © 2016年 Li Maoqi. All rights reserved.
//

import Foundation
import UIKit

class customNavigationController:UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationBar.shadowImage = UIImage()
        
        //        self.navigationBar.frame.height =
        
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //    }
}
class customTabBarController:UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
    }
}
