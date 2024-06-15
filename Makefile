ifeq ($(shell uname), Linux)
WAIT = read -p "Press return key to close..."
else
WAIT = read -p "Press return key to close..."
endif

setup:
	cd ~/raven-project/raven-godot && ./gradlew build
	cd ~/raven-project/raven-rascal-example/raven-core && mvn compile
	cd ~/raven-project/raven-rascal-example/raven-protocol && mvn install
	cd ~/raven-project/raven-rascal-example/raven-protocol && mvn compile && mvn package
	cd ~/raven-project/raven-rascal-example/raven-core && mvn install

run.server:
	cd ~/raven-project/raven-godot && make run.server

run.godot:
	cd ~/raven-project/raven-godot && make run.godot


run.rascal:
	cd ~/raven-project/raven-godot && make run

stop:
	cd ~/raven-project/raven-godot && make stop
