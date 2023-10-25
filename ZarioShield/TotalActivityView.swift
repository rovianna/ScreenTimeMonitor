//
//  TotalActivityView.swift
//  ZarioShield
//
//  Created by Rodrigo Vianna on 24/10/2023.
//

import SwiftUI

struct TotalActivityView: View {
    @StateObject var model = TimeRestrictionModel.shared
    @State var isPresented = false
    
    var body: some View {
        VStack {
            List{
                
                HStack {
                    Button("Select Apps to Limit") {
                        isPresented = true
                    }
                    .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
                }
                Toggle("Start Monitoring", isOn: $model.isMonitoring)
                    .foregroundColor(Color(.systemBlue))
                    .onChange(of: model.isMonitoring) { newValue in
                        model.isMonitoring = newValue
                        
                        if newValue {
                            model.initiateMonitoring()
                            
                        } else {
                            model.stopMonitoring()
                        }
                    }
            }
        }
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
struct TotalActivityView_Previews: PreviewProvider {
    static var previews: some View {
        TotalActivityView()
    }
}
