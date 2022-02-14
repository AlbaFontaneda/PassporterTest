//
//  RequestResponse.swift
//  PassporterTest
//
//  Created by Alba Fontaneda Rueda on 11/2/22.
//

import Foundation

enum RequestResponse<T> {
	 case Susccess(T)
	 case Error(ErrorType)
}

enum ErrorType: Error {
	case BasicError(Error)
	case CodeError(Int)
	case ParsingError(Error)
}
