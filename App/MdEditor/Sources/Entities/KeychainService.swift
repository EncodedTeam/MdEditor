//
//  KeychainService.swift
//  MdEditor
//
//  Created by Aksilont on 20.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

struct KeychainService {
	// MARK: - Private properties
	private let serviceName: String
	private let key: String

	// MARK: - Public methods
	@discardableResult
	func set(_ value: String) -> Bool {
		guard let data = value.data(using: .utf8) else { return false }
		
		var queryDictionary = setupKeychainQueryDictionary()
		queryDictionary[kSecValueData as String] = data

		let status = SecItemAdd(queryDictionary as CFDictionary, nil)
		if status == errSecSuccess {
			return true
		} else if status == errSecDuplicateItem {
			return update(value)
		} else {
			return false
		}
	}

	@discardableResult
	func get() -> String? {
		var queryDictionary = setupKeychainQueryDictionary()
		queryDictionary[kSecReturnData as String] = true
		queryDictionary[kSecMatchLimit as String] = kSecMatchLimitOne

		var dataTypeRef: AnyObject?
		let status = SecItemCopyMatching(queryDictionary as CFDictionary, &dataTypeRef)
		if status == errSecSuccess, let data = dataTypeRef as? Data {
			return String(data: data, encoding: .utf8)
		} else {
			return nil
		}
	}

	@discardableResult 
	func delete() -> Bool {
		let queryDictionary = setupKeychainQueryDictionary()
		let status = SecItemDelete(queryDictionary as CFDictionary)
		return status == errSecSuccess
	}

	// MARK: - Private methods
	private func setupKeychainQueryDictionary() -> [String: Any] {
		[
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: serviceName,
			kSecAttrAccount as String: key
		]
	}

	private func update(_ value: String) -> Bool {
		guard let data = value.data(using: .utf8) else { return false }

		let queryDictionary = setupKeychainQueryDictionary()
		let updateDictionary = [kSecValueData as String: data]

		let status = SecItemUpdate(queryDictionary as CFDictionary, updateDictionary as CFDictionary)
		return status == errSecSuccess
	}
}
