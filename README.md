# Morse Code Door Unlock System 🔐

This project allows you to unlock a door by entering a specific name or code in **Morse code**. For added security and monitoring, the system sends an automated email notification every time the door is successfully unlocked.

## 📺 Project Presentation
Watch or download the full project demonstration here:
[**Download Video Presentation**](https://github.com/hadirida46/morse-door-unlock/blob/main/Video%20Project%20Presentation.mp4)

---

## 🔧 Components

### Arduino Sketches
* **`morse_reader`**: Interprets button presses as Morse code (dots and dashes) and displays the corresponding letters on an LCD.
* **`morse_unlock`**: Compares the entered Morse sequence against a stored "password." If it matches, the servo motor triggers the unlock mechanism.

### Python Script
* **`send_mail.py`**: A backend script that listens for a signal from the Arduino and uses the `smtplib` library to send a notification email.

---

## 🧰 Tech Used

* **Hardware**: Arduino Uno, LCD (16x2), Push Button, Servo Motor, Buzzer, LED.
* **Software**: Arduino IDE (C++), Python `smtplib`.
