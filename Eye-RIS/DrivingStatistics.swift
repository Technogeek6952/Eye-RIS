//
//  DrivingStatistics.swift
//  Eye-RIS
//
//  Created by Bowers on 11/8/17.
//  Copyright © 2017 Tubular Innovations. All rights reserved.
//

import Foundation

class DrivingStatistics {
    
    var drives: Int
    var averageScore: Int
    
    init(_ savedPath: String){
        // load saved data
        drives = 0
        averageScore = 0
    }
}
