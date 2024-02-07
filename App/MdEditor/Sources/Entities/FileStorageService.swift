//
//  FileStorageService.swift
//  MdEditor
//
//  Created by Aksilont on 06.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

enum ResourcesBundle {
	static let documents: String = "Documents.bundle"
	static let about: String = "about.md"

	static var defaultsUrls: [URL] {
		var urls: [URL] = []
		let bundleUrl = Bundle.main.resourceURL
		if let docsURL = bundleUrl?.appendingPathComponent(documents) {
			urls.append(docsURL)
		}
		if let homeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
			urls.append(homeURL)
		}
		return urls
	}
}

enum StorageError: Error {
	case errorURL
	case errorFetching
	case errorCreating
	case errorDeleting
}

protocol IStorageService {
	func fetchData(urls: [URL]) async -> Result<[FileSystemEntity], StorageError>
	func fetchRecent(count: Int?, with urls: [URL]) async -> Result<[FileSystemEntity], StorageError>
}

actor FileStorageService: IStorageService {
	// MARK: - Private properties
	private let fileManager = FileManager.default

	// MARK: - Public methods
	func fetchData(urls: [URL]) -> Result<[FileSystemEntity], StorageError> {
		do {
			if urls.count == 1 {
				guard let url = urls.first else { return .failure(.errorURL) }
				let result = try fetchNested(url: url)
				return .success(result)
			} else {
				let result = try fetchRoot(urls)
				return .success(result)
			}
		} catch {
			return .failure(.errorFetching)
		}
	}

	func fetchRecent(count: Int? = nil, with urls: [URL]) -> Result<[FileSystemEntity], StorageError> {
		do {
			let result = try scanFiles(with: urls).sorted(by: >)
			guard let count else { return.success(result) }
			let filteredResult = Array(result.prefix(count))
			return.success(filteredResult)
		} catch {
			return .failure(.errorFetching)
		}
	}
}

// MARK: - Private methods
private extension FileStorageService {
	func scanFiles(with urls: [URL]) throws -> [FileSystemEntity] {
		var files: [FileSystemEntity] = []
		for item in urls {
			let attributes = try fileManager.attributesOfItem(atPath: item.relativePath)
			let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()
			let size = (attributes[FileAttributeKey.size] as? UInt64) ?? 0

			if item.hasDirectoryPath {
				let contents = try fileManager.contentsOfDirectory(
					at: item,
					includingPropertiesForKeys: nil,
					options: .skipsHiddenFiles
				)
				for nestedItem in contents {
					let nestedFiles = try scanFiles(with: [nestedItem])
					files.append(contentsOf: nestedFiles)
				}
			} else {
				let file = FileSystemEntity(
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

	func fetchRoot(_ urls: [URL]) throws -> [FileSystemEntity] {
		var files: [FileSystemEntity] = []
		for item in urls {
			let attributes = try fileManager.attributesOfItem(atPath: item.relativePath)
			let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

			let size = try getSize(for: item)

			if item.hasDirectoryPath {
				let directory = FileSystemEntity(
					url: item,
					isDir: true,
					creationDate: creationDate,
					modificationDate: modificationDate,
					size: size
				)
				files.append(directory)
			} else {
				let file = FileSystemEntity(
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

	func fetchNested(url: URL) throws -> [FileSystemEntity] {
		var files: [FileSystemEntity] = []

		let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
		let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
		let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

		if url.hasDirectoryPath {
			let contents = try fileManager.contentsOfDirectory(
				at: url,
				includingPropertiesForKeys: nil,
				options: .skipsHiddenFiles
			)
			for item in contents {
				let size = try getSize(for: item)
				let file = FileSystemEntity(
					url: item,
					isDir: item.hasDirectoryPath,
					creationDate: creationDate,
					modificationDate: modificationDate,
					size: size
				)
				files.append(file)
			}
		} else {
			let size = try getSize(for: url)
			let file = FileSystemEntity(
				url: url,
				creationDate: creationDate,
				modificationDate: modificationDate,
				size: size
			)
			files.append(file)
		}
		return files
	}

	func getSize(for url: URL) throws -> UInt64 {
		var size: UInt64 = 0
		if url.hasDirectoryPath {
			let contents = try fileManager.contentsOfDirectory(
				at: url,
				includingPropertiesForKeys: nil,
				options: .skipsHiddenFiles
			)
			for item in contents {
				size += try getSize(for: item)
			}
			return size
		} else {
			let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
			let size = (attributes[FileAttributeKey.size] as? UInt64) ?? 0
			return size
		}
	}
}
