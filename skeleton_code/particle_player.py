# -*- coding: utf-8 -*-
"""Particle player application in PyQt5"""

import sys

from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5 import uic

import numpy as np

class Particles:
    """Particles class - Holds a complete set of particles"""

    def __init__(self, filename=""):
        """Class constructor"""

        self.__filename = filename
        self.__steps = 0
        
    def read(self):
        """Read particles from state file"""
        
        self.__particles = []
        
        # Read particle size
        
        print("Reading particle sizes...")

        state_file = open(self.__filename, 'r')
        n_particles = int(state_file.readline())
        self.__particle_radius = np.zeros((n_particles,), dtype=float)
        
        for i in range(n_particles):
            self.__particle_radius[i] = float(state_file.readline())

        n_particles = int(state_file.readline())
        line = state_file.readline()
    
        print("Reading particle traces...")
        
        while line:

            pos_table = np.zeros((n_particles, 2), dtype=float)

            for i in range(n_particles):
                pos = [float(item) for item in line.strip().split()]
                pos_table[i, :] = pos
                line = state_file.readline()

            if len(pos_table)>0:
                self.__particles.append(pos_table)
        
            if line:
                n_particles = int(line.strip())
                line = state_file.readline()
            
        state_file.close()    
        
        self.__steps = len(self.__particles)

    def __getitem__(self, key):
        return self.__particles[key]

    def get_radius(self):
        return self.__particle_radius

    def get_steps(self):
        return self.__steps

    sizes = property(get_radius)
    steps = property(get_steps)


class ParticleWidget(QWidget):
    """Class implementing a widget for drawing our particle system."""

    def __init__(self, parent):
        """Class constructor"""
        super().__init__(parent)

        self.__positions = None
        self.__sizes = None
        self.__scaling = 1000

    def draw_particles(self, qp):
        """Draws particle system"""

        qp.setPen(Qt.gray)
        qp.setBrush(Qt.gray)

        for i in range(len(self.__positions)):
            qp.drawEllipse(QPoint(self.__positions[i, 0]*self.__scaling, self.__positions[i, 1]
                                  * self.__scaling), self.__sizes[i]*self.__scaling, self.__sizes[i]*self.__scaling)

    def paintEvent(self, e):
        """Handles window paint event and sets up a QPainter object."""
        qp = QPainter()
        qp.begin(self)
        qp.setRenderHint(QPainter.Antialiasing, True)
        qp.setRenderHint(QPainter.TextAntialiasing, True)
        qp.setRenderHint(QPainter.SmoothPixmapTransform, True)
        self.draw_particles(qp)
        qp.end()

    def set_positions(self, p):
        """Property positions set method"""
        self.__positions = p

    def get_positions(self):
        """Property positions get method"""
        return self.__positions

    def set_sizes(self, s):
        """Property sizes set method"""
        self.__sizes = s

    def get_sizes(self):
        """Property sizes get method"""
        return self.__sizes

    positions = property(get_positions, set_positions)
    sizes = property(get_sizes, set_sizes)


class ParticlePlayerWindow(QWidget):
    """Main window class for the Flow application"""

    def __init__(self):
        """Class constructor"""

        super().__init__()

        # Load user interface

        uic.loadUi('particle_player.ui', self)
        
        # Add particle widget to layout

        self.particle_widget = ParticleWidget(self)
        self.setLayout(QVBoxLayout(self))
        self.layout().addWidget(self.particle_widget)

        # Set window properties

        self.setGeometry(50, 50, 1020, 1020)
        self.show()
        
        # Read particles from file
        
        self.__particles = Particles("particle.state")
        self.__particles.read()
        
        # Initialise current step counter
        
        self.step = 0
        
        # Create a timer to handle animation
        
        self.timer = QTimer()
        self.timer.timeout.connect(self.on_timer)
        self.timer.start(0)
        
        
    def on_timer(self):
        """Timer callback for animating particles"""

        p = self.__particles[self.step]
        s = self.__particles.sizes
        self.particle_widget.positions = p
        self.particle_widget.sizes = s

        self.step += 1
        if self.step == self.__particles.steps:
            self.step = 0

        # Update particle widget

        self.particle_widget.update()


if __name__ == '__main__':

    app = QApplication(sys.argv)
    window = ParticlePlayerWindow()
    sys.exit(app.exec_())
