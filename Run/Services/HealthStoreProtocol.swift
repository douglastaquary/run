//
//  HealthStoreProtocol.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import Foundation
import HealthKit

public protocol HealthStoreProtocol {
    
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>?,
                              read typesToRead: Set<HKObjectType>?,
                              completion: @escaping (Bool, Error?) -> Void)
    
    #if os(iOS)
    func handleAuthorizationForExtension(completion: @escaping (Bool, Error?) -> Void)
    #endif
    
    func earliestPermittedSampleDate() -> Date
    
    func execute(_ query: HKQuery)
    
    func save(_ object: HKObject, withCompletion completion: @escaping (Bool, Error?) -> Void)
    
    func deleteObjects(of objectType: HKObjectType, predicate: NSPredicate, withCompletion completion: @escaping (Bool, Int, Error?) -> Void)
    
    func authorizationStatus(for type: HKObjectType) -> HKAuthorizationStatus
    static func isHealthDataAvailable() -> Bool
    
    func preferredUnits(for quantityTypes: Set<HKQuantityType>, completion: @escaping ([HKQuantityType : HKUnit], Error?) -> Void)
}

extension HKHealthStore: HealthStoreProtocol {}
