xcodebuild test-without-building \
    -quiet \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditorTests' \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 14 Pro'
