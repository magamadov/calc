//
//  Parser.swift
//  calc
//
//  Created by ZELIMKHAN MAGAMADOV on 02.02.2021.
//

import Foundation

class Parser {
	enum Error: Swift.Error {
		case unexpectedEndOfInput
		case invalidToken(Token)
	}
	
	private let tokens: [Token]
	private var position = 0
	
	init(tokens: [Token]) {
		self.tokens = tokens
	}
	
	private func getNextToken() -> Token? {
		guard position < tokens.count else { return nil }
		
		let token = tokens[position]
		position += 1
		return token
	}
	
	private func plusminus() throws -> Int {
		var value = try multdiv()
		
		while let token = getNextToken() {
			switch token {
				case .plus:
					value += try multdiv()
				case .minus:
					value -= try multdiv()
				default:
					position -= 1
					return value
			}
		}
		return value
	}
	
	private func multdiv() throws -> Int {
		var value = try factor()
		
		while let token = getNextToken() {
			switch token {
				case .multi:
					value *= try factor()
				case .div:
					value /= try factor()
				default:
					position -= 1
					return value
			}
		}
		return value
	}
	
	private func factor() throws -> Int {
		guard let token = getNextToken() else { throw Error.unexpectedEndOfInput }
		
		switch token {
			case .number(let num):
				return num
			default:
				throw Error.invalidToken(token)
		}
	}
	
	func parse() throws -> Int {
		return try plusminus()
	}
}
