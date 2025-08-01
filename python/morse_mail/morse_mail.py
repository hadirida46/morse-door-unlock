import smtplib
from email.mime.text import MIMEText
import serial
import time

def send_mail(subject, body, to_email):
    from_email = "hadirida46@gmail.com"
    password = "app password"

    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
        smtp.login(from_email, password)
        smtp.send_message(msg)
        print("Email sent!")

arduino = serial.Serial('/dev/ttyUSB0', 9600) 
time.sleep(2)

print("Listening to Arduino...")

while True:
    if arduino.in_waiting > 0:
        line = arduino.readline().decode().strip()
        print("Received from Arduino:", line)

        if line.startswith("ENTERED:"):
            name = line.split(":")[1].strip()
            subject = "Door Access"
            body = f"{name} entered the house!"
            send_mail(subject, body, "hadirida46@gmail.com")

