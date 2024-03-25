//
//  NetworkRequests.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 25.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation
import NetworkLayerPackage

// MARK: - Get all files
struct NetworkRequestAllFiles: INetworkRequest {
	let path = NetworkEndpoints.getAllFiles.description
	let method = HTTPMethod.get
	let header = [String: String]()
	let parameters = Parameters.none
}

// MARK: - Get file by id
struct NetworkRequestFileById: INetworkRequest {
	let path: String
	let method = HTTPMethod.get
	let header = [String: String]()
	let parameters = Parameters.none
	
	init(_ id: String) {
		path = NetworkEndpoints.getFile(id: id).description
	}
}

// MARK: - Download file by id
struct NetworkRequestDownloadFileById: INetworkRequest {
	let path: String
	let method = HTTPMethod.get
	let header = [String: String]()
	let parameters = Parameters.none
	
	init(_ id: String) {
		path = NetworkEndpoints.download(id: id).description
	}
}

// MARK: - Delete file by id
struct NetworkRequestDeleteFileById: INetworkRequest {
	let path: String
	let method = HTTPMethod.delete
	let header = [String: String]()
	let parameters = Parameters.none
	
	init(_ id: String) {
		path = NetworkEndpoints.delete(id: id).description
	}
}

// MARK: - Upload file
struct NetworkRequestUpload: INetworkRequest {
	let path = NetworkEndpoints.upload.description
	let method = HTTPMethod.post
	let header: [String: String]
	let parameters: Parameters
	
	init(url: URL) {
		let separator = "\r\n"
		let boundary = UUID().uuidString
		
		// Header
		let multipartContentType = HeaderField.contentType(.multipart(boundary: boundary))
		header = [
			multipartContentType.key: multipartContentType.value
		]
		
		// Parameters
		let fileKey = "file"
		let fileName = url.lastPathComponent
		let fileData = (try? Data(contentsOf: url)) ?? Data()
		var formData = Data()
		let markdownContentType = HeaderField.contentType(.markdown)
		
		formData.append("--\(boundary)")
		formData.append(separator)
		formData.append(
			"Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(fileName)\""
		)
		formData.append(separator)
		formData.append(
			"\(markdownContentType.key): \(markdownContentType.value)"
		)
		formData.append(separator)
		formData.append(separator)
		formData.append(fileData)
		formData.append(separator)
		formData.append("--\(boundary)--")
		
		parameters = .data(formData, .multipart(boundary: boundary))
	}
}
