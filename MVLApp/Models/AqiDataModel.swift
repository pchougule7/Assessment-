//
//  AqiDataModel.swift
//  MVLApp
//
//  Created by Prajyot Prakash Chougule on 18/04/26.
//

import Foundation
nonisolated struct AirData: Codable, Sendable {
    // Add your AirData properties here
    let qualityIndex: Int
}


struct AirDetails: Codable {
    let aqi: Int
}
