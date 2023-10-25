//
//  PersistData.swift
//  ZarioShield
//
//  Created by Rodrigo Vianna on 24/10/2023.
//

import Foundation
import FamilyControls

class PersistData {
    
    public static let shared = PersistData()
    
    // Used to encode codable to UserDefaults
    private let encoder = PropertyListEncoder()
    
    // Used to decode codable from UserDefaults
    private let decoder = PropertyListDecoder()
    
    private let sharedApplicationsDataKey = "SharedTimeKey"
    private let isMonitoringKey = "IsMonitoring"
    
    private init() { }
    
    func persistUserPreferences(selection: FamilyActivitySelection) {
        let sharedUserDefaults = UserDefaults(suiteName: "com.br.zarioshield")
        sharedUserDefaults?.set(try? encoder.encode(selection), forKey: sharedApplicationsDataKey)
        sharedUserDefaults?.synchronize()
    }
    
    func fetchUserPreferences() -> FamilyActivitySelection? {
        let sharedUserDefaults = UserDefaults(suiteName: "com.br.zarioshield")
        
        guard let data = sharedUserDefaults?.data(forKey: sharedApplicationsDataKey) else { return nil }
        
        return try? decoder.decode(FamilyActivitySelection.self, from: data)
    }
    
    func saveMonitoringState(isMonitoring: Bool) {
        UserDefaults.standard.set(isMonitoring, forKey: isMonitoringKey)
    }
    
    func getMonitoringState() -> Bool {
        return UserDefaults.standard.bool(forKey: isMonitoringKey)
    }
}
