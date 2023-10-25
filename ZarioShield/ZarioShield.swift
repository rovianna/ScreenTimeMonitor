//
//  ZarioShield.swift
//  ZarioShield
//
//  Created by Rodrigo Vianna on 24/10/2023.
//

import DeviceActivity
import SwiftUI

@main
struct ZarioShield: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView()
        }
        // Add more reports here...
    }
}
