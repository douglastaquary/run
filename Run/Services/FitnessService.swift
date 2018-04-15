//
//  FitnessService.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit
import HealthKit

public class FitnessService {
    
    public enum Error: Swift.Error {
        case unableToDelete
    }
    
    let healthStore: HealthStoreProtocol
    
    let distanceQuantity: HKQuantityTypeIdentifier
    let distanceType: HKQuantityType
    
//    let kilometersPerHour: HKQuantityTypeIdentifier
//    let kilometersPerHourType: HKQuantityType
    
    public init(healthStore: HealthStoreProtocol = HKHealthStore()){
        self.healthStore = healthStore
        self.distanceQuantity = HKQuantityTypeIdentifier.distanceWalkingRunning
        self.distanceType = HKObjectType.quantityType(forIdentifier: self.distanceQuantity)!
//        self.kilometersPerHour = HKQuantityTypeIdentifier.
//        self.kilometersPerHourType = HKObjectType.quantityType(forIdentifier: self.kilometersPerHour)!
    }
    
    // MARK: - Fetch
    public func fetch(_ completion: @escaping (_ results: [Fitness]) -> Void) {
        fetch(entries: nil, completion)
    }
    
    public func fetch(entries: Int? = nil, _ completion: @escaping (_ results: [Fitness]) -> Void)
    {
        let startDate = healthStore.earliestPermittedSampleDate()
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions())
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: distanceType,
                                  predicate: predicate,
                                  limit: entries ?? HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor])
        { query, results, error in
            // WARNING: improve
            guard error == nil else {
                print(error as Any)
                
                return
            }
            
            guard let samples = results as? [HKQuantitySample] else {
                fatalError("Wrong type")
            }
            
            if samples.isEmpty {
                print("No samples")
            }
            
            let workouts = samples.map { Fitness(with: $0) }
            
            DispatchQueue.main.async {
                completion(workouts)
            }
        }
        
        healthStore.execute(query)
    }
    
    // MARK: - Save
    public func save(_ workout: Fitness,
                     completion: @escaping (_ error: Swift.Error?) -> Void)
    {
        let distance = HKQuantity(unit: .meterUnit(with: .deca),
                                  doubleValue: workout.distance.value)
        
        let metadata = [HKMetadataKeyWasUserEntered: true]
        let sample = HKQuantitySample(type: distanceType,
                                      quantity: distance,
                                      start: workout.date,
                                      end: workout.date,
                                      metadata: metadata)
        
        healthStore.save(sample) { (success, error) in
            completion(error)
        }
    }
    
    // MARK: - Delete
    public func delete(_ mass: Fitness, completion: @escaping (_ error: Swift.Error?) -> Void)
    {
        guard case let .permanent(uuid) = mass.status else {
            completion(Error.unableToDelete)
            return
        }
        
        let predicate = HKQuery.predicateForObject(with: uuid)
        
        healthStore.deleteObjects(of: distanceType,
                                  predicate: predicate) { (success, deleted, error) in
                                    if deleted == 0 {
                                        completion(Error.unableToDelete)
                                    } else {
                                        completion(error)
                                    }
        }
    }
    
    // MARK: - Authorization
    public var authorizationStatus: FitnessRepositoryAuthorizationStatus {
        
        let status: FitnessRepositoryAuthorizationStatus
        
        switch healthStore.authorizationStatus(for: distanceType) {
        case .notDetermined:
            status = .notDetermined
        case .sharingDenied:
            status = .denied
        case .sharingAuthorized:
            status = .authorized
        }
        
        return status
    }
    
    public func requestAuthorization(_ completion: @escaping (_ error: Swift.Error?) -> Void )
    {
        let workoutSet = Set<HKSampleType>(arrayLiteral: distanceType)
        
        healthStore.requestAuthorization(toShare: workoutSet,
                                         read: workoutSet)
        { [weak self] (success, error) in
            #if os(iOS)
            self?.startObservingWorkout()
            #endif
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    #if os(iOS)
    public func requestAuthorizationForExtension() {
        healthStore.handleAuthorizationForExtension { [weak self] (success, error) in
            self?.startObservingWorkout()
            print("Extension request \(success.description)")
            if let error = error {
                print(error)
            }
        }
    }
    #endif
    
    // MARK: - Observing
    var workoutObserverStarted = false
    
    @available(watchOS, unavailable)
    func startObservingWorkout()
    {
        #if os(iOS)
        guard workoutObserverStarted == false else {
            return
        }
        
        workoutObserverStarted = true
        
        let query = HKObserverQuery(sampleType: distanceType,
                                    predicate: nil)
        { [weak self] (query, completion, error) in
            guard error == nil else {
                self?.workoutObserverStarted = false
                self?.startObservingAppOpen()
                return
            }
            
            NotificationCenter.default.post(name: .FitnessServiceDidUpdate,
                                            object: self)
            completion()
        }
        
        healthStore.execute(query)
        #endif
    }
    
    var appOpenObserver: NSObjectProtocol? = nil
    
    @available(watchOS, unavailable)
    func startObservingAppOpen()
    {
        #if os(iOS)
        guard authorizationStatus != .authorized,
            appOpenObserver == nil else {
                return
        }
        
        let center = NotificationCenter.default
        appOpenObserver =
            center.addObserver(forName: .UIApplicationDidBecomeActive,
                               object: nil,
                               queue: .main)
            { [weak self] notification in
                self?.startObservingWorkout()
                if self?.authorizationStatus == .authorized,
                    let observer = self?.appOpenObserver {
                    NotificationCenter.default.removeObserver(observer)
                }
        }
        #endif
    }
    
}

// MARK: - Notifications
extension NSNotification.Name {
    public static let FitnessServiceDidUpdate: NSNotification.Name =  NSNotification.Name(rawValue: "FitnessServiceDidUpdate")
}

