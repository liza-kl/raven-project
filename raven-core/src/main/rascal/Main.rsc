module Main
import IO;
import Location;

void listener(LocationChangeEvent event) {
    println(event);
        println("something happened");
}

void main(loc fileLoc) {
    watch(fileLoc, true,listener);
}