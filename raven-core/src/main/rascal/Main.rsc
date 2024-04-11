module Main
import IO;
import Location;
import util::Benchmark;


void listener(LocationChangeEvent event) {
    println(event);
        println("Change triggered from Godot Side");
        println(systemTime());
}



void main(loc fileLoc) {
    watch(fileLoc, true,listener);
}