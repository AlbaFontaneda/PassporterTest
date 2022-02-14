//
//  DetailsViewController.swift
//  PassporterTest
//
//  Created by Alba Fontaneda Rueda on 14/2/22.
//

import Foundation
import UIKit
import MapKit

class DetailsViewController: UIViewController {
	var destiny: Destiny!
	
	@IBOutlet weak var destinyCover: UIImageView!
	@IBOutlet weak var navigateToMap: UIButton!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var destinyName: UILabel!
	@IBOutlet weak var destinyAddressFirst: UILabel!
	@IBOutlet weak var destinyAddressSecond: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupMap()
	}
	
	// MARK: - SETUP
	private func setupUI() {
		navigationItem.title = destiny.name
		destinyCover.downloaded(from: destiny.cover, placeholder: "placeholder_fullimage")
		
		destinyName.text = destiny.name
		destinyAddressFirst.text = destiny.address
		if let location = destiny.location {
			destinyAddressSecond.text = "(\(location.latitude), \(location.longitude)"
		}
		
	}
	
	// MARK: - SETUP MAP
	private func setupMap() {
		guard let location = destiny.location else {
			return
		}
		let destinyLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
		let marker = MKPointAnnotation()
		marker.title = destiny.name
		marker.coordinate = destinyLocation
		
		mapView.addAnnotation(marker)
		let region = MKCoordinateRegion(center: destinyLocation, latitudinalMeters: 500, longitudinalMeters: 500)
		mapView.setRegion(region, animated: true)
	}
	
	@IBAction func navigateTo(_ sender: Any) {
		openMaps(latitude: destiny.location?.latitude, longitude: destiny.location?.longitude, title: destiny.address)
	}
}

// MARK: - EXTERNAL MAP EXTENSION
extension DetailsViewController {
	func openMaps(latitude: Double?, longitude: Double?, title: String?) {
		if let lat = latitude, let long = longitude {
			let application = UIApplication.shared
			let coordinate = "\(lat),\(long)"
			let encodedTitle = title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
			let handlers = [
			  ("Apple Maps", "http://maps.apple.com/?q=\(encodedTitle)&ll=\(coordinate)")
			].compactMap { (name, address) in URL(string: address).map { (name, $0) } }
				.filter { (_, url) in application.canOpenURL(url) }

			if let (_, url) = handlers.first {
				application.open(url, options: [:])
			}
		}
	}
}
