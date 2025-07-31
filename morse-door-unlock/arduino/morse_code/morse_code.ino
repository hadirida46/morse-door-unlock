#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// LCD setup
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Pins
const int buttonPin = 8;
const int buzzerPin = 7;

unsigned long pressStart = 0;
bool isPressing = false;
String morseChar = "";
String translatedText = "";
unsigned long lastReleaseTime = 0;

// Morse dictionary
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

void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(buzzerPin, OUTPUT);
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("Morse Ready...");
}

void loop() {
  int buttonState = digitalRead(buttonPin);
  unsigned long currentMillis = millis();

  // When button is pressed
  if (buttonState == LOW && !isPressing) {
    delay(10); // Debounce
    if (digitalRead(buttonPin) == LOW) {
      isPressing = true;
      pressStart = currentMillis;
      tone(buzzerPin, 1000);
    }
  }

  // When button is released
  if (buttonState == HIGH && isPressing) {
    isPressing = false;
    noTone(buzzerPin);
    unsigned long pressDuration = currentMillis - pressStart;

    // Ignore very short presses (<30ms)
    if (pressDuration < 30) return;

    if (pressDuration < 300) {
      morseChar += ".";
    } else {
      morseChar += "-";
    }

    // Show current Morse character on line 2
    lcd.setCursor(0, 1);
    lcd.print("                ");
    lcd.setCursor(0, 1);
    lcd.print(morseChar);

    lastReleaseTime = currentMillis;
  }

  // Handle end of letter
  if (!isPressing && morseChar.length() > 0 && currentMillis - lastReleaseTime > 700) {
    char letter = decodeMorse(morseChar);
    translatedText += letter;
    morseChar = "";

    // Clear line 2
    lcd.setCursor(0, 1);
    lcd.print("                ");

    // Update line 1 with translated text
    lcd.setCursor(0, 0);
    lcd.print("                ");
    lcd.setCursor(0, 0);
    lcd.print(translatedText);
  }

  // Handle word spacing if long pause and no current Morse char
  if (!isPressing && morseChar.length() == 0 &&
      translatedText.length() > 0 && currentMillis - lastReleaseTime > 1500) {
    // Add space only if last character isn't already a space
    if (translatedText[translatedText.length() - 1] != ' ') {
      translatedText += ' ';
      lcd.setCursor(0, 0);
      lcd.print("                ");
      lcd.setCursor(0, 0);
      lcd.print(translatedText);
    }
  }
}

// Convert Morse string to alphabet letter
char decodeMorse(String code) {
  for (int i = 0; i < 26; i++) {
    if (morseCodes[i] == code) {
      return alphabet[i];
    }
  }
  return '?'; // Unknown code
}
