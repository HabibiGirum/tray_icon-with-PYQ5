import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import QTimer, QDateTime,Qt
import PyQt5.QtCore  # Import QtCore separately
import subprocess
import requests
import json

class VistarSyncApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.query_data = {
            "SELECT REPLACE(CONCAT(hostname, '-', uuid), '-', '_') AS uniqueId FROM system_info;": "uniqueId",

        }
        # self.setWindowFlags(PyQt5.QtCore.Qt.Window | PyQt5.QtCore.Qt.CustomizeWindowHint | PyQt5.QtCore.Qt.WindowTitleHint)  # Corrected the usage of QtCore
        self.setWindowFlags(self.windowFlags() & ~Qt.WindowMinMaxButtonsHint)

        self.endpoint_Api= "https:/api/v1/computers/osquery_log_data/"
        self.interval_seconds = 60
        self.last_sync_time = None
        self.sync_active = False
        self.create_UI()

    def create_UI(self):
        self.setStyleSheet("QMainWindow::title { background-color: black; color: white; border: 20px solid gray; font-size: 20px; }")

        self.setWindowTitle("Vistar MDM . . .")
        self.setGeometry(1300, 700, 250, 0)

        # Set the application icon
        self.setWindowIcon(QIcon("C:/Users/habta/Documents/vistar/images/vistar.ico"))
        # Create a QLabel for the image
        central_widget = QWidget(self)
        self.setCentralWidget(central_widget)


        layout = QVBoxLayout()

        # Load toggle images
        self.start_image = QPixmap("C:/Users/habta/Documents/vistar/images/toggle_off.png")
        self.stop_image = QPixmap("C:/Users/habta/Documents/vistar/images/toggle_on.png")

        # Create a QLabel for the image
        image_label = QLabel(self)
        image_label.setPixmap(QPixmap("C:/Users/habta/Documents/vistar/images/vistar.ico"))  # Replace with your image path
        image_label.setAlignment(Qt.AlignCenter)
        layout.addWidget(image_label)

        # Create a QLabel for the text
        text_label = QLabel("Sync Your Data!", self)
        text_label.setAlignment(Qt.AlignCenter)
        layout.addWidget(text_label)
        
        # Create the toggle button with the start image
        self.toggle_button = QPushButton(self)
        self.toggle_button.setIcon(QIcon(self.start_image))
        self.toggle_button.clicked.connect(self.on_toggle)
        layout.addWidget(self.toggle_button)

        central_widget.setLayout(layout)

        # Adding style to the button for better visualization
        button_style = """
                QPushButton {
                background-color: #3498db;
                color: white;
                border: 1px solid #2980b9;
                border-radius: 5px;
                padding: 5px;
                font-size: 14px;
                width: auto;  
            }

            QPushButton:hover {
                background-color: #2980b9;
            }

            QPushButton:pressed {
                background-color: #21618c;
            }
        """
        self.toggle_button.setStyleSheet(button_style)



        # exit_button= QPushButton("Exit", self)
        # exit_button.clicked.connect(self.on_exit)
        # exit_button.setGeometry(10,60, 100,32)
        # exit_button.setStyleSheet(button_style)
        self.update_toggle_button_label()

        self.sync_timer = QTimer(self)
        self.sync_timer.timeout.connect(self.sync_data)
        self.sync_timer.start(self.interval_seconds*1000)
        # self.isMaximized()==False
        # self.move()==False
    def on_toggle(self):
        self.sync_active = not self.sync_active

        if self.sync_active:
            self.last_sync_time = QDateTime.currentDateTime()
            self.sync_data()
        self.update_toggle_button_label()

    def sync_data(self):
        current_time =QDateTime.currentDateTime()
        if self.last_sync_time is None:
            self.last_sync_time = current_time
            osquery_data = self.run_osquery_and_send_data()
            self.send_data_to_api(osquery_data)

        elapsed_time = (current_time.toSecsSinceEpoch() - self.last_sync_time.toSecsSinceEpoch())

        if elapsed_time >= self.interval_seconds and self.sync_active:
            osquery_data = self.run_osquery_and_send_data()
            slef.send_data_to_api(osquery_data)
            self.last_sync_time = current_time

        if self.sync_active:
            self.sync_timer.start(self.interval_seconds *1000)

    def send_data_to_api(self, data):
        try:
            headers= {"Content-Type": "application/json"}
            response = requests.post(self.endpoint_Api, json=data,headers=headers)

            if response.status_code == 201:
                print(f"Data sent successfully. status code :{response.status_code}")
            else:
                print(f"faild to send data. status code : {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(f'Error sending data : {e}')

    def run_osquery_and_send_data(self):
        all_osquery_data = {}
        for query,simplified_name in self.query_data.items():
            try:
                osquery_output = subprocess.check_output(["C:/Program Files/osquery/osqueryi.exe", "--json", query], shell=True)
                osquery_data = json.loads(osquery_output.decode())
                all_osquery_data[simplified_name] = osquery_data
            except subprocess.CalledProcessError as e:
                logging.error(f"Error running osquery for query '{query}': {e}")
            except Exception as e:
                logging.error(f"Error processing query '{query}': {e}")

        return all_osquery_data
    def update_toggle_button_label(self):
        label = "Stop Sync." if self.sync_active else "Start Sync"
        self.toggle_button.setText(label)

        if self.sync_active:
            self.toggle_button.setIcon(QIcon(self.stop_image))
        else:
            self.toggle_button.setIcon(QIcon(self.start_image))
    def on_exit(self):
        sys.exit()
    def show_window(self):
        if self.isVisible():
            toggle_app_action.setText("close")
            self.hide
        else:
            toggle_app_action.setText("open")
            self.showNormal() 
if __name__ == '__main__':
    app = QApplication(sys.argv)
    app.setQuitOnLastWindowClosed(False)
    osquery_app = VistarSyncApp()

    icon = QIcon("./images/vistar.ico")

    # Adding item on the menu bar
    tray = QSystemTrayIcon(icon)
    tray.setVisible(True)

    # Creating the options
    menu = QMenu()
    

    # Creating an instance of OsquerySyncApp

    # To open or close OsquerySyncApp when the system tray icon is clicked
    toggle_app_action = QAction("Open Application")
    toggle_app_action.triggered.connect(osquery_app.show_window)
    menu.addAction(toggle_app_action)

    # To quit the app
    quit = QAction("Quit")
    quit.triggered.connect(osquery_app.on_exit)
    menu.addAction(quit)

    # Adding options to the system tray
    tray.setContextMenu(menu)

    osquery_app.show()

    sys.exit(app.exec_())