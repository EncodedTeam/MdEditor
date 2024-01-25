xcodebuild test-without-building \
    -quiet \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditorUITests' \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 14 Pro'
