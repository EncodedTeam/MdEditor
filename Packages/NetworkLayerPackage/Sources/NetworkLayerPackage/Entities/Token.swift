//
//  Token.swift
//  NetworkLayer
//
//  Created by Kirill Leonov 
//

/// Авторизационный токен.
public struct Token: MaskStringConvertible {
	/// Значение авторизационного токена
	let rawValue: String

	// MARK: - Initialization
	public init(_ rawValue: String) {
		self.rawValue = rawValue
	}
}
