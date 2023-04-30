all: clean build web.zip

clean:
	rm -rf build

build:
	mkdir -p build/web
	godot --export-release "Web" ../build/web/index.html project/project.godot

web.zip: build
	cd build/web; zip ../web.zip *

