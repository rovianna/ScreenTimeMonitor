//
//  TimeRestrictionModel.swift
//  ZarioMonitoring
//
//  Created by Rodrigo Vianna on 24/10/2023.
//

import Foundation
import FamilyControls
import DeviceActivity

class TimeRestrictionModel: ObservableObject {
    
    static let shared = TimeRestrictionModel()
    
    @Published var isMonitoring = false
    
    private let schedule = DeviceActivitySchedule(
        intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
        intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
        repeats: true
    )
        
    private let center = DeviceActivityCenter()
    private let activity = DeviceActivityName(Environments.ActivityName)
    private let eventName = DeviceActivityEvent.Name(Environments.EventName)
    
    var selectionToDiscourage = PersistData.shared.fetchUserPreferences() ?? FamilyActivitySelection() {
        
        willSet {
            PersistData.shared.persistUserPreferences(selection: newValue)
            ManagerInstance.shared.stopShieldingApplications()
        }
    }
    
    private init() {
        isMonitoring = PersistData.shared.getMonitoringState()
    }

    func initiateMonitoring() {
        PersistData.shared.saveMonitoringState(isMonitoring: true)
        ManagerInstance.shared.stopShieldingApplications()
        center.stopMonitoring()

        selectionToDiscourage = PersistData.shared.fetchUserPreferences() ?? FamilyActivitySelection()

        let dateC = DateComponents(second: 10)
        
        let event = DeviceActivityEvent(
            applications: selectionToDiscourage.applicationTokens,
            categories: selectionToDiscourage.categoryTokens,
            webDomains: selectionToDiscourage.webDomainTokens,
            threshold: dateC
        )
        
        do {
            try center.startMonitoring(activity, during: schedule, events: [eventName:event])
            
        } catch {
            print ("Could not start monitoring \(error)")
        }
    }
    
    func stopMonitoring() {
        PersistData.shared.saveMonitoringState(isMonitoring: false)
        ManagerInstance.shared.stopShieldingApplications()
        center.stopMonitoring()
    }
}

