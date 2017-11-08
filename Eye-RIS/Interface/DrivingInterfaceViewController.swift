//
//  DrivingViewController.swift
//  Eye-RIS
//
//  Created by Bowers on 11/3/17.
//  Copyright © 2017 Tubular Innovations. All rights reserved.
//

import Foundation
import UIKit

class DrivingInterfaceViewController: UIViewController {
    
    // Timer used to update the view every second
    var timer = Timer()
    
    // The unix timestamp for when the view was loaded
    var startTime: Int = 0
    
    // Label to show how long we have been driving
    @IBOutlet weak var drivingTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set startTime as the time when the view was loaded
        startTime = Int(Date().timeIntervalSince1970)
        
        // update the view every second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: true)
    }
    
    // Called once a second to update the view
    @objc func updateView(){
        /*------UPDATE TIMER------*/
        // Calculate the number of seconds for which the view has been shown
        let secondsRunning = Int(Date().timeIntervalSince1970) - startTime
        // Calculate the hours, minutes, and seconds for which the view has been shown
        let hours   = Int(floor(Float(secondsRunning % (60*60*24)) / Float(60 * 60)))
        let minutes = Int(floor(Float(secondsRunning % (60*60))    / Float(60)))
        let seconds = Int(floor(Float(secondsRunning % (60))       / Float(1)))
        
        // Format the time string (Driving - hh:mm:ss), or if hours is 0, (mm:ss)
        var timeStampText: String
        if (hours > 0){
            timeStampText = String.init(format: "Driving - %02d:%02d:%02d", hours, minutes, seconds)
        }else{
            timeStampText = String.init(format: "Driving - %02d:%02d", minutes, seconds)
        }
        
        // Update the label
        drivingTimeLabel.text = timeStampText
        
        // Redraw the view after updating all components
        self.view.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Before the view appears, lock the orientation to landscape
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Lock orientation to portrait
        AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
    }
    
    // Before the view disappears, allow all orientations
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    @IBAction func endDriveButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToMainView", sender: sender)
    }
}
