ifeq ($(shell uname), Linux)
WAIT = read -p "Press return key to close..."
else
WAIT = read -p "Press return key to close..."
endif

godot = "/Applications/Godot.app/Contents/MacOS/Godot"

build.project:
	~/raven-project/raven-godot/gradlew build


run.godot:
	$(godot)

run.debug:
	$(godot) --jvm-debug-port=5005 --wait-for-debugger=true

run.server:
	java -jar ../raven-protocol/target/raven-protocol-1.0-SNAPSHOT.jar

run:
	tmux new-session -d -s raven-session -n "Java" java -jar ../raven-protocol/target/raven-protocol-1.0-SNAPSHOT.jar \; \
		new-window -n "Godot" $(godot)

stop:
	tmux send-keys -t raven-session C-c
	tmux kill-session -t raven-session
