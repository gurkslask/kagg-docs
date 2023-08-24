from tkinter import *
from tkinter import ttk
import ser

def sending(*args):
    try:
        value = str(message.get())
        ser.send_var(value)
    except ValueError:
        pass

def read(*args):
    if connected.get():
        bres = bytes()
        bres = ser.read()
        res = bres
        print(res)
        if res == "No data":
            pass
        else:
            result.set(res)
    root.after(1000, read)

def open_port():
    ser.open_port(COM.get())
    connected.set(True)

root = Tk()
root.title("Serial sender")

mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
root.columnconfigure(0, weight=1)
root.rowconfigure(0, weight=1)

message = StringVar()
message_entry = ttk.Entry(mainframe, width=7, textvariable=message)
message_entry.grid(column=2, row=1, sticky=(W, E))


ttk.Button(mainframe, text="Skicka A", command=ser.send_A).grid(column=3, row=3, sticky=W)
ttk.Button(mainframe, text="Skicka B", command=ser.send_B).grid(column=3, row=4, sticky=W)
ttk.Button(mainframe, text="Skicka text", command=sending).grid(column=3, row=1, sticky=W)

ttk.Label(mainframe, text="Message").grid(column=0, row=1, sticky=W)

lista = ser.list_ports()
COM = StringVar()
connected = BooleanVar()

ttk.OptionMenu(mainframe, COM, lista[0],*lista).grid(column=3, row=6, sticky=W)
ttk.Label(mainframe, textvariable=COM).grid(column=0, row=6, sticky=W)
ttk.Button(mainframe, text="Connect", command=open_port).grid(column=3, row=7)


result = StringVar()
resultfield = ttk.Entry(mainframe, width=30,  textvariable=result)
resultfield.grid(column=0, columnspan=4, row=8, sticky=(W, E))

for child in mainframe.winfo_children():
    child.grid_configure(padx=5, pady=5)

message_entry.focus()
root.bind("<Return>", sending)
root.after(1, read)

root.mainloop()
