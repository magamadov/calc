//
//  Lexer.swift
//  calc
//
//  Created by ZELIMKHAN MAGAMADOV on 02.02.2021.
//

import Foundation

class Lexer {
	enum Error: Swift.Error {
		case invalidCharacter(Character)
	}
	
	private let input: String
	private var position: String.Index
	
	init(input: String) {
		self.input = input
		self.position = input.startIndex
	}
	
	private func peek() -> Character? {
		guard position < input.endIndex else { return nil }
		return input[position]
	}
	
	private func advance() {
		precondition(position < input.endIndex, "Cannot advance past endIndex!")
		position = input.index(after: position)
	}
	
	private func getNumber() -> Int {
		var value = 0
		
		while let nextCharacter = peek() {
			switch nextCharacter {
				case "0" ... "9":
					let digitValue = Int(String(nextCharacter))!
					value = 10 * value + digitValue
					advance()
				default:
					return value
			}
		}
		return value
	}
	
	func lex() throws -> [Token] {
		var tokens = [Token]()
		
		while let nextCharacter = peek() {
			switch nextCharacter {
				case "0" ... "9":
					let value = getNumber()
					tokens.append(.number(value))
				case "+":
					tokens.append(.plus)
					advance()
				case "-":
					tokens.append(.minus)
					advance()
				case "*":
					tokens.append(.multi)
					advance()
				case "/":
					tokens.append(.div)
					advance()
				case " ":
					advance()
				default:
					throw Error.invalidCharacter(nextCharacter)
			}
		}
		return tokens
	}
}
