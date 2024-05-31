ifeq ($(shell uname), Linux)
WAIT = read -p "Press return key to close..."
else
WAIT = read -p "Press return key to close..."
endif


install:
	cd ~/raven-project/raven-godot/ && ./gradlew build
	cd ~/raven-project/raven-core && mvn compile && mvn package
	cd ~/raven-project/raven-protocol && mvn install
	cd ~/raven-project/raven-protocol && mvn compile && mvn package
	cd ~/raven-project/raven-core && mvn install



