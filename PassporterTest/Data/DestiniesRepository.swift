//
//  DestiniesRepository.swift
//  PassporterTest
//
// Repositorio para obtener los datos del apirest
//
//  Created by Alba Fontaneda Rueda on 13/2/22.
//

import Foundation

protocol DestiniesProtocol {
	func getDestinies(completionHandler: @escaping (_ result: RequestResponse<[Destiny]>) -> Void)
}

struct DestiniesRepository: DestiniesProtocol {
	
	func getDestinies(completionHandler: @escaping (_ result: RequestResponse<[Destiny]>) -> Void) {
		let dataURL = URL(string: Config.EndPoints.PROD)!
		let task = URLSession(configuration: .default).dataTask(with: dataURL, completionHandler: { data, response, error in
			guard error == nil else {
				completionHandler(RequestResponse.Error(ErrorType.BasicError(error!)))
				return
			}
			
			if let data = data, let response = response as? HTTPURLResponse {
				switch response.statusCode {
					case 200 ..< 299:
						do {
							let decodedObject = try JSONDecoder().decode(APIResponse.self, from: data)
							
							Logger.log(.success, "OK response")
							completionHandler(RequestResponse.Susccess(decodedObject.results))
						} catch let error {
							Logger.log(.error, "Parsing error")
							
							completionHandler(RequestResponse.Error(ErrorType.ParsingError(error)))
						}
					default:
						Logger.log(.error, "Cant get data")
						completionHandler(RequestResponse.Error(ErrorType.CodeError(response.statusCode)))
				}
			}
		})

		task.resume()
	}
}


