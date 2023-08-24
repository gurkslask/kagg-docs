import serial
import time
import serial.tools.list_ports


# Ställ inställningar för COM-porten
ports = serial.tools.list_ports.comports()
# Skapa seriell port objektet
ser = serial.Serial(
    baudrate=9600,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS
)

def open_port(port):
    # Ställ in rätt COM port och öppna
    ser.port = port
    ser.open()
    # Kolla så porten är öppen
    ser.isOpen()
    print("Port is open")

def close_port():
    # Stäng porten när färdig
    ser.close()


def send_A():
    # Tecken som vi ska skicka
    tecken = 'A'
    # Gör om tecknet till ASCII
    tecken = tecken.encode('raw_unicode_escape')
    print("Skickar detta till serieporten: " + str(tecken))

    # Skriv tecknet som ASCII till COM porten
    ser.write(tecken)

def send_B():
    # Tecken som vi ska skicka
    tecken = 'B'
    # Gör om tecknet till ASCII
    tecken = tecken.encode('raw_unicode_escape')
    print("Skickar detta till serieporten: " + str(tecken))
    # Skriv tecknet som ASCII till COM porten
    ser.write(tecken)

def send_var(text):
    # Skicka egen text
    tecken = text
    # Gör om tecknet till ASCII
    tecken = tecken.encode('raw_unicode_escape')
    print("Skickar detta till serieporten: " + str(tecken))
    # Skriv tecknet som ASCII till COM porten
    ser.write(tecken)

def read() -> str:
    # Läs datan som är på COM-porten
    # Om ingen data skicka No data
    if ser.inWaiting() > 0 :
        # res = ser.read(1)
        res = ser.read_all()
        print("Here are the data at the port")
        print(res)
        return res

    else:
        print("No data to read")
        return "No data"

def list_ports() -> list:
    # Skapa en lista med COM portar, ta endast med namnet på porten
    # och dumpa beskrivningen
    ports = serial.tools.list_ports.comports()
    ports= [p.device for p in ports]
    return ports


if __name__ == '__main__':
    open_port()
    send_A()
    read()
    close_port()


