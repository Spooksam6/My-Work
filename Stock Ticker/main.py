from PyQt5.QtWidgets import *  
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import *
from PyQt5 import uic
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg
from matplotlib.figure import Figure
import sys
import pandas as pd
import matplotlib.pyplot as plt
from random import *
global Grain_Stock
global Oil_Stock
global Bonds_Stock
global Industry_Stock
global Silver_Stock
global Gold_Stock
global reg0
global Player
global row
global col
global click
global CrawlerText
times=[1]
Grain_Stock=[1.0]
Oil_Stock=[1.0]
Bonds_Stock=[1.0]
Industry_Stock=[1.0]
Silver_Stock=[1.0]
Gold_Stock=[1.0]
Player=[]
reg0 = {
    'Grain': Grain_Stock,
    'Oil': Oil_Stock,
    'Bonds': Bonds_Stock,
    'Industry': Industry_Stock,
    'Silver': Silver_Stock,
    'Gold': Gold_Stock,
}
for x in range(0,8):
    Player.append(input('Name of Player'))
class MplCanvas(FigureCanvasQTAgg):
    def __init__(self, parent=None, width=5, height=4, dpi=100, **kwargs):
        fig = Figure(figsize=(width, height), dpi=dpi, **kwargs)
        self.axes = fig.add_subplot(111)
        super().__init__(fig)
class TableModel(QtCore.QAbstractTableModel):
    def __init__(self, data):
        super().__init__()
        self._data = data
    def data(self, index, role):
         if role == Qt.DisplayRole:
              value = self._data.iloc[index.row(), index.column()]
              return str(value)
         elif role == Qt.TextAlignmentRole:
             return Qt.AlignCenter
         if role == Qt.BackgroundRole and index.column() == 1:
              return QtGui.QColor(QColor(52,98,150))
          
         if role == Qt.BackgroundRole and index.column() == 2:
               return QtGui.QColor(Qt.red)
           
         if role == Qt.BackgroundRole and index.column() == 6:
               return QtGui.QColor(Qt.green)
           
         if role == Qt.BackgroundRole and index.column() == 5:
               return QtGui.QColor(Qt.darkGray)
           
         if role == Qt.BackgroundRole and index.column() == 0:
               return QtGui.QColor(Qt.yellow)
           
         if role == Qt.BackgroundRole and index.column() == 4:
               return QtGui.QColor(Qt.lightGray)
           
         if role == Qt.BackgroundRole and index.column() == 3:
               return QtGui.QColor(Qt.darkYellow)
         

    def rowCount(self, index):
        return self._data.shape[0]
    def columnCount(self, index):
        return self._data.shape[1]
    def headerData(self, section, orientation, role):
        if role == Qt.DisplayRole:
            if orientation == Qt.Horizontal:
                return str(self._data.columns[section]) 
            if orientation == Qt.Vertical:
                return str(self._data.index[section])

