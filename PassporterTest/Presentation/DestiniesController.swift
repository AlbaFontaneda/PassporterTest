//
//  ViewController.swift
//  PassporterTest
//
//  Created by Alba Fontaneda Rueda on 11/2/22.
//

import UIKit

class ViewController: UIViewController {
	typealias Repository = DestiniesProtocol
	
	private let destiniesRepo: DestiniesProtocol
	
	init(repository: Repository) {
		destiniesRepo = repository
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		destiniesRepo.getDestinies(completionHandler: { response in
			r
		})
		
	}


}

