from PyQt5.QtWidgets import *  
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import *
from PyQt5 import uic
import sys

class Ui(QMainWindow):
    def __init__(self):
        super(Ui, self).__init__()
        uic.loadUi("C:\\Users\\SamuelYoung\\Desktop\\Title_Screen.ui", self)
        self.Space.keyPressEvent= self.keyPressEvent
        self.show()
        
    def keyPressEvent(self, e):
        while True:
            if e.key() == Qt.Key_Space:
                break

app = QApplication(sys.argv)
window = Ui()
app.exec_()
from main import *        