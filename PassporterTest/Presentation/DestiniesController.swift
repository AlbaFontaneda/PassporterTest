//
//  ViewController.swift
//  PassporterTest
//
//  Created by Alba Fontaneda Rueda on 13/2/22.
//

import UIKit

class DestiniesController: UIViewController {
	@IBOutlet weak var destiniesTable: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var emptyDataLabel: UILabel!
	@IBOutlet weak var loadingView: UIActivityIndicatorView!
	
	private lazy var destiniesRepo: DestiniesProtocol? = nil
	private var destinities = [Destiny]()
	private var filteredData = [Destiny]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		destiniesRepo = DestiniesRepository.init()
		
		registerCells()
		getData()
	}

	// MARK: - GET API REST DATA
	private func getData() {
		loadingView.startAnimating()
		loadingView.isHidden = false
		destiniesRepo?.getDestinies(completionHandler: { [weak self] response in
			DispatchQueue.main.async {
				
				self?.loadingView.stopAnimating()
				self?.loadingView.isHidden = true
			
				switch response {
					case .Susccess(let list):
						self?.destinities = list
						self?.filteredData = list
						self?.destiniesTable.reloadData()
						
					case .Error(let error):
						print(error.localizedDescription)
				}
			}
		})
	}
}

// MARK: - TABLE VIEW EXTENSIONS
extension DestiniesController: UITableViewDelegate, UITableViewDataSource {
	func registerCells() {
		searchBar.delegate = self
		destiniesTable.delegate = self
		destiniesTable.dataSource = self
		
		destiniesTable.register(UINib.init(nibName: DestinyTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: DestinyTableViewCell.identifier())
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DestinyTableViewCell.identifier(), for: indexPath) as! DestinyTableViewCell
		
 		cell.configureCell(destiny: filteredData[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		performSegue(withIdentifier: "DetailsDestinyViewControllerSegue", sender: filteredData[indexPath.row])
	}
}

// MARK: - SEARCH VIEW EXTENSIONS
extension DestiniesController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		filteredData = destinities
		if searchText.isEmpty == false {
			filteredData = destinities.filter({ $0.name?.lowercased().contains(searchText.lowercased()) == true })
			
			self.emptyDataLabel.isHidden = !filteredData.isEmpty
		}
		destiniesTable.reloadData()
	}
}

// MARK: - NAVIGATION
extension DestiniesController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? DetailsViewController {
			vc.destiny = (sender as? Destiny)
		}
	}
}
