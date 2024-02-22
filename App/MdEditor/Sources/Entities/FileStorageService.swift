//
//  FileStorageService.swift
//  MdEditor
//
//  Created by Aksilont on 06.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

enum ResourcesBundle {
	static let assets = "Assets"
	static let about = "about.md"
	static let extMD = "md"
	
	static let bundle = Bundle.main.resourceURL ?? Bundle.main.bundleURL
	static let bundlePath = Bundle.main.resourcePath ?? Bundle.main.bundlePath
	static let aboutFile = bundle.appendingPathComponent(about)

	static var defaultsUrls: [URL] {
		var urls: [URL] = []
		let bundleUrl = Bundle.main.resourceURL
		if let docsURL = bundleUrl?.appendingPathComponent(assets) {
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
	/// Получить файлы/папки
	/// - Parameter urls: источники для получения
	/// - Returns: `Result<[FileSystemEntity], StorageError>`
	func fetchData(urls: [URL]) async -> Result<[FileSystemEntity], StorageError>
	
	/// Получить сущность файла
	/// - Parameters:
	///   - url: `URL` файла
	///   - ext: массив расширений для отбора
	/// - Returns: `Optional(FileSystemEntity)`
	func getEntity(from url: URL, with ext: [String]) async throws -> FileSystemEntity?

	/// Загрузить данные из файла
	/// - Parameter url: адрес файла
	/// - Returns: текстовое представление файла
	func loadFile(_ file: FileSystemEntity) async -> String
}

actor FileStorageService: IStorageService {
	// MARK: - Private properties
	private let fileManager = FileManager.default

	// MARK: - Public methods
	func fetchData(urls: [URL]) -> Result<[FileSystemEntity], StorageError> {
		do {
			/// В случае передачи 1 URL - возвращает данные о вложенных файлах/папка по этому адресу
			/// Иначе возвращает `[FileSystemEntity]` по заданным URL
			if urls.count == 1 {
				guard let url = urls.first else { return .failure(.errorURL) }
				let result = try fetch(with: url)
				return .success(result)
			} else {
				let result = try fetchRoot(urls)
				return .success(result)
			}
		} catch {
			return .failure(.errorFetching)
		}
	}

	func getEntity(from url: URL, with ext: [String] = [ResourcesBundle.extMD]) throws -> FileSystemEntity? {
		// Если это файл и указано расширение - выполнить проверку на соответствие указанному расширению
		if !ext.isEmpty, !url.hasDirectoryPath, !ext.contains(url.pathExtension) { return nil }

		let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
		let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
		let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()
		let size = (attributes[FileAttributeKey.size] as? UInt64) ?? .zero

		let relativePath = url.relativePath
		let bundlePath = ResourcesBundle.bundlePath + "/"
		let path = relativePath.replacingOccurrences(of: bundlePath, with: "")

		return FileSystemEntity(
			path: path,
			isDir: url.hasDirectoryPath,
			creationDate: creationDate,
			modificationDate: modificationDate,
			size: size
		)
	}

	func loadFile(_ file: FileSystemEntity) -> String {
		file.loadFileBody()
	}
}

// MARK: - Private methods
private extension FileStorageService {
	func fetchRoot(_ urls: [URL]) throws -> [FileSystemEntity] {
		var files: [FileSystemEntity?] = []
		for item in urls {
			let entity = try getEntity(from: item)
			files.append(entity)
		}
		return files.compactMap { $0 }
	}

	func fetch(with url: URL) throws -> [FileSystemEntity] {
		var files: [FileSystemEntity?] = []
		if url.hasDirectoryPath {
			let contents = try fileManager.contentsOfDirectory(
				at: url,
				includingPropertiesForKeys: nil,
				options: .skipsHiddenFiles
			)
			for item in contents {
				let entity = try getEntity(from: item)
				files.append(entity)
			}
		} else {
			let entity = try getEntity(from: url)
			files.append(entity)
		}
		return files.compactMap { $0 }
	}
}
