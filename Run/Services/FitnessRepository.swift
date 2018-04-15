//
//  FitnessRepository.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import Foundation

public protocol FitnessRepository {
    var authorizationStatus: FitnessRepositoryAuthorizationStatus { get }
    func fetch(_ completion: @escaping (_ results: [Fitness]) -> Void)
    func save(_ mass: Fitness, completion: @escaping (_ error: Error?) -> Void)
    func delete(_ mass: Fitness, completion: @escaping (_ error: Error?) -> Void)
    func requestAuthorization(_ completion: @escaping (_ error: Error?) -> Void )
    #if os(iOS)
    func requestAuthorizationForExtension()
    #endif
}

public enum FitnessRepositoryAuthorizationStatus {
    case notDetermined
    case denied
    case authorized
}
