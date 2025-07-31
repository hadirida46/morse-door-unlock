# Morse Code Door Unlock System 🔐

This project lets you unlock a door using Morse code, with the added feature of email notifications.

## 🔧 Components

- **Arduino Sketches**
  - `morse_reader`: Reads Morse input and displays letters
  - `morse_unlock`: Unlocks a door if a correct Morse name is entered

- **Python Script**
  - `send_mail.py`: Sends an email when someone unlocks the door

## 🧰 Tech Used

- Arduino Uno (LCD, Push Button, Servo Motor, Buzzer, LED)
- Python (with `smtplib` or similar)
