# MarkdownPackage

Пакет предоставляет сервис для парсинга md файлов

#  Регулярные выражения для конвертации

- `(#{1,6})\s+(.+)` -- Определение заголовков
- `^([^#>-].*)` -- Проверка на то что у нас текст
- `\*\*\*(.+?)\*\*\*` -- Жирный и наклонный текст
- `\`(.+?)\`` -- Встроенный в текст код
- `^>\s+(.+)` -- Цитата
- `[^!]\[([^\\]+?)\]\(([^\\]+?)\)` -- Ссылка
- `!\[([^\\]+?)\]\(([^\\]+?)\)` -- Картинка
- `^\d+\.\s+(.+)` -- Нумерованный список
- `^-\s+(.+)` -- Маркированный список