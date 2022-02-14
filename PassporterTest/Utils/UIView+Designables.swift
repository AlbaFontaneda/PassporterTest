//
//  UIView+Designables.swift
//  PassporterTest
//
// 	Creación de designables propios para poder usarlos en los xibs
// 	(corner radius, border, rotacion de views...)
//
//  Created by Alba Fontaneda Rueda on 13/2/22.
//

import Foundation
import UIKit

@IBDesignable extension UIView {

	@IBInspectable var borderWidth: CGFloat {
		set {
			layer.borderWidth = newValue
		}
		get {
			return layer.borderWidth
		}
	}

	@IBInspectable var cornerRadius: CGFloat {
		set {
			layer.cornerRadius = newValue
		}
		get {
			return layer.cornerRadius
		}
	}

	@IBInspectable var borderColor: UIColor? {
		set {
			guard let uiColor = newValue else { return }
			layer.borderColor = uiColor.cgColor
		}
		get {
			guard let color = layer.borderColor else { return nil }
			return UIColor(cgColor: color)
		}
	}
	
	@IBInspectable
		var rotation: Int {
			get {
				return 0
			} set {
				let radians = ((CGFloat.pi) * CGFloat(newValue) / CGFloat(180.0))
				self.transform = CGAffineTransform(rotationAngle: radians)
			}
		}
}
