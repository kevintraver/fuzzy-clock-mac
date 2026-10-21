APP := Fuzzy Clock.app
BUILT := build/Build/Products/Release/$(APP)

.PHONY: generate build test install clean

generate:
	xcodegen generate

build: generate
	xcodebuild -project FuzzyClock.xcodeproj -scheme FuzzyClock -configuration Release -derivedDataPath build build

test: generate
	xcodebuild -project FuzzyClock.xcodeproj -scheme FuzzyClock -derivedDataPath build test

install: build
	-pkill -x "Fuzzy Clock"
	rm -rf "/Applications/$(APP)"
	cp -R "$(BUILT)" /Applications/
	open "/Applications/$(APP)"

clean:
	rm -rf build FuzzyClock.xcodeproj
