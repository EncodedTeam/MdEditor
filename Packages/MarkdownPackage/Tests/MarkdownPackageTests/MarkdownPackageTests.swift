import XCTest
@testable import MarkdownPackage

final class MarkdownPackageTests: XCTestCase {
	func test_tokenize_shouldReturnElements() {
		let sut = Lexer()

		let tokens = sut.tokenize(TestingData.mdText)
		let document = Parser().parse(tokens: tokens)

		print("-------------------------")
		print("Tokens:")
		print(tokens.count)
		print("-------------------------")
		print("Documents:")
		print(document.children)
		print("-------------------------")
	}
}

private extension MarkdownPackageTests {
	enum TestingData {
		static let mdText = """
		# Regexp
		______________
		## Квантификаторы

		###  Подзаголовок **3 уровня**

		> Цитата! **жирный тект** цитаты!

		**Это** -- **жирный тект**

		Это ссылка:
		[Yandex](https://yandex.ru)

		С помощью квантификаторов мы можем указывать сколько раз должен повторяться тот или иной символ (ну или группа символов).

		- **{n}** - символ повторяется ровно n раз
		- **{m,n}** - символ повторяется в диапазоне от m до n раз
		- **{m,}** - символ повторяется минимум m раз (от m и более)

		```md
		1. **{n}** - символ повторяется ровно n раз
		2. **{m,n}** - символ повторяется в диапазоне от m до n раз
		3. **{m,}** - символ повторяется минимум m раз (от m и более)
		## Lookahead и lookbehind **(опережающая и ретроспективная** проверки)
		```

			1. **{n}** - символ повторяется ровно n раз
			2. **{m,n}** - символ повторяется в диапазоне от m до n раз
			3. **{m,}** - символ повторяется минимум m раз (от m и более)

		## Lookahead и lookbehind (опережающая и ретроспективная проверки)
			- **lookahead** - опережающая проверка - `X(?=Y)` - найти Х, при условии, что после него идет Y
			- *негативная опрережающая проверка* - `Х(?!Y)`
			- **lookbehind** - ретроспективная проверка - `(?<=Y)X` - найти Х, при условии, что до него идет Y
			- ***негативная ретроспективная проверка*** - `(?<!Y)Xo`
		___
		ссылка: [SwiftBook](https://swiftbook.org) картинка ![SwiftBook](https://swiftbook.org)

		ntcn **{n}** - символ по**вто**ряется ровно n ***раз*** user:name@*domen.ru.net*
		"""
	}
}
