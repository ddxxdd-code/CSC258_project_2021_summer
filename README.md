# CSC258_project_2021_summer
University of Toronto 
Summer2021 CSC258 project
Dedong Xie

## Introduction
This is the project for CSC258 in the University of Toronto Summer term 2021.

Please follow the below setup:

Running the code `game.asm` using MARS Simulator

MARS Simulator: https://courses.missouristate.edu/KenVollmar/MARS/

MARS runs on Java, please have Java installed on your machine (or install it from https://www.oracle.com/java/technologies/javase-jdk16-downloads.html)

After opening the code in the simulator, use `Tools -> Bitmap Display` and `Tools -> Keyboard and Display MMIO Simulator`, both connected to MIPS.

Use the below setup for `Bitmap Display`:
  - Unit width in pixels: 8
  - Unit height in pixels: 8
  - Display width in pixels: 256
  - Display height in pixels: 256
  - Base Address for Display: 0x10008000 ($gp)

Use `F3` to assemble the code then press the green `run` button on the top middle bar of MARS to start the game.

Input in the Keyboard Simulator's `KEYBOARD` area to control the game.

Use of keyboard in the game:
  - w: spaceship go up
  - a: spaceship go right
  - s: spaceship go down
  - d: spaceship go left
  - p: restart the game
  - e: end the game

__Enjoy Gaming !!!__

## Project proposal
CSC258 Project proposal

1.  The type of project
    1. Individual project
        - I will do the project myself.
        - (Why not looking for a partner? Time zone differences + I feel myself suitable for doing it on my own (doing so individually will be more challenging but I will try to make it)
    2. 10000% myself :D
2.	Description of game
    1.	Basic game rules
        1.	Spacecraft moving on a rectangular game area, moves controlled by input from keyboard.
        2.	Random obstacles appear in the game area and consistently generating new from right and vanishing from left.
        3.	Target is to prevent interaction with the obstacles, each crash will result in reduction of health. 
        4.	Showing hp (health points) as hearts on the top of game view
        5.	When you run out of health, game ends.
        6.	Have a game start menu screen and end of game screen.
    2.	Additional features
        1.	Create animation for the hit/hurt/break of spaceship/obstacle and allow grazing (interaction with small part may result in a reduction of damage) (This is a modification of the grazing feature, which also involves random number to represent chances of a near miss)
        2.	Assign points to player on every successful prevention of crash and show total score on the end of game screen.
        3.	Changeable difficulty/difficulty adjust to game play (become harder and harder as time goes by increasing moving speed, length of obstacles, and new look of obstacles) (This is a combination of the features i and ii.)
3.	Proposed methodology
    1.	I will have two methods for generation of obstacles and spaceship, each will write to memory
    2.	I will use two methods correspondingly to erase spaceship and obstacles, each will assign the painted points black
    3.	I will use random generator to get the initial position in rows of obstacle
    4.	I will scan the screen and determine collision in each frame by d(spaceship, obstacle) < obstacle_size
    5.	When collision happens, the animation of hurt will be triggered by chance
    6.	I track multiple obstacles on the screen by storing their positions in memory
    7.	I track position of spaceship also in memory
    8.	I will increase the difficulty by changing the pre-stored generating rate and level variable, which enables multiple types, more obstacles, and faster for them to move
4.	Planned milestones
    1.	Milestone 1
        1.	Create spaceship avatar
        2.	Create obstacle figure
        3.	Obstacle appear, move and disappear
        4.	Create game start screen
        5.	Create game end screen
        6.	Showing health hearts on top of the screen
        7.	Enable restart by pressing “P” on the keyboard

    2.	Milestone 2
        1.	Spaceship move according to keyboard input
        2.	Collision detection and recording (by reduce of health)
        3.	Show remaining “health” of the ship (will be reduced on each collision)
        4.	Running out of health -> game over screen

    3.	Milestone 3
        1.	Assign score to player when successfully avoid collision
        2.	Implement different types of collisions by different color on the spaceship and reduction of health
        3.	Implement different types of obstacle (different size, color, look)
        4.	Add difficulty by increase speed, appearance rate, size, color of obstacles every 10 seconds (possibly show a screen of level up?)
