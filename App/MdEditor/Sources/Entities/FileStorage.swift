//
//  FileStorage.swift
//  MdEditor
//
//  Created by Aksilont on 04.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

enum ResourceBundle {
	static let documents: String = "Documents.bundle"
	static let about: String = "about.md"
}

/// Протокол для файлового хранилища
protocol IFileStorage {
	/// Сканирует файл и директории
	/// - Parameter url: директория для сканирования
	/// - Returns: массив `File`
	func scan(url: URL) throws -> [File]
	
	/// Получить все валоженные директории из переданного массива `URL`
	/// - Parameter items: массив директорий
	/// - Returns: массив `File`
	func getDirectoriesFrom(_ items: [URL]) throws -> [File]
	
	/// Получить содержимое файла
	/// - Parameter url: путь к файлу
	/// - Returns: строка
	func loadFileBody(url: URL) -> String
	
	/// Получить все файлы
	/// - Returns: массив файлов
	func getAllDocs() -> [Document]

	/// Получить стандартные директории
	/// - Returns: массив `URL` директорий
	func getDefaultUrls() -> [URL]
}

final class FileStorage: IFileStorage {
	// MARK: - Private properties
	private let fileManager = FileManager.default

	// MARK: - Public methods
	func scan(url: URL) throws -> [File] {
		guard url.hasDirectoryPath else { return [] }

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

	func getDirectoriesFrom(_ items: [URL]) throws -> [File] {
		var files: [File] = []
		for item in items {
			guard item.hasDirectoryPath else { continue }

			let attributes = try fileManager.attributesOfItem(atPath: item.relativePath)
			let creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			let modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

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
		}
		return files
	}

	func loadFileBody(url: URL) -> String {
		var text = ""
		do {
			text = try String(contentsOf: url, encoding: String.Encoding.utf8)
		} catch {
			text = "Failed to read text from \(url.lastPathComponent)"
		}

		return text
	}
	/// Возвращает массив всех документов в приложении
	func getAllDocs() -> [Document] {
		var docs: [Document] = []
		let urls = getDefaultUrls()

		func processDirectory(at directoryURL: URL) {
			do {
				let contents = try fileManager.contentsOfDirectory(
					at: directoryURL,
					includingPropertiesForKeys: nil,
					options: .skipsHiddenFiles
				)

				for item in contents {
					if item.hasDirectoryPath {
						processDirectory(at: item)
					} else if item.pathExtension == "md" {
						let fileName = item.lastPathComponent
						let preview = UIImage(randomColorWithSize: CGSize(width: 150, height: 250))
						docs.append(Document(fileName: fileName, preview: preview))
					}
				}
			} catch let error as NSError {
				fatalError(error.localizedDescription)
			}
		}

		urls.forEach(processDirectory)

		return docs
	}
	
	func getDefaultUrls() -> [URL] {
		var urls: [URL] = []
		let bundleUrl = Bundle.main.resourceURL
		if let docsURL = bundleUrl?.appendingPathComponent(ResourceBundle.documents) {
			urls.append(docsURL)
		}
		if let homeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
			urls.append(homeURL)
		}
		return urls
	}
}

struct Document {
	let fileName: String
	let preview: UIImage?
}
