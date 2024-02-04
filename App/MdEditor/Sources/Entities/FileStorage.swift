//
//  FileStorage.swift
//  MdEditor
//
//  Created by Aksilont on 04.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IFileStorage {
	func scan(url: URL) throws -> [File]
}

final class FileStorage: IFileStorage {
	// MARK: - Private methods
	private let fileManager = FileManager.default

	// MARK: - Public methods
	func scan(url: URL) throws -> [File] {
		var files: [File] = []
		let contents = try fileManager.contentsOfDirectory(
			at: url,
			includingPropertiesForKeys: nil,
			options: .skipsHiddenFiles
		)

		for item in contents {
			let attributes = try fileManager.attributesOfItem(atPath: item.relativePath)
			let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

			if item.hasDirectoryPath {
				let nestedFiles = try scan(url: item)
				let size = nestedFiles.reduce(into: 0) { partialResult, nextFile in
					partialResult += nextFile.size
				}
				let directory = File(
					url: item,
					isDir: true,
					nestedFiles: nestedFiles,
					creationDate: creationDate,
					modificationDate: modificationDate,
					size: size
				)
				files.append(directory)
			} else {
				let size = (attributes[FileAttributeKey.size] as? UInt64) ?? 0
				let file = File(
					url: item,
					creationDate: creationDate,
					modificationDate: modificationDate,
					size: size
				)
				files.append(file)
			}
		}

		return files
	}
}
