//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Aksilont on 21.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

/// Показывает последние файлы
protocol IRecentFilesManager {
	func getRecentFiles() async -> [FileSystemEntity]
	func addToRecentFiles(_ file: FileSystemEntity) async
	func clearRecentFiles() async
}

actor RecentFilesManager: IRecentFilesManager {
	func getRecentFiles() -> [FileSystemEntity] {
		guard let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.recentFilesKey.rawValue),
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
		UserDefaults.standard.setValue(
			encodedData,
			forKey: UserDefaults.Keys.recentFilesKey.rawValue
		)
	}

	func clearRecentFiles() {
		UserDefaults.standard.reset()
	}
}
