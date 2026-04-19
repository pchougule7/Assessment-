//
//  MockAPIServiceManager.swift
//  MVLApp
//
//  Created by Prajyot Prakash Chougule on 17/04/26.
//

import Foundation
class MockAPIService: APIServiceProtocol {
    func fetchLocation(lat: Double, lon: Double) async throws -> LocationData {
        return try await fetchLocation(lat: lat, lon: lon, update: true)
    }
    
    func fetchLocation(lat: Double, lon: Double, update: Bool = false) async throws -> LocationData {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec delay
        print("NewPPCupdated:\(update)")
        return LocationData(city: update ? "Updated City" : "Mock City", locality: "Fake Neighborhood")
    }
    
    func fetchAirQuality(lat: Double, lon: Double, token: String) async throws -> AirData {
        return AirData(qualityIndex: 45)
    }
    
    func performBooking(markers: [MapMarkerItem]) async throws -> BookingResponse {
        try await Task.sleep(nanoseconds: 100_000_000)
        return BookingResponse(id: "1", locationA: markers[0], locationB: markers[1], price: 1000)
    }
    
    func fetchHistory(year: Int, month: Int) async throws -> [HistoryItem] {
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5s delay
            return [
                HistoryItem(a: .init(latitude: 36.564, longitude: 127.001, aqi: 30, name: "mock City"),
                            b: .init(latitude: 36.567, longitude: 127.0, aqi: 40, name: "updated city"),
                            price: 10000),
                HistoryItem(a: .init(latitude: 36.577, longitude: 127.033, aqi: 50, name: "city A"),
                            b: .init(latitude: 36.567, longitude: 127.0, aqi: 60, name: "city B"),
                            price: 20000)
            ]
        }

}
