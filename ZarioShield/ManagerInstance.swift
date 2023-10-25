//
//  ManagerInstance.swift
//  ZarioShield
//
//  Created by Rodrigo Vianna on 24/10/2023.
//

import ManagedSettings
import FamilyControls

class ManagerInstance {
    public static let shared = ManagerInstance()
    
    private let store = ManagedSettingsStore()
    
    private init() {}
    
    func stopShieldingApplications() {
        store.shield.applications?.removeAll()
        store.shield.webDomains?.removeAll()
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific([], except: Set())
    }
    
    func startApplicationsShielding() {
        // Need to create a persistence
        let selectionToDiscourage = PersistData.shared.fetchUserPreferences() ?? FamilyActivitySelection()
        
        store.shield.applications = selectionToDiscourage.applicationTokens
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(selectionToDiscourage.categoryTokens, except: Set())
        store.shield.webDomains = selectionToDiscourage.webDomainTokens
    }
    
    func fetchShieldedApplicationsName() -> [String] {
        var applicationsName = [String]()
        if let applications = store.application.blockedApplications {
            for app in applications {
                if let appName = app.localizedDisplayName {
                    applicationsName.append(appName)
                }
            }
        }
        return applicationsName
    }
}