class Ui(QMainWindow):
    def __init__(self):
        super(Ui, self).__init__()
        uic.loadUi("C:\\Users\\SamuelYoung\\Desktop\\ST_.ui", self)
        self.flag=False
        self.table = self.Game_Info
        self.graph_widget = MplCanvas(self, width=5, height=4, dpi=100)
        self.Display.addWidget(self.graph_widget, 0, 1, 1, 1)
        self.CrawlerText=''
        self.setWindowIcon(QtGui.QIcon("C:\\Users\\SamuelYoung\\Desktop\\ST_Icon.png"))
        self.FutureMarket.stateChanged.connect(self.show_state)
        self.timer = QTimer()
        self.timer.setInterval(50)
        global df
        global data
        data = pd.DataFrame(
            [
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000],
                [0,0,0,0,0,0,5000]
                ],
            columns=["Grain", "Bonds", "Industry","Gold","Silver","Oil","Money"],
            index=Player,
            )
        df= pd.DataFrame(
               [
                   [100],
                   [100],
                   [100],
                   [100],
                   [100],
                   [100],
                   ],
               columns=["price"],
               index=["Grain", "Bonds", "Industry","Gold","Silver","Oil"],
               )
        self.Market_Start.setCheckable(True)
        self.model = TableModel(data) 
        self.table.setModel(self.model)
        self.timer.timeout.connect(self.ticker)
        self.Game_Info.keyPressEvent= self.keyPressEvent
        self.Game_Info.clicked.connect(self.cords)
        self.Market_Start.clicked.connect(self.start_market)
        self.Market_Stop.clicked.connect(self.stop_market)      
        self.show()
    def show_state(self, s):
        if s == 0:
            self.flag= False
        else:
            self.flag=True
        print(s)
            
    def cords(self,item):
        self.selected_row = item.row()
        self.selected_col = item.column()
    def keyPressEvent(self, e):
         if e.key() == Qt.Key_W :
             print('W')
         if e.key()  == Qt.Key_Equal :
             if self.selected_col ==6:
                 return
             if data['Money'][data.index[self.selected_row]] >= ((int(df['price']['Grain']) / 100) * 500):
                 data.iat[self.selected_row, self.selected_col] += 500
                 data['Money'][data.index[self.selected_row]] -= ((int(df['price'][self.selected_col])/ 100) * 500)
                 self.model.layoutChanged.emit()
         elif e.key() == Qt.Key_Minus :
             if self.selected_col ==6:
                 return
             if self.flag== False:
                if data.iat[self.selected_row,self.selected_col]>0:
                    data.iat[self.selected_row, self.selected_col] -= 500
                    data['Money'][data.index[self.selected_row]] += ((int(df['price'][self.selected_col])/ 100) * 500)
                    self.model.layoutChanged.emit()
             else:
                 data.iat[self.selected_row, self.selected_col] -= 500
                 data['Money'][data.index[self.selected_row]] += ((int(df['price'][self.selected_col])/ 100) * 500)
                 self.model.layoutChanged.emit()
                 
    def start_market(self):
        self.CrawlerText+='                                        The Market Has Opened'
        self.timer.start()
    def stop_market(self):
        self.timer.stop()
        self.GrainButton.setText('Grain Price: '+str(int(df['price']['Grain'])/100))
        self.GoldButton.setText('Gold Price: '+str(int(df['price']['Gold'])/100))
        self.OilButton.setText('Oil Price: '+str(int(df['price']['Oil'])/100))
        self.IndustryButton.setText('Indusry Price: '+str(int(df['price']['Industry'])/100))
        self.BondsButton.setText('Bonds Price: '+str(int(df['price']['Bonds'])/100))
        self.SilverButton.setText('Sliver Price: '+str(int(df['price']['Silver'])/100))
        stock_values = data[['Grain', 'Bonds', 'Industry', 'Gold', 'Silver', 'Oil']].multiply((df['price'].values)/100, axis=1)

    # Calculate net worth by summing up money and the value of stocks
        data['NetWorth'] = data['Money'] + stock_values.sum(axis=1) 

    # Sort data by the "NetWorth" column in descending order
        
        data.sort_values(by=['NetWorth'], ascending=False, inplace=True)
        

    # Update the displayed prices in buttons (assuming these buttons exist in your UI)
        self.GrainButton.setText('Grain Price: ' + str(int(df['price']['Grain']) / 100))
        self.GoldButton.setText('Gold Price: ' + str(int(df['price']['Gold']) / 100))
        self.OilButton.setText('Oil Price: ' + str(int(df['price']['Oil']) / 100))
        self.IndustryButton.setText('Indusry Price: ' + str(int(df['price']['Industry']) / 100))
        self.BondsButton.setText('Bonds Price: ' + str(int(df['price']['Bonds']) / 100))
        self.SilverButton.setText('Sliver Price: ' + str(int(df['price']['Silver']) / 100))

    # Emit layoutChanged signal to update the table view
        self.model.layoutChanged.emit()







    def ticker(self):
       self.Crawler.setText(self.CrawlerText)
       if len(self.CrawlerText)>61:
           self.CrawlerText=self.CrawlerText[1:]
       else:
           Stocks=["Grain", "Bonds", "Industry","Gold","Silver","Oil"]
           Function=["Up","Down","Div"]
           Price=['5','10','20']
           dice1=randint(0,5)
           dice2=randint(0,2)
           dice3=randint(0,2)
           times.append(times[-1] + 1)
           if dice2 == 0:
               df['price'][Stocks[dice1]] += int(Price[dice3])  
           #Decrease Prices   
           if dice2==1:
               df['price'][Stocks[dice1]]-=(int(Price[dice3]))
           #Reset price from 2.00 to 1.00
           if int(df['price'][Stocks[dice1]])>=200:
               data[Stocks[dice1]]=data[Stocks[dice1]]*2
               self.model.layoutChanged.emit()
               df['price'][Stocks[dice1]]=100
            #Reset Prices from 0.00 to 1.00   
           if int(df['price'][Stocks[dice1]])<=0:
               data[Stocks[dice1]]=0
                   
               self.model.layoutChanged.emit()
               df['price'][Stocks[dice1]] = 100
           if dice2==2 and (df['price'][Stocks[dice1]]/100)>=1:
               mulitiplier = (int(Price[dice3])/100)
               for x in range(0,8):
                   data['Money'][data.index[x]]+=(data[Stocks[dice1]][data.index[x]])*mulitiplier
               self.model.layoutChanged.emit()
         
           Oil_Stock.append(df['price']['Oil']/100)
           Bonds_Stock.append(df['price']['Bonds']/100)
           Industry_Stock.append(df['price']['Industry']/100)
           Silver_Stock.append(df['price']['Silver']/100)
           Gold_Stock.append(df['price']['Gold']/100) 
           Grain_Stock.append(df['price']['Grain']/100)      
                
           reg0.update({
               'Grain': Grain_Stock,
               'Oil': Oil_Stock,
               'Bonds': Bonds_Stock,
               'Industry': Industry_Stock,
               'Silver': Silver_Stock,
               'Gold': Gold_Stock,
           })
           if len(times) > 30:
               for key in reg0:
                   reg0[key] = reg0[key][-30:]
               times[:] = times[-30:]
           self.clear_and_redraw()
           self.CrawlerText+=('   ' +Stocks[dice1]+' '+Function[dice2]+' '+(Price[dice3])+' ')
           
    def clear_and_redraw(self):
        self.graph_widget.axes.clear()  
        for stock, stock_data in reg0.items():
            self.graph_widget.axes.plot(times[1:], stock_data[1:],'--', label=stock,)
        self.graph_widget.axes.legend(loc='upper left')
        self.graph_widget.axes.set_xlabel('Time')
        self.graph_widget.axes.set_ylabel('Stock Price')
        self.graph_widget.draw()  
          
app = QApplication(sys.argv);
window = Ui()
app.exec_()