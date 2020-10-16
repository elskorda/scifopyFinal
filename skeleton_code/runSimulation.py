# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'runSimulation.ui'
#
# Created by: PyQt5 UI code generator 5.5.1
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets
from particle import *
from numpy import *

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName("Dialog")
        Dialog.resize(737, 377)
        self.groupBox = QtWidgets.QGroupBox(Dialog)
        self.groupBox.setGeometry(QtCore.QRect(30, 10, 521, 181))
        self.groupBox.setObjectName("groupBox")
        self.n_part = QtWidgets.QLineEdit(self.groupBox)
        self.n_part.setGeometry(QtCore.QRect(30, 100, 113, 23))
        self.n_part.setObjectName("n_part")
        self.n_iter = QtWidgets.QLineEdit(self.groupBox)
        self.n_iter.setGeometry(QtCore.QRect(340, 100, 113, 23))
        self.n_iter.setObjectName("n_iter")
        self.label = QtWidgets.QLabel(self.groupBox)
        self.label.setGeometry(QtCore.QRect(30, 60, 131, 16))
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.groupBox)
        self.label_2.setGeometry(QtCore.QRect(340, 60, 131, 21))
        self.label_2.setObjectName("label_2")
        self.startSimulButton = QtWidgets.QPushButton(Dialog)
        self.startSimulButton.setGeometry(QtCore.QRect(80, 240, 181, 23))
        self.startSimulButton.setObjectName("startSimulButton")

        # define initial values
        self.nPart=3 
        self.nIter=100
        
        self.update_controls()
        self.n_iter.textChanged[str].connect(self.get_input_values)
        self.n_part.textChanged[str].connect(self.get_input_values)
        self.update_controls()
        
        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)
        self.startSimulButton.clicked.connect(self.run_simulation)


    def get_input_values(self):
        self.nIter = int(self.n_iter.text())
        self.nPart=int(self.n_part.text())
        
        
    def update_controls(self):
        self.n_iter.setText(str(self.nIter))
        self.n_part.setText(str(self.nPart))

        
    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "Dialog"))
        self.groupBox.setTitle(_translate("Dialog", "Input Paramters"))
        self.label.setText(_translate("Dialog", "Number of particles"))
        self.label_2.setText(_translate("Dialog", "Number of iterations"))
        self.startSimulButton.setText(_translate("Dialog", "Start Simulation"))
               
    def run_simulation(self):
        #print (self.nIter)
        
        nParticles = self.nPart
        nIterations =self.nIter
        print("running simumaltion for ",nParticles," particles and ",nIterations," iterations.")
        
        coords = zeros([nParticles,2],'d', order='F')
        sizes = zeros([nParticles], 'd', order='F')

        print("Initialise system...")

        particle_driver.init_system(nParticles)
        particle_driver.get_sizes(sizes)
        particle_driver.write_sizes()
        print("Run simulation...")

        for i in range(500):
            particle_driver.collision_check()
            particle_driver.boundary_check()
            particle_driver.update()
            particle_driver.get_positions(coords)
            particle_driver.write_positions()

        print("End simulation...")

        particle_driver.deallocate_system()
        self.startSimulButton.setEnabled(False)
        
if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Dialog = QtWidgets.QDialog()
    ui = Ui_Dialog()
    ui.setupUi(Dialog)
    Dialog.show()
    sys.exit(app.exec_())

