int rxdata = 0;  // Declare rxdata  (or int if you need to handle -1 for errors)

void setup() {
  Serial.begin(9600); // Initialize Serial communication
}

void loop() {
  if (Serial.available() > 0) { // Check if data is available
    rxdata = Serial.read();    // Read the incoming byte
    Serial.print("Received: "); // Print a label (note the correct spelling)
    
    if (rxdata == -1) {         // Handle potential error (if using int for rxdata)
      Serial.println("Error reading");
    } else {
      Serial.println(rxdata);    // Print the received data
    }
    
  }
}