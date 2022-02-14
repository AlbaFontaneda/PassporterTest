//
//  Models.swift
//  PassporterTest
//
//  Created by Alba Fontaneda Rueda on 13/2/22.
//

import Foundation

struct APIResponse: Codable {
	let results: [Destiny]
}

struct Destiny: Codable {
	let type: String?
	let name: String?
	let address: String?
	let cover: String?
	let location: DestinyLocation?
}

struct DestinyLocation: Codable {
	let latitude: Double
	let longitude: Double
}

