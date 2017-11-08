//
//  ViewController.swift
//  Eye-RIS
//
//  Created by Bowers on 11/3/17.
//  Copyright © 2017 Tubular Innovations. All rights reserved.
//

import UIKit

class TabRootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Before the view appears, lock the orientation to portrait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Lock orientation to portrait
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    // Before the view disappears, allow all orientations
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }

}

