//
// MdEditorTests.swift
//

import Foundation
import XCTest
@testable import MdEditor
@testable import DataStructuresPackage

final class MdEditorTests: XCTestCase {
	func testTwoPlusTwoIsFour() {
		XCTAssertEqual(2 + 2, 4)
	}
}

final class DoublyLinkedListTests: XCTestCase {
	func test_isEmpty_shouldBeTrue() {
		let sut = DoublyLinkedList<Any>()

		let result = sut.isEmpty

		XCTAssertTrue(result)
	}

	func test_isEmpty_shouldBeFalse() {
		let sut = DoublyLinkedList(value: 1)

		let result = sut.isEmpty

		XCTAssertFalse(result)
	}
}
