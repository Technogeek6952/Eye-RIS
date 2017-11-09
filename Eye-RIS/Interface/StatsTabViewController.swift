//
//  StatsTabViewController.swift
//  Eye-RIS
//
//  Created by Bowers on 11/8/17.
//  Copyright © 2017 Tubular Innovations. All rights reserved.
//

import Foundation
import UIKit

class StatsTabViewController: UIViewController {
    
    @IBOutlet weak var timesDrivenLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    
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
        
        // Update statistics
        if let stats = (UIApplication.shared.delegate as? AppDelegate)?.drivingStatistics {
            timesDrivenLabel.text = String(format: "Times Driven: %d", stats.drives)
            averageScoreLabel.text = String(format: "Average Safe Driving Score: %d", stats.averageScore)
        }
    }
    
    // Before the view disappears, allow all orientations
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
}
