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

		if let docsURL = Bundle.main.url(forResource: "Documents", withExtension: nil),
		   let enumerator = FileManager.default.enumerator(at: docsURL, includingPropertiesForKeys: nil) {

			while let fileURL = enumerator.nextObject() as? URL {
				if fileURL.pathExtension == "md" {
					let fileName = fileURL.lastPathComponent
					let preview = generatePreview(for: fileURL)
					let docInfo = Document(fileName: fileName, preview: preview)
					docs.append(docInfo)
				}
			}
		}
		return docs
	}

	private func generatePreview(for fileURL: URL) -> UIImage? {
		let webView = WKWebView()
		let markdownString = try? String(contentsOf: fileURL, encoding: .utf8)
		webView.loadHTMLString(markdownString ?? "empty", baseURL: nil)

		let renderer = UIGraphicsImageRenderer(size: webView.bounds.size)
		let image = renderer.image { context in
			webView.drawHierarchy(in: webView.bounds, afterScreenUpdates: true)
		}

		return image
	}
}
struct Document {
	let fileName: String
	let preview: UIImage?
}
