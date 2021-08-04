# CSC258_project_2021_summer
University of Toronto 
Summer2021 CSC258 project
Dedong Xie

## Project proposal
CSC258 Project proposal

1.	The type of project
a.	Individual project
I will do the project myself.
(Why not looking for a partner? Time zone differences + I feel myself suitable for doing it on my own (doing so individually will be more challenging but I will try to make it)
b.	10000% myself :D
2.	Description of game
a.	Basic game rules
i.	Spacecraft moving on a rectangular game area, moves controlled by input from keyboard.
ii.	Random obstacles appear in the game area and consistently generating new from right and vanishing from left.
iii.	Target is to prevent interaction with the obstacles, each crash will result in reduction of health. 
iv.	Showing hp (health points) as hearts on the top of game view
v.	When you run out of health, game ends.
vi.	Have a game start menu screen and end of game screen.
b.	Additional features
i.	Create animation for the hit/hurt/break of spaceship/obstacle and allow grazing (interaction with small part may result in a reduction of damage) (This is a modification of the grazing feature, which also involves random number to represent chances of a near miss)
ii.	Assign points to player on every successful prevention of crash and show total score on the end of game screen.
iii.	Changeable difficulty/difficulty adjust to game play (become harder and harder as time goes by increasing moving speed, length of obstacles, and new look of obstacles) (This is a combination of the features i and ii.)
3.	Proposed methodology
a.	I will have two methods for generation of obstacles and spaceship, each will write to memory
b.	I will use two methods correspondingly to erase spaceship and obstacles, each will assign the painted points black
c.	I will use random generator to get the initial position in rows of obstacle
d.	I will scan the screen and determine collision in each frame by d(spaceship, obstacle) < obstacle_size
e.	When collision happens, the animation of hurt will be triggered by chance
f.	I track multiple obstacles on the screen by storing their positions in memory
g.	I track position of spaceship also in memory
h.	I will increase the difficulty by changing the pre-stored generating rate and level variable, which enables multiple types, more obstacles, and faster for them to move
4.	Planned milestones
a.	Milestone 1
i.	Create spaceship avatar
ii.	Create obstacle figure
iii.	Obstacle appear, move and disappear
iv.	Create game start screen
v.	Create game end screen
vi.	Showing health hearts on top of the screen
vii.	Enable restart by pressing “P” on the keyboard

b.	Milestone 2
i.	Spaceship move according to keyboard input
ii.	Collision detection and recording (by reduce of health)
iii.	Show remaining “health” of the ship (will be reduced on each collision)
iv.	Running out of health -> game over screen

c.	Milestone 3
i.	Assign score to player when successfully avoid collision
ii.	Implement different types of collisions by different color on the spaceship and reduction of health
iii.	Implement different types of obstacle (different size, color, look)
iv.	Add difficulty by increase speed, appearance rate, size, color of obstacles every 10 seconds (possibly show a screen of level up?)
