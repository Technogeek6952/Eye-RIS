//
//  DrivingViewController.swift
//  Eye-RIS
//
//  Created by Bowers on 11/3/17.
//  Copyright © 2017 Tubular Innovations. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class DrivingInterfaceViewController: UIViewController {
    
    // Timer used to update the view every second
    var timer = Timer()
    // The unix timestamp for when the view was loaded
    var startTime: Int = 0
    
    // Driving score stuff
    let drivingScore: Int = 100
    
    // Variables for camera functionality
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // Outlets
    @IBOutlet weak var drivingTimeLabel: UILabel!
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set startTime as the time when the view was loaded
        startTime = Int(Date().timeIntervalSince1970)
        
        // update the view every second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: true)
        
        // Set up camera
        if let captureDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.front).devices.first{
            // captureDevice = front camera
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.frame = cameraView.layer.bounds
                videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                cameraView.layer.addSublayer(videoPreviewLayer!)
                
                captureSession?.startRunning()
            } catch {
                print(error)
            }
        }
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
    
    // Before the view appears, lock the orientation to landscape left
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Lock orientation to landscape left
        AppUtility.lockOrientation(.landscapeLeft, andRotateTo: .landscapeLeft)
    }
    
    // Before the view disappears, allow all orientations
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    @IBAction func endDriveButtonPressed(_ sender: Any) {
        // Add statistics
        
        if let stats = (UIApplication.shared.delegate as? AppDelegate)?.drivingStatistics {
            let newAverage = ((stats.averageScore * stats.drives) + drivingScore) / (stats.drives + 1)
            stats.averageScore = newAverage
            stats.drives += 1
        }
        
        // go back to the main view
        performSegue(withIdentifier: "unwindSegueToTabRoot", sender: sender)
    }
}
