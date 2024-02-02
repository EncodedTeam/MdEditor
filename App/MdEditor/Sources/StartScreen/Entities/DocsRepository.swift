//
//  DocsRepository.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit
import WebKit

/// Репозиторий для получения документов
protocol IDocsRepository {

	/// Получить список документов.
	/// - Returns: Массив документов.
	func getDocs() -> [Document]
}

/// Stub Репозиторя для получения заданий.
final class DocsRepositoryStub: IDocsRepository {

	/// Возвращает предустановленные данные для приложения.
	/// - Returns: Массив документов
	func getDocs() -> [Document] {
		var docs: [Document] = []
		let fileManager = FileManager.default
		let bundleUrl = Bundle.main.bundleURL
		let docsURL = bundleUrl.appendingPathComponent("Documents.bundle")

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
						let preview = generateRandomColorImage(size: CGSize(width: 150, height: 250))
						docs.append(Document(fileName: fileName, preview: preview))
					}
				}
			} catch let error as NSError {
				fatalError(error.localizedDescription)
			}
		}

		processDirectory(at: docsURL)

		return docs
	}

//	private func generatePreview(for fileURL: URL) -> UIImage? {
//		let webView = WKWebView()
//		let markdownString = try? String(contentsOf: fileURL, encoding: .utf8)
//		webView.loadHTMLString(markdownString ?? "empty", baseURL: nil)
//
//		let renderer = UIGraphicsImageRenderer(size: webView.bounds.size)
//		let image = renderer.image { context in
//			webView.drawHierarchy(in: webView.bounds, afterScreenUpdates: true)
//		}
//
//		return image
//	}
	private func generateRandomColorImage(size: CGSize) -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: size)
		let image = renderer.image { context in
			let randomColor = UIColor(
				red: CGFloat.random(in: 0...1),
				green: CGFloat.random(in: 0...1),
				blue: CGFloat.random(in: 0...1),
				alpha: 1.0
			)
			randomColor.setFill()
			context.fill(context.format.bounds)
		}
		return image
	}
}
struct Document {
	let fileName: String
	let preview: UIImage?
}
