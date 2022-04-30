//
//  MapViewController.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.04.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol MapDelegate: AnyObject {
    func updateTransferName(transferName: String)
}

protocol MapViewInput: AnyObject { }

class MapViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let findText = "Найти"
        static let hideText = "Скрыть"
        static let placeholderText = "Адрес"
        static let readyText = "Готово"
    }
    
    
    // MARK: - Properties
    
    var presenter: MapViewOutput?
    
    private let readyButton = UIButton(type: .system)
    private let locationButton = UIButton(type: .system)
    private let locationTextField = UITextField()
    private let mapView = MKMapView()
    
    private let locationManager = CLLocationManager()
    
    weak var mapDelegate: MapDelegate?
    
    
    // MARK: - Drawing

    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    func drawSelf() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSuperView))
        mapView.addGestureRecognizer(tapGesture)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: -50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: Locals.findText,
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(self.didTapFindButton))
        let hide: UIBarButtonItem = UIBarButtonItem(title: Locals.hideText,
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(self.hideButtonAction))
        
        done.tintColor = .black
        hide.tintColor = .black
        let items = [done, flexSpace, hide]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        locationTextField.inputAccessoryView = doneToolbar
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.backgroundColor = .white
        locationTextField.attributedPlaceholder = NSAttributedString(
            string: Locals.placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
        locationTextField.font = UIFont(name: .regular, size: 16)
        locationTextField.textColor = .black
        locationTextField.autocorrectionType = .no
        locationTextField.keyboardType = .namePhonePad
        locationTextField.layer.cornerRadius = 8.8
        locationTextField.leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10,
            height: locationTextField.frame.height))
        locationTextField.leftViewMode = .always
        locationTextField.rightView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: -10,
            height: locationTextField.frame.height))
        locationTextField.rightViewMode = .always
        locationTextField.delegate = self
        locationTextField.returnKeyType = .search
        
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        locationButton.tintColor = .black
        locationButton.addTarget(self,
                              action: #selector(didTapLocationButton),
                              for: .touchUpInside)
        
        readyButton.translatesAutoresizingMaskIntoConstraints = false
        readyButton.setTitle(Locals.readyText, for: .normal)
        readyButton.titleLabel?.font = UIFont(name: .medium, size: 16)
        readyButton.tintColor = .black
        readyButton.addTarget(self,
                              action: #selector(didTapReadyButton),
                              for: .touchUpInside)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mapView)
        mapView.addSubview(locationTextField)
        mapView.addSubview(readyButton)
        mapView.addSubview(locationButton)
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            locationTextField.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 16),
            locationTextField.widthAnchor.constraint(equalToConstant: 250),
            locationTextField.heightAnchor.constraint(equalToConstant: 20),
            
            readyButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 18),
            readyButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20),
            
            locationButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -18),
            locationButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20),
                        
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
    }
    
    
    // MARK: - Private methods
    
    private func updateLocationOnMap(to location: CLLocation, with title: String?) {
        
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(point)

        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    private func updatePlaceMark(to address: String) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) {
            [weak self] (placemarks, error) in
            guard
            let placemark = placemarks?.first,
            let location = placemark.location
            else { return }
            
            self?.updateLocationOnMap(to: location, with: placemark.name)
            self?.mapDelegate?.updateTransferName(transferName: placemark.name ?? "")
        }
    }
    
   private func coordinationConventor(coordination: CLLocationCoordinate2D) -> CLLocation{
            let getLatitude: CLLocationDegrees = coordination.latitude
            let getLongitude: CLLocationDegrees = coordination.longitude
            let newLocation: CLLocation =  CLLocation(latitude: getLatitude, longitude: getLongitude)
            return newLocation
        }
    
    
    // MARK: - Actions
    
    @objc func didTapLocationButton() {
        guard let currentLocation = locationManager.location
            else { return }

        currentLocation.lookUpLocationName {
            [weak self] (name) in
            self?.updateLocationOnMap(to: currentLocation, with: name)
            self?.mapDelegate?.updateTransferName(transferName: name ?? "")
        }
    }
    
    @objc func didTapSuperView(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        let point = MKPointAnnotation()
        point.coordinate = coordinate
        mapView.addAnnotation(point)
        
        let convertedCoordinate = coordinationConventor(coordination: coordinate)

        convertedCoordinate.lookUpLocationName {
            [weak self] (name) in
            self?.updateLocationOnMap(to: convertedCoordinate, with: name)
            self?.mapDelegate?.updateTransferName(transferName: name ?? "")
        }
        
    }
    
    @objc func didTapFindButton() {
        updatePlaceMark(to: locationTextField.text ?? "")
    }
    
    @objc func didTapReadyButton() {
        presenter?.didTapReadyButton()
    }
    
    @objc func hideButtonAction(){
        locationTextField.resignFirstResponder()
    }

}


// MARK: - MapViewInput
extension MapViewController: MapViewInput { }


// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first
        else {
            return
        }
        
        location.lookUpLocationName {
            [weak self] (name) in
            self?.updateLocationOnMap(to: location, with: name)
            self?.mapDelegate?.updateTransferName(transferName: name ?? "")
        }
    }
}


// MARK: - UITextFieldDelegate
extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = locationTextField.text
        else {
            return false
        }
        
        updatePlaceMark(to: text)
        return true
    }
}
