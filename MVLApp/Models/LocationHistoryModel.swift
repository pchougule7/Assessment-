//
//  LocationHistoryModel.swift
//  MVLApp
//
//  Created by Prajyot Prakash Chougule on 18/04/26.
//

import Foundation

nonisolated struct HistoryItem: Codable, Identifiable {
    let id = UUID()
    let a: LocationDetail
    let b: LocationDetail
    let price: Double
    
    struct LocationDetail: Codable {
        let latitude: Double
        let longitude: Double
        let aqi: Int
        let name: String
    }
}
