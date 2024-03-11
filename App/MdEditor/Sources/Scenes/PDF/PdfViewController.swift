//
//  PdfViewController.swift
//  MdEditor
//
//  Created by Aksilont on 11.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit
import PDFKit

final class PdfViewController: UIViewController {
	// MARK: - Public properties

	// MARK: - Dependencies

	// MARK: - Private properties
	private let pdfView = PDFView()
	private let data: Data

	// MARK: - Initialization
	init(data: Data) {
		self.data = data
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		pdfView.autoScales = true
		pdfView.pageBreakMargins = UIEdgeInsets(top: 32, left: 16, bottom: 16, right: 16)
		pdfView.document = PDFDocument(data: data)

		setupView()
	}

	// MARK: - Public methods

	// MARK: - Delegate implementation

	// MARK: - Private methods
	private func setupView() {
		title = "PDF View"
		pdfView.frame = view.frame
		pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

		view.addSubview(pdfView)
	}
}
