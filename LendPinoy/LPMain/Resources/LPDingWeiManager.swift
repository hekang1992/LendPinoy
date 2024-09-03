//
//  LPDingWeiManager.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/2.
//

import UIKit
import RxSwift
import CoreLocation

class LPDingWeiManager: NSObject {
    
    private var locationManager = CLLocationManager()
    
    private var locationUpdateHandler: ((DingModel) -> Void)?
    
    var obs: PublishSubject<DingModel?> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        setupObservable()
    }
    
    deinit {
        print("--------------")
    }
}

extension LPDingWeiManager: CLLocationManagerDelegate {
    
    func setupObservable() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        obs.debounce(RxTimeInterval.milliseconds(2000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { locationModel in
                if let locationModel = locationModel {
                    self.locationUpdateHandler?(locationModel)
                }
            }).disposed(by: disposeBag)
    }
    
    func startUpdatingLocation(completion: @escaping (_ locationModel: DingModel) -> Void) {
        locationUpdateHandler = completion
        if CLLocationManager.authorizationStatus() == .denied {
            let model = DingModel()
            locationUpdateHandler?(model)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            locationManager.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        processLocation(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    private func processLocation(location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let model = DingModel()
        model.shichimi = latitude
        model.spice = longitude
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first else { return }
            model.mizugashi = placemark.locality ?? ""
            model.conversation = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
            model.also = placemark.country ?? ""
            model.dessert = placemark.isoCountryCode ?? ""
            model.season = placemark.administrativeArea ?? ""
            self.obs.onNext(model)
            self.obs.onCompleted()
            self.locationManager.stopUpdatingLocation()
        }
    }
    
}
