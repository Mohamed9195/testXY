//
//  TrackXY.swift
//  TrackXY
//
//  Created by mohamed hashem on 9/21/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationDelegate: CLLocationManagerDelegate {
    var locationRXSubject: ReplaySubject<LocationStruct> { get set }
}

protocol LocationServices {
    func start() -> Observable<LocationStruct>
    func stop()
}

public struct LocationStruct {

    var locationName: String?
    var locationLong: Double?
    var locationLate: Double?

    init(locationName: String?, locationLong: Double?, locationLate: Double?) {
        self.locationName = locationName
        self.locationLong = locationLong
        self.locationLate = locationLate
    }
}

internal class LocationServicesClass: NSObject, LocationServices {

    internal var locationManager: CLLocationManager
    internal var locationDelegate: LocationDelegate

    required internal init(LocationDelegate: LocationDelegate) {

        locationManager = CLLocationManager()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        self.locationDelegate = LocationDelegate
        locationManager.delegate = LocationDelegate
    }

    func start() -> Observable<LocationStruct> {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationDelegate.locationRXSubject.asObserver()
    }

    func stop() {
        locationManager.stopUpdatingLocation()
    }
}

class LocationDelegation: NSObject, LocationDelegate  {

    var locationRXSubject: ReplaySubject<LocationStruct>
    private let dispatchQueue = DispatchQueue(label: "IBeaconQueue")
    let disposeBag = DisposeBag()

    internal override init() {
        locationRXSubject = ReplaySubject<LocationStruct>
            .create(bufferSize: 1)
        super.init()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationCoordinate = locations.last?.coordinate else {
            return
        }

        let newLocation = LocationStruct(locationName: "",
                                         locationLong: locationCoordinate.longitude,
                                         locationLate: locationCoordinate.latitude)
        
        if UIApplication.shared.applicationState == .active {
            locationRXSubject.onNext(newLocation)
        } else {
            locationRXSubject.onNext(newLocation)
        }
    }
}


open class RXLocation: LocationServices  {

    private let location: LocationServices

    private static var currentLocation: RXLocation?

       public static var `default`: RXLocation {
           get {
               guard let currentLocation = currentLocation else {
                   fatalError("iBeaconBLE is not configured")
               }

               return currentLocation
           }
       }

    public static func configure() {
           currentLocation = RXLocation()
       }

    internal init() {
        location = LocationServicesClass(LocationDelegate: LocationDelegation())
    }

    public func start() -> Observable<LocationStruct> {
        location.start()
    }

    public func stop() {
        location.stop()
    }
}
