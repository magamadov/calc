//
//  main.swift
//  calc
//
//  Created by ZELIMKHAN MAGAMADOV on 02.02.2021.
//

import Foundation
import ArgumentParser

struct Calc: ParsableCommand {
	
	@Argument(help: "Enter numbers for calculation")
	var input: String?
	
	func run() throws {
		if let input = input {
			let lexer = Lexer(input: input)
			let tokens = try lexer.lex()
			let parser = Parser(tokens: tokens)
			let result = try parser.parse()
			print(result)
		}
	}
}

Calc.main()
