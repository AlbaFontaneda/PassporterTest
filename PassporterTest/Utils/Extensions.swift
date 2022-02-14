//
//  Extensions.swift
//  PassporterTest
//
// Extensiones para trabajar de forma generica con los datos
//
//  Created by Alba Fontaneda Rueda on 13/2/22.
//

import UIKit

// MARK: - CUSTOM ID
extension UIView {
	class func identifier() -> String
	{
		return String(describing: self)
	}
	
	class func nib() -> UINib {
		return UINib(nibName: self.identifier(), bundle: nil)
	}
}

// MARK: - DOWNLOAD IMAGE
extension UIImageView {
	func downloaded(from url: URL) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() { [weak self] in
				self?.image = image
			}
		}.resume()
		
	}
	func downloaded(from link: String?, placeholder: String? = nil) {
		guard let url = URL(string: link ?? "") else {
			self.image = UIImage.init(named: placeholder ?? "placeholder")
			return
		}
		downloaded(from: url)
	}
}
