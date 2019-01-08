
build:
	swift build

release:
	swift build -c release -Xswiftc -static-stdlib

run:
	swift run

clean:
	rm -rf .build

test:
	vapor test

edit:
	vim Package.swift

xcode:
	swift package generate-xcodeproj --xcconfig-overrides Package.xcconfig

update:
	swift package update

