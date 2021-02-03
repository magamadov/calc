//
//  Token.swift
//  calc
//
//  Created by ZELIMKHAN MAGAMADOV on 02.02.2021.
//

import Foundation

enum Token: CustomStringConvertible {
	case number(Int)
	case plus
	case minus
	case multi
	case div
	
	var description: String {
		switch self {
			case .number(let num):
				return "Number: \(num)"
			case .plus:
				return "Symbol: +"
			case .minus:
				return "Symbol: -"
			case .multi:
				return "Symbol: *"
			case .div:
				return "Symbol: /"
		}
	}
}
