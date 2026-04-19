//
//  APIServiceManager.swift
//  MVLApp
//
//  Created by Prajyot Prakash Chougule on 17/04/26.
//

import Foundation
internal import Combine
import Alamofire
import CoreLocation 

protocol APIServiceProtocol {
    func fetchLocation(lat: Double, lon: Double, update: Bool) async throws -> LocationData
    func fetchAirQuality(lat: Double, lon: Double, token: String) async throws -> AirData
    func performBooking(markers: [MapMarkerItem]) async throws -> BookingResponse
    func fetchHistory(year: Int, month: Int) async throws -> [HistoryItem]
}

// Example implementation
@MainActor
class APIServiceManager {
    
    func fetchLocation(url: String) async throws -> LocationData {
        // No longer Main-actor isolated, so this works now!
        return try await AF.request(url)
            .serializingDecodable(LocationData.self)
            .value
    }
    
    func fetchAirQuality(url: String) async throws -> AirData {
        // FIX: Ensure you are requesting AirData.self here (Solves 1 Error)
        return try await AF.request(url)
            .serializingDecodable(AirData.self)
            .value
    }
    
    func performBooking(markers: [MapMarkerItem]) async throws -> BookingResponse {
        let locationA = markers[0]
        let locationB = markers[1]
        
        // 1. Prepare Request Data
        let parameters: [String: Any] = [
            "locationA": ["address": locationA.address, "lat": locationA.coordinate.latitude],
            "locationB": ["address": locationB.address, "lat": locationB.coordinate.latitude]
        ]

        let request = BookingRequest(locationA: markers[0], locationB: markers[1])

        return try await AF.request("https://dummy.com",
                                                      method: .post,
                                                      parameters: parameters,
                                                      encoding: JSONEncoding.default)
                        .serializingDecodable(BookingResponse.self)
                        .value
    }
    
    func fetchHistory(year: Int, month: Int) async throws -> [HistoryItem] {
           let url = "/books?year=2020&month=11."
           
           let parameters: [String: Any] = [
               "year": year,
               "month": month
           ]
           
           return try await AF.request(url, method: .get, parameters: parameters)
               .serializingDecodable([HistoryItem].self)
               .value
       }
    
}
