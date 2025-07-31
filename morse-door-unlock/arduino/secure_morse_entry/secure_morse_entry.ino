#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

const int buttonPin = 8;
const int buzzerPin = 7;
const int servoPin = 6;
const int ledPin = 2; 

unsigned long pressStart = 0;
bool isPressing = false;
String morseChar = "";
String translatedText = "";
unsigned long lastReleaseTime = 0;

Servo doorServo;

String morseCodes[] = {
  ".-", "-...", "-.-.", "-..", ".", "..-.", "--.",
  "....", "..", ".---", "-.-", ".-..", "--", "-.",
  "---", ".--.", "--.-", ".-.", "...", "-", "..-",
  "...-", ".--", "-..-", "-.--", "--.."
};

char alphabet[] = {
  'A', 'B', 'C', 'D', 'E', 'F', 'G',
  'H', 'I', 'J', 'K', 'L', 'M', 'N',
  'O', 'P', 'Q', 'R', 'S', 'T', 'U',
  'V', 'W', 'X', 'Y', 'Z'
};

String allowedNames[10] = {};
int allowedCount = 0;
bool isAddMode = false;

void setup() {
  Serial.begin(9600);
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(buzzerPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  doorServo.attach(servoPin);
  doorServo.write(0);

  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("Morse Ready...");
}

void loop() {
  int buttonState = digitalRead(buttonPin);
  unsigned long currentMillis = millis();

  if (buttonState == LOW && !isPressing) {
    delay(10);
    if (digitalRead(buttonPin) == LOW) {
      isPressing = true;
      pressStart = currentMillis;
      tone(buzzerPin, 1000);
    }
  }

  if (buttonState == HIGH && isPressing) {
    isPressing = false;
    noTone(buzzerPin);
    unsigned long pressDuration = currentMillis - pressStart;
    if (pressDuration < 30) return;

    morseChar += (pressDuration < 300) ? "." : "-";
    lcd.setCursor(0, 1);
    lcd.print("                ");
    lcd.setCursor(0, 1);
    lcd.print(morseChar);
    lastReleaseTime = currentMillis;
  }

  if (!isPressing && morseChar.length() > 0 && currentMillis - lastReleaseTime > 500) {
    char letter = decodeMorse(morseChar);
    translatedText += letter;
    morseChar = "";

    lcd.setCursor(0, 1);
    lcd.print("                ");
    lcd.setCursor(0, 0);
    lcd.print("                ");
    lcd.setCursor(0, 0);
    lcd.print(translatedText);
  }

  if (!isPressing && morseChar.length() == 0 && translatedText.length() > 0 && currentMillis - lastReleaseTime > 2000) {
    if (translatedText[translatedText.length() - 1] != ' ') {
      checkAccess();
      translatedText = "";
    }
  }
}

char decodeMorse(String code) {
  for (int i = 0; i < 26; i++) {
    if (morseCodes[i] == code) return alphabet[i];
  }
  return '?';
}

void checkAccess() {
  if (translatedText == "ADD") {
    isAddMode = true;
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Enter Name:");
    return;
  }

  if (isAddMode) {
    addAllowedName(translatedText);
    isAddMode = false;
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Name Added!");
    delay(2000);
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Morse Ready...");
    return;
  }

  for (int i = 0; i < allowedCount; i++) {
    if (translatedText == allowedNames[i]) {
      unlockDoor(translatedText);
      return;
    }
  }

  denyAccess();
}

void addAllowedName(String name) {
  if (allowedCount < 10) {
    allowedNames[allowedCount] = name;
    allowedCount++;
  } else {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("List Full!");
    delay(2000);
  }
}

void unlockDoor(String name) {

  Serial.print("ENTERED:");
  Serial.println(name);

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Welcome ");
  lcd.print(name);
  playWelcomeMelody();
  doorServo.write(90);
  delay(3000);
  doorServo.write(0);
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Morse Ready...");
}

void denyAccess() {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Access Denied!");
  delay(2000);
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Morse Ready...");
}

void playWelcomeMelody() {
  digitalWrite(ledPin, HIGH);
  tone(buzzerPin, 1000, 200);
  delay(250);
  tone(buzzerPin, 1500, 200);
  delay(250);
  tone(buzzerPin, 2000, 300);
  delay(300);
  noTone(buzzerPin);
  digitalWrite(ledPin, LOW);  
}