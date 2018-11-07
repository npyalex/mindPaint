# mindPaint
Capture your brainwaves and watch as they are used to generate paintings. How do your thoughts affect what is shown?
Hardware-to-screen project for OCAD Digital Futures M.Des 2018

### Overview
MindPaint uses a variation of the [Rhodonea Curve](https://en.wikipedia.org/wiki/Rose_(mathematics)). It translates a user's brainwaves into integers that are plugged into the formula to create massive fractal images. In a sense it is a brain-generated computer-guided [Spirograph](https://en.wikipedia.org/wiki/Spirograph).

The following brainwaves are read:

              Delta = deep sleep 
              Theta =  sleep 
              Low Alpha = imagination
              High Alpha = intuition
              Low Beta = alertness
              High Beta = stress
              Low Gamma = info processing
              Mid Gamma = insight

The following parameters are captured by the headset, although they are not brainwaves: 
            
              Attention
              Meditation

The code is currently arranged in such a way that higher concentration should result in high-contrast images, while a state of meditation should result in more complex geometry being generated.

Take a screenshot by pressing 'C'. Screenshots are stored in the sketch folder.


### Troubleshooting
The headset updates once every 1-1.5 seconds. The painting updates once every 2 seconds. Occasionally there may be a hitch when the headset hasn't updated and the painting is looking for new variables.
Check that the headset is on, has power, and is contacting your skin correctly.
Check that the code is reading the correct port. The console will read off an array of all active ports when the program launches.


### Special Thanks
Built with NeuroSky MindWave Mobile. Requires the [MindWave Manager](http://support.neurosky.com/).
This project was inspired by the work of
Arturo Vidich, Sofy Yuditskaya and Eric Mika
from Frontier Nerds and the Mental Block project
[http://www.frontiernerds.com/brain-hack](http://www.frontiernerds.com/brain-hack)

This project would not exist if not for some excellent advice from Nick Puckett.

While I didn't use his code, some insights from the work of [Eric Blue](eric-blue.com) pointed me in the right direction.

Code from user precociousmouse from the [Processing forums](forum.processing.org) provided the breakthrough I needed. Thank you, whoever you are.

### LICENSE
Copyright Nick Alexander 2018
Licensed under the GNU Lesser General Public License.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this program. If not, see http://www.gnu.org/licenses/.