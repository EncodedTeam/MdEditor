//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Aksilont on 21.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

/// Показывает последние файлы
protocol IRecentFileManager {
	func getRecentFiles() async -> [FileSystemEntity]
	func addToRecentFiles(_ file: FileSystemEntity) async
	func clearRecentFiles() async
	func deleteRecentFile(_ file: FileSystemEntity) async
}

actor RecentFileManager: IRecentFileManager {
	private let userDefaults: UserDefaults
	private let key: String

	init(userDefaults: UserDefaults = UserDefaults.standard, key: String) {
		self.userDefaults = userDefaults
		self.key = key
	}

	func getRecentFiles() -> [FileSystemEntity] {
		guard let data = userDefaults.data(forKey: key),
			  let decodedItems = try? JSONDecoder().decode([FileSystemEntity].self, from: data) else {
			return []
		}
		return decodedItems.compactMap { $0 }
	}

	func addToRecentFiles(_ file: FileSystemEntity) {
		var recentFiles = getRecentFiles()
		if let index = recentFiles.firstIndex(of: file) {
			recentFiles.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
		} else {
			recentFiles.insert(file, at: 0)
		}
		
		let result = Array(recentFiles.prefix(5))

		guard let encodedData = try? JSONEncoder().encode(result) else { return }
		userDefaults.setValue(
			encodedData,
			forKey: key
		)
	}

	func clearRecentFiles() {
		userDefaults.removeObject(forKey: key)
	}

	func deleteRecentFile(_ file: FileSystemEntity) {
		var recentFiles = getRecentFiles()
		recentFiles.removeAll(where: { $0 == file })

		guard let encodedData = try? JSONEncoder().encode(recentFiles) else { return }
		userDefaults.setValue(
			encodedData,
			forKey: key
		)
	}
}
