import ballerina/io;

public function main() {
    int RED = 0x0000FF;
    int GREEN = 0x00FF00;
    int BLUE = 0xFF0000;

    int rgbValue = 0xAEFF01;
    int red_component = rgbValue & RED;
    int green_component = (rgbValue & GREEN) >> 8;
    int blue_component = (rgbValue & BLUE) >> 16;
    
    io:println("R: ", red_component);
    io:println("G: ", green_component);
    io:println("B: ", blue_component);
}
