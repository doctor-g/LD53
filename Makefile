all: clean build web.zip windows linux

clean:
	rm -rf build

build:
	mkdir -p build/web
	godot --export-release "Web" ../build/web/index.html project/project.godot

web.zip: build
	cd build/web; zip ../web.zip *

windows:
	mkdir -p build/windows
	godot --export-release "Windows Desktop" ../build/windows/MrDeliveryMan.exe project/project.godot

linux:
	mkdir -p build/linux
	godot --export-release "Linux/X11" ../build/linux/MrDeliveryMan.x86_64 project/project.godot
