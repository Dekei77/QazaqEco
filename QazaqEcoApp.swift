//
//  QazaqEcoApp.swift
//  QazaqEco
//
//  Created by Amir Syrymbetov on 02.02.2025.
//

import SwiftUI

@main
struct QazaqEcoApp: App {
    @StateObject var profileData = ProfileData()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(profileData) 
        }
    }
}
