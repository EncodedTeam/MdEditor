//
//  FileNetworkService.swift
//  MdEditor
//
//  Created by Aksilont on 24.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation
import NetworkLayerPackage
import OSLog

protocol IFileNetworkService {
	/// Получение списка файлов на сервере
	func fetchAllFiles(completion: @escaping (Result<[FileNetworkEntity], HTTPNetworkServiceError>) -> Void)
	
	/// Получение информации о файле на сервере
	/// - Parameter id: id файла
	func fetchFile(
		by id: String,
		completion: @escaping (Result<FileNetworkEntity, HTTPNetworkServiceError>) -> Void
	)
	
	/// Загрузка файла на устройство
	/// - Parameter id: id файла
	func downloadFile(
		by id: String,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	)
	
	/// Удаление файла с сервера
	/// - Parameter id: id файла
	func deleteFile(
		by id: String,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	)
	
	/// Отправка файла на сервер
	/// - Parameter url: путь файла на устройстве
	func uploadFile(
		url: URL,
		completion: @escaping (Result<FileNetworkEntity, HTTPNetworkServiceError>) -> Void
	)
}

final class FileNetworkService: IFileNetworkService {
	private let networkService = NetworkService(session: URLSession.shared, baseUrl: NetworkEndpoints.baseURL)
	private let token = Token(KeychainService().get() ?? "")

	func fetchAllFiles(
		completion: @escaping (Result<[FileNetworkEntity], HTTPNetworkServiceError>) -> Void
	) {
		networkService.perform(
			NetworkRequestAllFiles(),
			token: token,
			completion: completion
		)
	}

	func fetchFile(
		by id: String,
		completion: @escaping (Result<FileNetworkEntity, HTTPNetworkServiceError>) -> Void
	) {
		networkService.perform(
			NetworkRequestFileById(id),
			token: token,
			completion: completion
		)
	}

	func downloadFile(
		by id: String,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		networkService.perform(
			NetworkRequestDownloadFileById(id),
			token: token,
			completion: completion
		)
	}

	func deleteFile(
		by id: String,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		networkService.perform(
			NetworkRequestDeleteFileById(id),
			token: token,
			completion: completion
		)
	}

	func uploadFile(
		url: URL,
		completion: @escaping (Result<FileNetworkEntity, HTTPNetworkServiceError>) -> Void
	) {
		networkService.perform(
			NetworkRequestUpload(url: url),
			token: token,
			completion: completion
		)
	}
}
