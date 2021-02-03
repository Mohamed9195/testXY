//
//  RXPermissions.swift
//  TrackXY
//
//  Created by mohamed hashem on 9/21/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import RxSwift

public enum Service {
    case location
}

public enum ServiceStatus {
    case enabled
    case disabled
    case notAuthorized
    case unknown
}

open class RXPermissions {

    private let locationServiceManager = LocationManager()

    public init() {

    }

    public func observe(services: Service) -> Observable<(service: Service, status: ServiceStatus)> {

        var observables = [Observable<(service: Service, status: ServiceStatus)>]()

        if services == .location {
            let observable = locationServiceManager
                .stateSubject
                .asObservable()
                .distinctUntilChanged()
            observables.append(observable.map { (service: .location, status: $0) })
        }
        return Observable.merge(observables)
    }
}
