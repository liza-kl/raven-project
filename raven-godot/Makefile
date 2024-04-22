ifeq ($(shell uname), Linux)
WAIT = read -p "Press return key to close..."
else
WAIT = read "Press return key to close..."
endif

godot = "/Applications/Godot.app/Contents/MacOS/Godot"
build:
	./gradlew build

run.debug:
	$(godot) --jvm-debug-port=5005 --wait-for-debugger=true

run:
	$(godot)
