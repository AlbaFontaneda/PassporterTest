//
//  DestinyTableViewCell.swift
//  PassporterTest
//
//  Created by Alba Fontaneda Rueda on 14/2/22.
//

import UIKit

class DestinyTableViewCell: UITableViewCell {

	@IBOutlet weak var cover: UIImageView!
	@IBOutlet weak var destinyName: UILabel!
	@IBOutlet weak var destinyAddress: UILabel!

	func configureCell(destiny: Destiny) {
		destinyName.text = destiny.name
		destinyAddress.text = destiny.address
		
		cover.downloaded(from: destiny.cover)
	}
    
}
