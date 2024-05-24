from PyQt5.QtWidgets import * #QApplication, QDialog, QPushButton #QtApplication 
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import *
from PyQt5 import uic
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg
from matplotlib.figure import Figure
import sys
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.backends.backend_qt5agg import (
  NavigationToolbar2QT as NavigationToolbar,
)

class MplCanvas(FigureCanvasQTAgg):

    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        self.axes = fig.add_subplot(111)
        super(MplCanvas, self).__init__(fig)
class Ui(QMainWindow):
    def __init__(self):
        super(Ui, self).__init__()
        uic.loadUi("C:\\Users\\SamuelYoung\\Downloads\\Final Project.ui", self)
        self.Graph1.clicked.connect(self.leg)
        self.Graph2.clicked.connect(self.holla)
        self.Graph3.clicked.connect(self.fightthepower)
        self.Graph4.clicked.connect(self.WSmith)
        global msc
        global sc
        msc = MplCanvas(self, width=5, height=4, dpi=100)
        sc = MplCanvas(self, width=5, height=4, dpi=100)
        self.show()
        
    def leg(self):
        sc.axes.cla()
        df=pd.read_excel('C:\\Users\\SamuelYoung\\Downloads\\CAMP.xlsx')
        totals={}
        sam=[]
        balls=[]

        stoppls=''
        used=np.array
        gloria={}
        answer=['1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000'
                ,'2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011',
                '2012','2013','2014','2015',]
        years_attended_once = {}
        # I calculate the Totals of each section of campers by year
        years= list(df['Camp'])
        for index, attendance in enumerate(years):
            for i in range(1990, 2016):
        #Adds the totals to a dictionary with the key being the year 
                totals[i] = totals.get(i, 0) + int(attendance.count(str(i)))
        for every in answer:
            count=0
            for each in df['Camp']:
        # Isolate for the 1 timers for each year
                if '  ' not in each and every in each[0:4]:
        #Add the 1 timer to the count
                    count+=1
        # Find the average of 1 timers by year
            gloria.update({every:(count/totals[int(every)])})
        #Graph the percentage of 1 timers per year
        for each in gloria.keys():  
            plt.plot(gloria.keys(),gloria.values())


        #used=used.reshape(2,26)


        #I change the oreantation of the xaxis so it is legable 
        plt.xticks(rotation=-90, ha = 'left')
        plt.xlabel('Years')
        plt.ylabel("Percentage of 1 timers")

        ax = plt.gca()
        ax.set_facecolor('xkcd:black')
        sc.axes.plot(gloria.keys(), gloria.values())
        toolbar = NavigationToolbar(sc, self)
        self.Display.addWidget(toolbar)
        self.Display.addWidget(sc)
        
    def holla(self):
        sc.axes.cla()
        df=pd.read_excel('C:\\Users\\SamuelYoung\\Downloads\\CAMP.xlsx')
        #df=pd.read_excel('C:\\Users\\SamuelYoung\\Desktop\\CAMP.xlsx')
        #Create all used variables
        totals={}
        final=[]
        sam=[]
        hel=[]
        heel=[]
        hel1=[]
        heel1=[]
        num=[]
        reg0={}
        reg1={}
        reg2={}
        reg3={}
        reg4={}
        reg5={}
        reg6={}
        reg7={}
        reg8={}
        reg9={}
        reg10={}
        Mcode={}
        count=0
        timmy=''
        yes=''
        data=[]
        answer=['1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000'
                ,'2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011',
                '2012','2013','2014','2015',]
        age=['RO', 'FR', 'RA', 'VO']
        boi=['1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000']
        # Totals of all campers per year
        years= list(df['Camp'])
        for index, attendance in enumerate(years):
            for i in range(1990, 2001):
        #Adds the totals to a dictionary with the key being the year 
                totals[i] = totals.get(i, 0) + int(attendance.count(str(i)))
        #I start to loop through every line in the data and devide it based on the camp and the year they were in that camp
        for each in df['Camp']:
            data=each.split('  ')
            for every in data:
                gl=every.strip(every[8:])
                if gl[5:7] in age:
                    if gl[0:4] in boi[0]:
                        reg0[gl[5:7]]=reg0.get(gl[5:7],1)+1
                    if gl[0:4] in boi[1]:
                        reg1[gl[5:7]]=reg1.get(gl[5:7],1)+1
                    if gl[0:4] in boi[2]:
                        reg2[gl[5:7]]=reg2.get(gl[5:7],1)+1
                    if gl[0:4] in boi[3]:
                        reg3[gl[5:7]]=reg3.get(gl[5:7],1)+1
                    if gl[0:4] in boi[4]:
                        reg4[gl[5:7]]=reg4.get(gl[5:7],1)+1
                    if gl[0:4] in boi[5]:
                        reg5[gl[5:7]]=reg5.get(gl[5:7],1)+1
                    if gl[0:4] in boi[6]:
                        reg6[gl[5:7]]=reg6.get(gl[5:7],1)+1
                    if gl[0:4] in boi[7]:
                        reg7[gl[5:7]]=reg7.get(gl[5:7],1)+1
                    if gl[0:4] in boi[8]:
                        reg8[gl[5:7]]=reg8.get(gl[5:7],1)+1
                    if gl[0:4] in boi[9]:
                        reg9[gl[5:7]]=reg9.get(gl[5:7],1)+1
                    if gl[0:4] in boi[10]:
                        reg10[gl[5:7]]=reg10.get(gl[5:7],1)+1
            sam=[]
        #I take devided data for each section and the year of that section and I get the percentage from the section by deviding it by the totals
        for each in age:
            reg0[each]=reg0[each]/totals[1990]
            reg1[each]=reg1[each]/totals[1991]
            reg2[each]=reg2[each]/totals[1992]
            reg3[each]=reg3[each]/totals[1993]
            reg4[each]=reg4[each]/totals[1994]
            reg5[each]=reg5[each]/totals[1995]
            reg6[each]=reg6[each]/totals[1996]
            reg7[each]=reg7[each]/totals[1997]
            reg8[each]=reg8[each]/totals[1998]
            reg9[each]=reg9[each]/totals[1999]
            reg10[each]=reg10[each]/totals[2000]
        # I put all the data into a dataframe based on the year that the data was recorded
        df2=pd.DataFrame([reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10], index=boi)
        # I plot all the data by year on a stacked bar graph to visually see the data
        
        df2.plot( kind='bar', stacked=True,
                title='Amount of Campers in Each Section by Year')
        plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0)
        jo=df2.plot( kind='bar', stacked=True,
                title='Amount of Campers in Each Section by Year')
        plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0)
        sc.axes.plot(df2)
        toolbar = NavigationToolbar(sc, self)
        self.Display.addWidget(toolbar)
        self.Display.addWidget(sc)
    def fightthepower(self):
        sc.axes.cla()
        df=pd.read_excel('C:\\Users\\SamuelYoung\\Downloads\\CAMP.xlsx')
        # I 2 lists 1 for the sections I want to isolate for and 1 for the year I will isolate for
        years=['2005','2006','2007','2008','2009','2010','2011',
        '2012','2013','2014','2015']
        camps=['RO1','RO2','RO3','RO4','RO5','FR1','FR2','FR3','FR4','FR5','RA1','RA2','RA3','RA4','RA5','VO1','VO2','VO3','VO4','VO5']
        count=0
        you=[]
        reg0={}
        reg1={}
        #I start to Isolate the data into what I want to analize
        for each in df['Camp']:
            data=each.split('  ')
        #I start to clean the data by making it all uniform by removing the ending ;
            for every in data:
                if every[0:4] in years:
                    if every[-1] == ';':
                        every=every.strip(';')
        # I funnel the data into a subset of the data that has the years I want and the section I want
                    if every[0:4] in years and every[5:8] in camps:
        # I devide the data into the years they atteded and the week they attended and the camp they attened
                        reg0[every]=reg0.get(every,0)+1 
        # Now I acount for the camp leaders and the odd time where there are double leaders
        for each in reg0.keys():
            if ';' in each:
                reg0[each]=reg0[each]+2
            else:
                reg0[each]=reg0[each]+1
        # For each year I count up how many times there were a section of 7 campers + leaders
        for each in reg0:
            if reg0[each]==7:
                reg1[each[0:4]]=reg1.get(each[0:4],0)+1
        sorted(reg1)
        # I plot the data into a bar graph and a line graph
        for each in reg1:
            plt.plot(reg1.keys(),reg1.values(),)
        plt.plot(title='Amount of Campers in Each Section by Year')
        plt.xlabel('Years')
        plt.ylabel("Amount of 7 Body Cabins")
        sc.axes.plot(reg1.keys(),reg1.values())
        toolbar = NavigationToolbar(sc, self)
        self.Display.addWidget(toolbar)
        self.Display.addWidget(sc)
    def WSmith(self):
        sc.axes.cla()
        df=pd.read_excel('C:\\Users\\SamuelYoung\\Downloads\\CAMP.xlsx')
        # I define all the varibles I use and a list that has all the years I isolate for
        counte=0
        sam=[]
        gl=[]
        reg0={}
        answer=['1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015',]
        #I start to isolate for the data I need by looping through every year that is required
        for year in answer:
            count=0
            counte=0
            sam=[]
        # I loop through all the data in the camp section
            for each in df['Camp']:
        # I use a counter varible to help keep track of where I am in the data
                count+=1
                if count == 9038:
                    count-=1
        # I get the birth date by using the counter and the age section
                birth=df['Date'][count][6:11]
        # I isolate for the campers last year and make sure that no camper from the Special needs section is included
                if each[0:4] in year and each[5:8] not in 'SN':
        # I calculate the age of the camper by subtacting their birth year by there last camp year
                    retire=int(year)-int(birth)
                    counte+=1
                    sam.append(retire)
        # I add the data to a dictionary with the key being the year
            reg0.update({year:sum(sam)/counte})
        #I graph the data in a line graph
        for each in reg0:
            plt.plot(reg0.keys(),reg0.values(), color='red')
        plt.xticks(rotation=-90, ha = 'left')
        plt.xlabel('Years')
        plt.ylabel("Age")

        ax = plt.gca()
        ax.set_facecolor('xkcd:black')
        sc.axes.plot(reg0.keys(),reg0.values())
        toolbar = NavigationToolbar(sc, self)
        self.Display.addWidget(toolbar)
        
app = QApplication(sys.argv)
window = Ui()
app.exec_()
    