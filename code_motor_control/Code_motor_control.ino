#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Servo.h>

//code qui run sur une ESP8266, avec la librairie Servo.h. J'utilise des servo moteurs

Servo s1, s2, s3;

// Définition des nouvelles broches sécurisées
const int pinS1 = 4;  // Correspond à D2 sur la carte
const int pinS2 = 14;  // Correspond à D5 sur la carte
const int pinS3 = 12; // Correspond à D6 sur la carte

ESP8266WebServer server(80);

// Code HTML de la page web envoyée au smartphone
const char HTML_INTERFACE[] PROGMEM = R"=====(
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Lattice Gripper Control</title>
  <style>
    body { font-family: 'Arial', sans-serif; text-align: center; background: #f4f4f9; padding: 20px; }
    h1 { color: #333; }
    .card { background: white; padding: 20px; margin: 15px auto; max-width: 400px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    .slider { width: 100%; margin: 15px 0; height: 15px; border-radius: 5px; background: #ddd; outline: none; }
    span { font-weight: bold; color: #007bff; font-size: 1.2em; }
  </style>
</head>
<body>
  <h1>Multi-DoF Gripper Wi-Fi</h1>
  
  <div class="card">
    <h3>Moteur 1: <span id="val1">0</span>°</h3>
    <input type="range" min="0" max="270" value="0" class="slider" onchange="sendCmd(1, this.value)" oninput="document.getElementById('val1').innerText=this.value">
  </div>
  
  <div class="card">
    <h3>Moteur 2: <span id="val2">0</span>°</h3>
    <input type="range" min="0" max="270" value="0" class="slider" onchange="sendCmd(2, this.value)" oninput="document.getElementById('val2').innerText=this.value">
  </div>
  
  <div class="card">
    <h3>Moteur 3: <span id="val3">0</span>°</h3>
    <input type="range" min="0" max="270" value="0" class="slider" onchange="sendCmd(3, this.value)" oninput="document.getElementById('val3').innerText=this.value">
  </div>

  <script>
    function sendCmd(motor, angle) {
      fetch('/set?m=' + motor + '&a=' + angle);
    }
  </script>
</body>
</html>
)=====";

void handleRoot() {
  server.send(200, "text/html", HTML_INTERFACE);
}

void handleSet() {
  if (server.hasArg("m") && server.hasArg("a")) {
    int moteur = server.arg("m").toInt();
    int angle = server.arg("a").toInt();
    
    //range 0° to 270°
    int pulse = map(constrain(angle, 0, 270), 0, 270, 500, 2500);
    
    if (moteur == 1) s1.writeMicroseconds(pulse);
    else if (moteur == 2) s2.writeMicroseconds(pulse);
    else if (moteur == 3) s3.writeMicroseconds(pulse);
    
    server.send(200, "text/plain", "OK");
  } else {
    server.send(400, "text/plain", "Requete invalide");
  }
}

void setup() {
  Serial.begin(115200);
  
  s1.attach(pinS1, 500, 2500);
  s2.attach(pinS2, 500, 2500);
  s3.attach(pinS3, 500, 2500);
  
  // Initialisation: 0°
  s1.writeMicroseconds(500);
  s2.writeMicroseconds(500);
  s3.writeMicroseconds(500);

  // Creation Wi-Fi : MDP = "epfl2026"
  WiFi.softAP("Gripper-WiFi", "epfl2026");
  
  // Routes - serveur Web
  server.on("/", handleRoot);
  server.on("/set", handleSet);
  
  server.begin();
  Serial.println("Serveur pret ! Connectez-vous au reseau 'Gripper-WiFi'");
}

void loop() {
  server.handleClient(); // phone request
}