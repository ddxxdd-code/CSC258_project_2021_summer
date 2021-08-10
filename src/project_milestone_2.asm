#####################################################################
#
# CSC258 Summer 2021 Assembly Final Project
# University of Toronto
#
# Student: Dedong Xie, 1006702944, xiededon
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# - Milestone 1
# - Milestone 2
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. Create animation for the collide of spaceship
# 2. Assign points to player on every successful prevention of crash and show total score on the end of game screen
# 
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

# storage of global variables
# playerScore:	$s0
# playerHealth:	$s1
# difficulty:	$s2
# damage:	$s3
# score:	$s5

.data
	displayAddress:	.word 	0x10008000
	shipColumn:	.word	0
	shipRow:	.word	14
	obstacleType:	.word 	0:16
	obstacleRow:	.word	0:32
	obstacleColumn:	.word	0:32
	
.text
#################################################
# main function
# This is the main function of the program, the starting point of execution

main:
	startGame:
	jal	initializeMemory		# initialize memory
	jal	drawStartScreen
	jal	initializeObstacle
	
	getStartSignal:				# wait until any key is pressed to start the game
	li 	$t9, 0xffff0000
	lw 	$t8, 0($t9)
	bne 	$t8, 1, getStartSignal
	
	jal	eraseStartScreen		# erase the start screen to game
	
	gameLoop:				# in each game loop, draw ship, draw obstacles while detecting collision, 
						# sleep and get input
	jal	drawSpaceship
	jal	drawObstacle
	jal	drawStatusBar
	jal	gameSleep
	jal	eraseObstacle
	jal	eraseSpaceship
	jal	eraseStatusBar
	jal	collisionAnimation
	blez	$s1, endGame			# if health <= 0, end the game
	jal	getInput
	jal	updateObstacle
	b 	gameLoop

	endGame:
	jal	drawEndScreen			# draw end screen and exit
	li	$v0, 10				# exit()
	syscall

#################################################
# initilization of memory and variables

initializeMemory:				# initialize memory, set start values
	li	$t0, 0x10008000
	sw	$t0, displayAddress		# displayAddress = 0x10008000
	
	li	$s0, 0				# playerScore = 0
	li	$s1, 6				# playerHealth = 6
	
	sw	$0, shipColumn			# shipColumn = 0
	
	li	$t0, 14
	sw	$t0, shipRow			# shipRow = 14

	li	$s2, 1				# difficulty = 1
	li	$s3, 0				# damage = 0
	
	initInitObstacleLoop:
	li	$t0, 0				# i = 0
		
	condInitObstacleLoop:
	beq	$t0, 16, endInitObstacleLoop	# for i < 16:
	
	bodyInitObstacleLoop:
	sll	$t1, $t0, 2			# $t1 = 4$t0
	sw	$0, obstacleType($t1)		# set all types to 0
	sw	$0, obstacleColumn($t1)		# set all obstacles' column to 0
	sw	$0, obstacleRow($t1)		# set all obstacles' row to 0
		
	addi	$t0, $t0, 1			# i += 1
	j	condInitObstacleLoop		# loop back
	
	endInitObstacleLoop:
	li	$t0, 0
	condInitCanvasLoop:
	bge	$t0, 1024, endInitCanvasLoop
	bodyInitCanvasLoop:
	sll	$t1, $t0, 2
	lw	$t2, displayAddress
	add	$t1, $t1, $t2
	sw	$0, ($t1)
	addi	$t0, $t0, 1
	j	condInitCanvasLoop
	endInitCanvasLoop:
	jr	$ra				# end the function of initilizing the memory

initializeObstacle:
	initRandObstacleLoop:
	li	$t0, 0				# i = 0
	condRandObstacleLoop:
	bge	$t0, 4, endRandObstacleLoop	# for i < 4:
	bodyRandObstacleLoop:
		getRandObstaclePosition:
		li 	$v0, 42         	# Service 42, random int range
		li 	$a0, 0          	# Select random generator 0
		li 	$a1, 31	   		# Select upper bound of random number
		syscall            		# Generate random int (returns in $a0)
	
		addi	$t5, $a0, 0		# get column position in $t5
	
		li 	$v0, 42         	# Service 42, random int range
		li 	$a0, 0          	# Select random generator 0
		li 	$a1, 28	   		# Select upper bound of random number
		syscall            		# Generate random int (returns in $a0)
	
		addi	$t6, $a0, 0		# get row position in $t6
		
		ble	$t6, 10, setRandObstacle
		bge	$t6, 18, setRandObstacle
		bge	$t5, 4, setRandObstacle
		j	getRandObstaclePosition

		setRandObstacle:
		sll	$t1, $t0, 2		# $t1 = 4$t0, offset = 4*i, store the corresponding type and positions
		sw	$0, obstacleType($t1)
		sw	$t5, obstacleColumn($t1)
		sw	$t6, obstacleRow($t1)
		
	addi	$t0, $t0, 1			# i += 1
	j	condRandObstacleLoop
	endRandObstacleLoop:
	jr	$ra
	
#################################################
# drawing functions

drawStartScreen:				# draw the start screen
	lw	$t0, displayAddress	# $t0 stores the base address for display
	li	$t1, 0x9e9e9e		# $t1 stores the light grey color code
	li	$t2, 0x464646		# $t2 stores the dark grey color code
	li	$t3, 0xffd266		# $t3 stores the yellow color code
	sw	$t1, 396($t0)		# paint the unit on row 3, column 3, color 1
	sw	$t1, 400($t0)		# paint the unit on row 3, column 4, color 1
	sw	$t1, 412($t0)		# paint the unit on row 3, column 7, color 1
	sw	$t1, 416($t0)		# paint the unit on row 3, column 8, color 1
	sw	$t1, 420($t0)		# paint the unit on row 3, column 9, color 1
	sw	$t1, 424($t0)		# paint the unit on row 3, column 10, color 1
	sw	$t1, 428($t0)		# paint the unit on row 3, column 11, color 1
	sw	$t1, 440($t0)		# paint the unit on row 3, column 14, color 1
	sw	$t1, 444($t0)		# paint the unit on row 3, column 15, color 1
	sw	$t1, 456($t0)		# paint the unit on row 3, column 18, color 1
	sw	$t1, 460($t0)		# paint the unit on row 3, column 19, color 1
	sw	$t1, 464($t0)		# paint the unit on row 3, column 20, color 1
	sw	$t1, 476($t0)		# paint the unit on row 3, column 23, color 1
	sw	$t1, 480($t0)		# paint the unit on row 3, column 24, color 1
	sw	$t1, 484($t0)		# paint the unit on row 3, column 25, color 1
	sw	$t1, 488($t0)		# paint the unit on row 3, column 26, color 1
	sw	$t1, 492($t0)		# paint the unit on row 3, column 27, color 1
	sw	$t1, 520($t0)		# paint the unit on row 4, column 2, color 1
	sw	$t1, 532($t0)		# paint the unit on row 4, column 5, color 1
	sw	$t1, 548($t0)		# paint the unit on row 4, column 9, color 1
	sw	$t1, 564($t0)		# paint the unit on row 4, column 13, color 1
	sw	$t1, 576($t0)		# paint the unit on row 4, column 16, color 1
	sw	$t1, 584($t0)		# paint the unit on row 4, column 18, color 1
	sw	$t1, 596($t0)		# paint the unit on row 4, column 21, color 1
	sw	$t1, 612($t0)		# paint the unit on row 4, column 25, color 1
	sw	$t1, 628($t0)		# paint the unit on row 4, column 29, color 1
	sw	$t1, 652($t0)		# paint the unit on row 5, column 3, color 1
	sw	$t1, 676($t0)		# paint the unit on row 5, column 9, color 1
	sw	$t1, 692($t0)		# paint the unit on row 5, column 13, color 1
	sw	$t1, 704($t0)		# paint the unit on row 5, column 16, color 1
	sw	$t1, 712($t0)		# paint the unit on row 5, column 18, color 1
	sw	$t1, 716($t0)		# paint the unit on row 5, column 19, color 1
	sw	$t1, 720($t0)		# paint the unit on row 5, column 20, color 1
	sw	$t1, 740($t0)		# paint the unit on row 5, column 25, color 1
	sw	$t1, 784($t0)		# paint the unit on row 6, column 4, color 1
	sw	$t1, 804($t0)		# paint the unit on row 6, column 9, color 1
	sw	$t1, 820($t0)		# paint the unit on row 6, column 13, color 1
	sw	$t1, 824($t0)		# paint the unit on row 6, column 14, color 1
	sw	$t1, 828($t0)		# paint the unit on row 6, column 15, color 1
	sw	$t1, 832($t0)		# paint the unit on row 6, column 16, color 1
	sw	$t1, 840($t0)		# paint the unit on row 6, column 18, color 1
	sw	$t1, 848($t0)		# paint the unit on row 6, column 20, color 1
	sw	$t1, 868($t0)		# paint the unit on row 6, column 25, color 1
	sw	$t1, 904($t0)		# paint the unit on row 7, column 2, color 1
	sw	$t1, 916($t0)		# paint the unit on row 7, column 5, color 1
	sw	$t1, 932($t0)		# paint the unit on row 7, column 9, color 1
	sw	$t1, 948($t0)		# paint the unit on row 7, column 13, color 1
	sw	$t1, 960($t0)		# paint the unit on row 7, column 16, color 1
	sw	$t1, 968($t0)		# paint the unit on row 7, column 18, color 1
	sw	$t1, 980($t0)		# paint the unit on row 7, column 21, color 1
	sw	$t1, 996($t0)		# paint the unit on row 7, column 25, color 1
	sw	$t1, 1012($t0)		# paint the unit on row 7, column 29, color 1
	sw	$t1, 1036($t0)		# paint the unit on row 8, column 3, color 1
	sw	$t1, 1040($t0)		# paint the unit on row 8, column 4, color 1
	sw	$t1, 1060($t0)		# paint the unit on row 8, column 9, color 1
	sw	$t1, 1076($t0)		# paint the unit on row 8, column 13, color 1
	sw	$t1, 1088($t0)		# paint the unit on row 8, column 16, color 1
	sw	$t1, 1096($t0)		# paint the unit on row 8, column 18, color 1
	sw	$t1, 1108($t0)		# paint the unit on row 8, column 21, color 1
	sw	$t1, 1124($t0)		# paint the unit on row 8, column 25, color 1
	sw	$t2, 1284($t0)		# paint the unit on row 10, column 1, color 2
	sw	$t2, 1288($t0)		# paint the unit on row 10, column 2, color 2
	sw	$t2, 1296($t0)		# paint the unit on row 10, column 4, color 2
	sw	$t2, 1300($t0)		# paint the unit on row 10, column 5, color 2
	sw	$t2, 1308($t0)		# paint the unit on row 10, column 7, color 2
	sw	$t2, 1312($t0)		# paint the unit on row 10, column 8, color 2
	sw	$t2, 1316($t0)		# paint the unit on row 10, column 9, color 2
	sw	$t2, 1324($t0)		# paint the unit on row 10, column 11, color 2
	sw	$t2, 1328($t0)		# paint the unit on row 10, column 12, color 2
	sw	$t2, 1336($t0)		# paint the unit on row 10, column 14, color 2
	sw	$t2, 1340($t0)		# paint the unit on row 10, column 15, color 2
	sw	$t2, 1352($t0)		# paint the unit on row 10, column 18, color 2
	sw	$t2, 1364($t0)		# paint the unit on row 10, column 21, color 2
	sw	$t2, 1376($t0)		# paint the unit on row 10, column 24, color 2
	sw	$t2, 1380($t0)		# paint the unit on row 10, column 25, color 2
	sw	$t2, 1384($t0)		# paint the unit on row 10, column 26, color 2
	sw	$t2, 1388($t0)		# paint the unit on row 10, column 27, color 2
	sw	$t2, 1396($t0)		# paint the unit on row 10, column 29, color 2
	sw	$t2, 1412($t0)		# paint the unit on row 11, column 1, color 2
	sw	$t2, 1420($t0)		# paint the unit on row 11, column 3, color 2
	sw	$t2, 1424($t0)		# paint the unit on row 11, column 4, color 2
	sw	$t2, 1432($t0)		# paint the unit on row 11, column 6, color 2
	sw	$t2, 1436($t0)		# paint the unit on row 11, column 7, color 2
	sw	$t2, 1448($t0)		# paint the unit on row 11, column 10, color 2
	sw	$t2, 1460($t0)		# paint the unit on row 11, column 13, color 2
	sw	$t2, 1476($t0)		# paint the unit on row 11, column 17, color 2
	sw	$t2, 1484($t0)		# paint the unit on row 11, column 19, color 2
	sw	$t2, 1492($t0)		# paint the unit on row 11, column 21, color 2
	sw	$t2, 1500($t0)		# paint the unit on row 11, column 23, color 2
	sw	$t2, 1504($t0)		# paint the unit on row 11, column 24, color 2
	sw	$t2, 1520($t0)		# paint the unit on row 11, column 28, color 2
	sw	$t2, 1540($t0)		# paint the unit on row 12, column 1, color 2
	sw	$t2, 1544($t0)		# paint the unit on row 12, column 2, color 2
	sw	$t2, 1552($t0)		# paint the unit on row 12, column 4, color 2
	sw	$t2, 1556($t0)		# paint the unit on row 12, column 5, color 2
	sw	$t2, 1564($t0)		# paint the unit on row 12, column 7, color 2
	sw	$t2, 1568($t0)		# paint the unit on row 12, column 8, color 2
	sw	$t2, 1572($t0)		# paint the unit on row 12, column 9, color 2
	sw	$t2, 1580($t0)		# paint the unit on row 12, column 11, color 2
	sw	$t2, 1592($t0)		# paint the unit on row 12, column 14, color 2
	sw	$t2, 1604($t0)		# paint the unit on row 12, column 17, color 2
	sw	$t2, 1608($t0)		# paint the unit on row 12, column 18, color 2
	sw	$t2, 1612($t0)		# paint the unit on row 12, column 19, color 2
	sw	$t2, 1620($t0)		# paint the unit on row 12, column 21, color 2
	sw	$t2, 1624($t0)		# paint the unit on row 12, column 22, color 2
	sw	$t2, 1632($t0)		# paint the unit on row 12, column 24, color 2
	sw	$t2, 1636($t0)		# paint the unit on row 12, column 25, color 2
	sw	$t2, 1640($t0)		# paint the unit on row 12, column 26, color 2
	sw	$t2, 1648($t0)		# paint the unit on row 12, column 28, color 2
	sw	$t2, 1668($t0)		# paint the unit on row 13, column 1, color 2
	sw	$t2, 1680($t0)		# paint the unit on row 13, column 4, color 2
	sw	$t2, 1688($t0)		# paint the unit on row 13, column 6, color 2
	sw	$t2, 1692($t0)		# paint the unit on row 13, column 7, color 2
	sw	$t2, 1712($t0)		# paint the unit on row 13, column 12, color 2
	sw	$t2, 1724($t0)		# paint the unit on row 13, column 15, color 2
	sw	$t2, 1732($t0)		# paint the unit on row 13, column 17, color 2
	sw	$t2, 1740($t0)		# paint the unit on row 13, column 19, color 2
	sw	$t2, 1748($t0)		# paint the unit on row 13, column 21, color 2
	sw	$t2, 1756($t0)		# paint the unit on row 13, column 23, color 2
	sw	$t2, 1760($t0)		# paint the unit on row 13, column 24, color 2
	sw	$t2, 1776($t0)		# paint the unit on row 13, column 28, color 2
	sw	$t2, 1796($t0)		# paint the unit on row 14, column 1, color 2
	sw	$t2, 1808($t0)		# paint the unit on row 14, column 4, color 2
	sw	$t2, 1816($t0)		# paint the unit on row 14, column 6, color 2
	sw	$t2, 1820($t0)		# paint the unit on row 14, column 7, color 2
	sw	$t2, 1824($t0)		# paint the unit on row 14, column 8, color 2
	sw	$t2, 1828($t0)		# paint the unit on row 14, column 9, color 2
	sw	$t2, 1832($t0)		# paint the unit on row 14, column 10, color 2
	sw	$t2, 1836($t0)		# paint the unit on row 14, column 11, color 2
	sw	$t2, 1844($t0)		# paint the unit on row 14, column 13, color 2
	sw	$t2, 1848($t0)		# paint the unit on row 14, column 14, color 2
	sw	$t2, 1860($t0)		# paint the unit on row 14, column 17, color 2
	sw	$t2, 1868($t0)		# paint the unit on row 14, column 19, color 2
	sw	$t2, 1876($t0)		# paint the unit on row 14, column 21, color 2
	sw	$t2, 1884($t0)		# paint the unit on row 14, column 23, color 2
	sw	$t2, 1888($t0)		# paint the unit on row 14, column 24, color 2
	sw	$t2, 1892($t0)		# paint the unit on row 14, column 25, color 2
	sw	$t2, 1896($t0)		# paint the unit on row 14, column 26, color 2
	sw	$t2, 1904($t0)		# paint the unit on row 14, column 28, color 2
	sw	$t2, 1912($t0)		# paint the unit on row 14, column 30, color 2
	sw	$t3, 2056($t0)		# paint the unit on row 16, column 2, color 3
	sw	$t3, 2060($t0)		# paint the unit on row 16, column 3, color 3
	sw	$t3, 2080($t0)		# paint the unit on row 16, column 8, color 3
	sw	$t3, 2096($t0)		# paint the unit on row 16, column 12, color 3
	sw	$t3, 2100($t0)		# paint the unit on row 16, column 13, color 3
	sw	$t3, 2120($t0)		# paint the unit on row 16, column 18, color 3
	sw	$t3, 2132($t0)		# paint the unit on row 16, column 21, color 3
	sw	$t3, 2136($t0)		# paint the unit on row 16, column 22, color 3
	sw	$t3, 2140($t0)		# paint the unit on row 16, column 23, color 3
	sw	$t3, 2180($t0)		# paint the unit on row 17, column 1, color 3
	sw	$t3, 2184($t0)		# paint the unit on row 17, column 2, color 3
	sw	$t3, 2188($t0)		# paint the unit on row 17, column 3, color 3
	sw	$t3, 2192($t0)		# paint the unit on row 17, column 4, color 3
	sw	$t3, 2200($t0)		# paint the unit on row 17, column 6, color 3
	sw	$t3, 2204($t0)		# paint the unit on row 17, column 7, color 3
	sw	$t3, 2208($t0)		# paint the unit on row 17, column 8, color 3
	sw	$t3, 2212($t0)		# paint the unit on row 17, column 9, color 3
	sw	$t3, 2224($t0)		# paint the unit on row 17, column 12, color 3
	sw	$t3, 2228($t0)		# paint the unit on row 17, column 13, color 3
	sw	$t3, 2240($t0)		# paint the unit on row 17, column 16, color 3
	sw	$t3, 2244($t0)		# paint the unit on row 17, column 17, color 3
	sw	$t3, 2248($t0)		# paint the unit on row 17, column 18, color 3
	sw	$t3, 2252($t0)		# paint the unit on row 17, column 19, color 3
	sw	$t3, 2260($t0)		# paint the unit on row 17, column 21, color 3
	sw	$t3, 2272($t0)		# paint the unit on row 17, column 24, color 3
	sw	$t3, 2312($t0)		# paint the unit on row 18, column 2, color 3
	sw	$t3, 2316($t0)		# paint the unit on row 18, column 3, color 3
	sw	$t3, 2328($t0)		# paint the unit on row 18, column 6, color 3
	sw	$t3, 2332($t0)		# paint the unit on row 18, column 7, color 3
	sw	$t3, 2336($t0)		# paint the unit on row 18, column 8, color 3
	sw	$t3, 2340($t0)		# paint the unit on row 18, column 9, color 3
	sw	$t3, 2348($t0)		# paint the unit on row 18, column 11, color 3
	sw	$t3, 2352($t0)		# paint the unit on row 18, column 12, color 3
	sw	$t3, 2356($t0)		# paint the unit on row 18, column 13, color 3
	sw	$t3, 2360($t0)		# paint the unit on row 18, column 14, color 3
	sw	$t3, 2368($t0)		# paint the unit on row 18, column 16, color 3
	sw	$t3, 2372($t0)		# paint the unit on row 18, column 17, color 3
	sw	$t3, 2376($t0)		# paint the unit on row 18, column 18, color 3
	sw	$t3, 2380($t0)		# paint the unit on row 18, column 19, color 3
	sw	$t3, 2388($t0)		# paint the unit on row 18, column 21, color 3
	sw	$t3, 2392($t0)		# paint the unit on row 18, column 22, color 3
	sw	$t3, 2396($t0)		# paint the unit on row 18, column 23, color 3
	sw	$t3, 2440($t0)		# paint the unit on row 19, column 2, color 3
	sw	$t3, 2444($t0)		# paint the unit on row 19, column 3, color 3
	sw	$t3, 2464($t0)		# paint the unit on row 19, column 8, color 3
	sw	$t3, 2480($t0)		# paint the unit on row 19, column 12, color 3
	sw	$t3, 2484($t0)		# paint the unit on row 19, column 13, color 3
	sw	$t3, 2504($t0)		# paint the unit on row 19, column 18, color 3
	sw	$t3, 2516($t0)		# paint the unit on row 19, column 21, color 3
	sw	$t3, 2528($t0)		# paint the unit on row 19, column 24, color 3
	sw	$t3, 2692($t0)		# paint the unit on row 21, column 1, color 3
	sw	$t3, 2704($t0)		# paint the unit on row 21, column 4, color 3
	sw	$t3, 2716($t0)		# paint the unit on row 21, column 7, color 3
	sw	$t3, 2720($t0)		# paint the unit on row 21, column 8, color 3
	sw	$t3, 2736($t0)		# paint the unit on row 21, column 12, color 3
	sw	$t3, 2740($t0)		# paint the unit on row 21, column 13, color 3
	sw	$t3, 2744($t0)		# paint the unit on row 21, column 14, color 3
	sw	$t3, 2752($t0)		# paint the unit on row 21, column 16, color 3
	sw	$t3, 2756($t0)		# paint the unit on row 21, column 17, color 3
	sw	$t3, 2760($t0)		# paint the unit on row 21, column 18, color 3
	sw	$t3, 2772($t0)		# paint the unit on row 21, column 21, color 3
	sw	$t3, 2776($t0)		# paint the unit on row 21, column 22, color 3
	sw	$t3, 2780($t0)		# paint the unit on row 21, column 23, color 3
	sw	$t3, 2820($t0)		# paint the unit on row 22, column 1, color 3
	sw	$t3, 2832($t0)		# paint the unit on row 22, column 4, color 3
	sw	$t3, 2840($t0)		# paint the unit on row 22, column 6, color 3
	sw	$t3, 2852($t0)		# paint the unit on row 22, column 9, color 3
	sw	$t3, 2860($t0)		# paint the unit on row 22, column 11, color 3
	sw	$t3, 2880($t0)		# paint the unit on row 22, column 16, color 3
	sw	$t3, 2892($t0)		# paint the unit on row 22, column 19, color 3
	sw	$t3, 2900($t0)		# paint the unit on row 22, column 21, color 3
	sw	$t3, 2912($t0)		# paint the unit on row 22, column 24, color 3
	sw	$t3, 2948($t0)		# paint the unit on row 23, column 1, color 3
	sw	$t3, 2960($t0)		# paint the unit on row 23, column 4, color 3
	sw	$t3, 2968($t0)		# paint the unit on row 23, column 6, color 3
	sw	$t3, 2980($t0)		# paint the unit on row 23, column 9, color 3
	sw	$t3, 2992($t0)		# paint the unit on row 23, column 12, color 3
	sw	$t3, 2996($t0)		# paint the unit on row 23, column 13, color 3
	sw	$t3, 3008($t0)		# paint the unit on row 23, column 16, color 3
	sw	$t3, 3020($t0)		# paint the unit on row 23, column 19, color 3
	sw	$t3, 3028($t0)		# paint the unit on row 23, column 21, color 3
	sw	$t3, 3032($t0)		# paint the unit on row 23, column 22, color 3
	sw	$t3, 3036($t0)		# paint the unit on row 23, column 23, color 3
	sw	$t3, 3076($t0)		# paint the unit on row 24, column 1, color 3
	sw	$t3, 3080($t0)		# paint the unit on row 24, column 2, color 3
	sw	$t3, 3084($t0)		# paint the unit on row 24, column 3, color 3
	sw	$t3, 3088($t0)		# paint the unit on row 24, column 4, color 3
	sw	$t3, 3096($t0)		# paint the unit on row 24, column 6, color 3
	sw	$t3, 3100($t0)		# paint the unit on row 24, column 7, color 3
	sw	$t3, 3104($t0)		# paint the unit on row 24, column 8, color 3
	sw	$t3, 3108($t0)		# paint the unit on row 24, column 9, color 3
	sw	$t3, 3128($t0)		# paint the unit on row 24, column 14, color 3
	sw	$t3, 3136($t0)		# paint the unit on row 24, column 16, color 3
	sw	$t3, 3148($t0)		# paint the unit on row 24, column 19, color 3
	sw	$t3, 3156($t0)		# paint the unit on row 24, column 21, color 3
	sw	$t3, 3204($t0)		# paint the unit on row 25, column 1, color 3
	sw	$t3, 3216($t0)		# paint the unit on row 25, column 4, color 3
	sw	$t3, 3224($t0)		# paint the unit on row 25, column 6, color 3
	sw	$t3, 3236($t0)		# paint the unit on row 25, column 9, color 3
	sw	$t3, 3244($t0)		# paint the unit on row 25, column 11, color 3
	sw	$t3, 3248($t0)		# paint the unit on row 25, column 12, color 3
	sw	$t3, 3252($t0)		# paint the unit on row 25, column 13, color 3
	sw	$t3, 3264($t0)		# paint the unit on row 25, column 16, color 3
	sw	$t3, 3268($t0)		# paint the unit on row 25, column 17, color 3
	sw	$t3, 3272($t0)		# paint the unit on row 25, column 18, color 3
	sw	$t3, 3284($t0)		# paint the unit on row 25, column 21, color 3
	jr	$ra			# exit()

eraseStartScreen:				# erase the start screen
	lw	$t0, displayAddress	# $t0 stores the base address for display
	sw	$0, 396($t0)		# erase the unit on row 3, column 3, color 1
	sw	$0, 400($t0)		# erase the unit on row 3, column 4, color 1
	sw	$0, 412($t0)		# erase the unit on row 3, column 7, color 1
	sw	$0, 416($t0)		# erase the unit on row 3, column 8, color 1
	sw	$0, 420($t0)		# erase the unit on row 3, column 9, color 1
	sw	$0, 424($t0)		# erase the unit on row 3, column 10, color 1
	sw	$0, 428($t0)		# erase the unit on row 3, column 11, color 1
	sw	$0, 440($t0)		# erase the unit on row 3, column 14, color 1
	sw	$0, 444($t0)		# erase the unit on row 3, column 15, color 1
	sw	$0, 456($t0)		# erase the unit on row 3, column 18, color 1
	sw	$0, 460($t0)		# erase the unit on row 3, column 19, color 1
	sw	$0, 464($t0)		# erase the unit on row 3, column 20, color 1
	sw	$0, 476($t0)		# erase the unit on row 3, column 23, color 1
	sw	$0, 480($t0)		# erase the unit on row 3, column 24, color 1
	sw	$0, 484($t0)		# erase the unit on row 3, column 25, color 1
	sw	$0, 488($t0)		# erase the unit on row 3, column 26, color 1
	sw	$0, 492($t0)		# erase the unit on row 3, column 27, color 1
	sw	$0, 520($t0)		# erase the unit on row 4, column 2, color 1
	sw	$0, 532($t0)		# erase the unit on row 4, column 5, color 1
	sw	$0, 548($t0)		# erase the unit on row 4, column 9, color 1
	sw	$0, 564($t0)		# erase the unit on row 4, column 13, color 1
	sw	$0, 576($t0)		# erase the unit on row 4, column 16, color 1
	sw	$0, 584($t0)		# erase the unit on row 4, column 18, color 1
	sw	$0, 596($t0)		# erase the unit on row 4, column 21, color 1
	sw	$0, 612($t0)		# erase the unit on row 4, column 25, color 1
	sw	$0, 628($t0)		# erase the unit on row 4, column 29, color 1
	sw	$0, 652($t0)		# erase the unit on row 5, column 3, color 1
	sw	$0, 676($t0)		# erase the unit on row 5, column 9, color 1
	sw	$0, 692($t0)		# erase the unit on row 5, column 13, color 1
	sw	$0, 704($t0)		# erase the unit on row 5, column 16, color 1
	sw	$0, 712($t0)		# erase the unit on row 5, column 18, color 1
	sw	$0, 716($t0)		# erase the unit on row 5, column 19, color 1
	sw	$0, 720($t0)		# erase the unit on row 5, column 20, color 1
	sw	$0, 740($t0)		# erase the unit on row 5, column 25, color 1
	sw	$0, 784($t0)		# erase the unit on row 6, column 4, color 1
	sw	$0, 804($t0)		# erase the unit on row 6, column 9, color 1
	sw	$0, 820($t0)		# erase the unit on row 6, column 13, color 1
	sw	$0, 824($t0)		# erase the unit on row 6, column 14, color 1
	sw	$0, 828($t0)		# erase the unit on row 6, column 15, color 1
	sw	$0, 832($t0)		# erase the unit on row 6, column 16, color 1
	sw	$0, 840($t0)		# erase the unit on row 6, column 18, color 1
	sw	$0, 848($t0)		# erase the unit on row 6, column 20, color 1
	sw	$0, 868($t0)		# erase the unit on row 6, column 25, color 1
	sw	$0, 904($t0)		# erase the unit on row 7, column 2, color 1
	sw	$0, 916($t0)		# erase the unit on row 7, column 5, color 1
	sw	$0, 932($t0)		# erase the unit on row 7, column 9, color 1
	sw	$0, 948($t0)		# erase the unit on row 7, column 13, color 1
	sw	$0, 960($t0)		# erase the unit on row 7, column 16, color 1
	sw	$0, 968($t0)		# erase the unit on row 7, column 18, color 1
	sw	$0, 980($t0)		# erase the unit on row 7, column 21, color 1
	sw	$0, 996($t0)		# erase the unit on row 7, column 25, color 1
	sw	$0, 1012($t0)		# erase the unit on row 7, column 29, color 1
	sw	$0, 1036($t0)		# erase the unit on row 8, column 3, color 1
	sw	$0, 1040($t0)		# erase the unit on row 8, column 4, color 1
	sw	$0, 1060($t0)		# erase the unit on row 8, column 9, color 1
	sw	$0, 1076($t0)		# erase the unit on row 8, column 13, color 1
	sw	$0, 1088($t0)		# erase the unit on row 8, column 16, color 1
	sw	$0, 1096($t0)		# erase the unit on row 8, column 18, color 1
	sw	$0, 1108($t0)		# erase the unit on row 8, column 21, color 1
	sw	$0, 1124($t0)		# erase the unit on row 8, column 25, color 1
	sw	$0, 1284($t0)		# erase the unit on row 10, column 1, color 2
	sw	$0, 1288($t0)		# erase the unit on row 10, column 2, color 2
	sw	$0, 1296($t0)		# erase the unit on row 10, column 4, color 2
	sw	$0, 1300($t0)		# erase the unit on row 10, column 5, color 2
	sw	$0, 1308($t0)		# erase the unit on row 10, column 7, color 2
	sw	$0, 1312($t0)		# erase the unit on row 10, column 8, color 2
	sw	$0, 1316($t0)		# erase the unit on row 10, column 9, color 2
	sw	$0, 1324($t0)		# erase the unit on row 10, column 11, color 2
	sw	$0, 1328($t0)		# erase the unit on row 10, column 12, color 2
	sw	$0, 1336($t0)		# erase the unit on row 10, column 14, color 2
	sw	$0, 1340($t0)		# erase the unit on row 10, column 15, color 2
	sw	$0, 1352($t0)		# erase the unit on row 10, column 18, color 2
	sw	$0, 1364($t0)		# erase the unit on row 10, column 21, color 2
	sw	$0, 1376($t0)		# erase the unit on row 10, column 24, color 2
	sw	$0, 1380($t0)		# erase the unit on row 10, column 25, color 2
	sw	$0, 1384($t0)		# erase the unit on row 10, column 26, color 2
	sw	$0, 1388($t0)		# erase the unit on row 10, column 27, color 2
	sw	$0, 1396($t0)		# erase the unit on row 10, column 29, color 2
	sw	$0, 1412($t0)		# erase the unit on row 11, column 1, color 2
	sw	$0, 1420($t0)		# erase the unit on row 11, column 3, color 2
	sw	$0, 1424($t0)		# erase the unit on row 11, column 4, color 2
	sw	$0, 1432($t0)		# erase the unit on row 11, column 6, color 2
	sw	$0, 1436($t0)		# erase the unit on row 11, column 7, color 2
	sw	$0, 1448($t0)		# erase the unit on row 11, column 10, color 2
	sw	$0, 1460($t0)		# erase the unit on row 11, column 13, color 2
	sw	$0, 1476($t0)		# erase the unit on row 11, column 17, color 2
	sw	$0, 1484($t0)		# erase the unit on row 11, column 19, color 2
	sw	$0, 1492($t0)		# erase the unit on row 11, column 21, color 2
	sw	$0, 1500($t0)		# erase the unit on row 11, column 23, color 2
	sw	$0, 1504($t0)		# erase the unit on row 11, column 24, color 2
	sw	$0, 1520($t0)		# erase the unit on row 11, column 28, color 2
	sw	$0, 1540($t0)		# erase the unit on row 12, column 1, color 2
	sw	$0, 1544($t0)		# erase the unit on row 12, column 2, color 2
	sw	$0, 1552($t0)		# erase the unit on row 12, column 4, color 2
	sw	$0, 1556($t0)		# erase the unit on row 12, column 5, color 2
	sw	$0, 1564($t0)		# erase the unit on row 12, column 7, color 2
	sw	$0, 1568($t0)		# erase the unit on row 12, column 8, color 2
	sw	$0, 1572($t0)		# erase the unit on row 12, column 9, color 2
	sw	$0, 1580($t0)		# erase the unit on row 12, column 11, color 2
	sw	$0, 1592($t0)		# erase the unit on row 12, column 14, color 2
	sw	$0, 1604($t0)		# erase the unit on row 12, column 17, color 2
	sw	$0, 1608($t0)		# erase the unit on row 12, column 18, color 2
	sw	$0, 1612($t0)		# erase the unit on row 12, column 19, color 2
	sw	$0, 1620($t0)		# erase the unit on row 12, column 21, color 2
	sw	$0, 1624($t0)		# erase the unit on row 12, column 22, color 2
	sw	$0, 1632($t0)		# erase the unit on row 12, column 24, color 2
	sw	$0, 1636($t0)		# erase the unit on row 12, column 25, color 2
	sw	$0, 1640($t0)		# erase the unit on row 12, column 26, color 2
	sw	$0, 1648($t0)		# erase the unit on row 12, column 28, color 2
	sw	$0, 1668($t0)		# erase the unit on row 13, column 1, color 2
	sw	$0, 1680($t0)		# erase the unit on row 13, column 4, color 2
	sw	$0, 1688($t0)		# erase the unit on row 13, column 6, color 2
	sw	$0, 1692($t0)		# erase the unit on row 13, column 7, color 2
	sw	$0, 1712($t0)		# erase the unit on row 13, column 12, color 2
	sw	$0, 1724($t0)		# erase the unit on row 13, column 15, color 2
	sw	$0, 1732($t0)		# erase the unit on row 13, column 17, color 2
	sw	$0, 1740($t0)		# erase the unit on row 13, column 19, color 2
	sw	$0, 1748($t0)		# erase the unit on row 13, column 21, color 2
	sw	$0, 1756($t0)		# erase the unit on row 13, column 23, color 2
	sw	$0, 1760($t0)		# erase the unit on row 13, column 24, color 2
	sw	$0, 1776($t0)		# erase the unit on row 13, column 28, color 2
	sw	$0, 1796($t0)		# erase the unit on row 14, column 1, color 2
	sw	$0, 1808($t0)		# erase the unit on row 14, column 4, color 2
	sw	$0, 1816($t0)		# erase the unit on row 14, column 6, color 2
	sw	$0, 1820($t0)		# erase the unit on row 14, column 7, color 2
	sw	$0, 1824($t0)		# erase the unit on row 14, column 8, color 2
	sw	$0, 1828($t0)		# erase the unit on row 14, column 9, color 2
	sw	$0, 1832($t0)		# erase the unit on row 14, column 10, color 2
	sw	$0, 1836($t0)		# erase the unit on row 14, column 11, color 2
	sw	$0, 1844($t0)		# erase the unit on row 14, column 13, color 2
	sw	$0, 1848($t0)		# erase the unit on row 14, column 14, color 2
	sw	$0, 1860($t0)		# erase the unit on row 14, column 17, color 2
	sw	$0, 1868($t0)		# erase the unit on row 14, column 19, color 2
	sw	$0, 1876($t0)		# erase the unit on row 14, column 21, color 2
	sw	$0, 1884($t0)		# erase the unit on row 14, column 23, color 2
	sw	$0, 1888($t0)		# erase the unit on row 14, column 24, color 2
	sw	$0, 1892($t0)		# erase the unit on row 14, column 25, color 2
	sw	$0, 1896($t0)		# erase the unit on row 14, column 26, color 2
	sw	$0, 1904($t0)		# erase the unit on row 14, column 28, color 2
	sw	$0, 1912($t0)		# erase the unit on row 14, column 30, color 2
	sw	$0, 2056($t0)		# erase the unit on row 16, column 2, color 3
	sw	$0, 2060($t0)		# erase the unit on row 16, column 3, color 3
	sw	$0, 2080($t0)		# erase the unit on row 16, column 8, color 3
	sw	$0, 2096($t0)		# erase the unit on row 16, column 12, color 3
	sw	$0, 2100($t0)		# erase the unit on row 16, column 13, color 3
	sw	$0, 2120($t0)		# erase the unit on row 16, column 18, color 3
	sw	$0, 2132($t0)		# erase the unit on row 16, column 21, color 3
	sw	$0, 2136($t0)		# erase the unit on row 16, column 22, color 3
	sw	$0, 2140($t0)		# erase the unit on row 16, column 23, color 3
	sw	$0, 2180($t0)		# erase the unit on row 17, column 1, color 3
	sw	$0, 2184($t0)		# erase the unit on row 17, column 2, color 3
	sw	$0, 2188($t0)		# erase the unit on row 17, column 3, color 3
	sw	$0, 2192($t0)		# erase the unit on row 17, column 4, color 3
	sw	$0, 2200($t0)		# erase the unit on row 17, column 6, color 3
	sw	$0, 2204($t0)		# erase the unit on row 17, column 7, color 3
	sw	$0, 2208($t0)		# erase the unit on row 17, column 8, color 3
	sw	$0, 2212($t0)		# erase the unit on row 17, column 9, color 3
	sw	$0, 2224($t0)		# erase the unit on row 17, column 12, color 3
	sw	$0, 2228($t0)		# erase the unit on row 17, column 13, color 3
	sw	$0, 2240($t0)		# erase the unit on row 17, column 16, color 3
	sw	$0, 2244($t0)		# erase the unit on row 17, column 17, color 3
	sw	$0, 2248($t0)		# erase the unit on row 17, column 18, color 3
	sw	$0, 2252($t0)		# erase the unit on row 17, column 19, color 3
	sw	$0, 2260($t0)		# erase the unit on row 17, column 21, color 3
	sw	$0, 2272($t0)		# erase the unit on row 17, column 24, color 3
	sw	$0, 2312($t0)		# erase the unit on row 18, column 2, color 3
	sw	$0, 2316($t0)		# erase the unit on row 18, column 3, color 3
	sw	$0, 2328($t0)		# erase the unit on row 18, column 6, color 3
	sw	$0, 2332($t0)		# erase the unit on row 18, column 7, color 3
	sw	$0, 2336($t0)		# erase the unit on row 18, column 8, color 3
	sw	$0, 2340($t0)		# erase the unit on row 18, column 9, color 3
	sw	$0, 2348($t0)		# erase the unit on row 18, column 11, color 3
	sw	$0, 2352($t0)		# erase the unit on row 18, column 12, color 3
	sw	$0, 2356($t0)		# erase the unit on row 18, column 13, color 3
	sw	$0, 2360($t0)		# erase the unit on row 18, column 14, color 3
	sw	$0, 2368($t0)		# erase the unit on row 18, column 16, color 3
	sw	$0, 2372($t0)		# erase the unit on row 18, column 17, color 3
	sw	$0, 2376($t0)		# erase the unit on row 18, column 18, color 3
	sw	$0, 2380($t0)		# erase the unit on row 18, column 19, color 3
	sw	$0, 2388($t0)		# erase the unit on row 18, column 21, color 3
	sw	$0, 2392($t0)		# erase the unit on row 18, column 22, color 3
	sw	$0, 2396($t0)		# erase the unit on row 18, column 23, color 3
	sw	$0, 2440($t0)		# erase the unit on row 19, column 2, color 3
	sw	$0, 2444($t0)		# erase the unit on row 19, column 3, color 3
	sw	$0, 2464($t0)		# erase the unit on row 19, column 8, color 3
	sw	$0, 2480($t0)		# erase the unit on row 19, column 12, color 3
	sw	$0, 2484($t0)		# erase the unit on row 19, column 13, color 3
	sw	$0, 2504($t0)		# erase the unit on row 19, column 18, color 3
	sw	$0, 2516($t0)		# erase the unit on row 19, column 21, color 3
	sw	$0, 2528($t0)		# erase the unit on row 19, column 24, color 3
	sw	$0, 2692($t0)		# erase the unit on row 21, column 1, color 3
	sw	$0, 2704($t0)		# erase the unit on row 21, column 4, color 3
	sw	$0, 2716($t0)		# erase the unit on row 21, column 7, color 3
	sw	$0, 2720($t0)		# erase the unit on row 21, column 8, color 3
	sw	$0, 2736($t0)		# erase the unit on row 21, column 12, color 3
	sw	$0, 2740($t0)		# erase the unit on row 21, column 13, color 3
	sw	$0, 2744($t0)		# erase the unit on row 21, column 14, color 3
	sw	$0, 2752($t0)		# erase the unit on row 21, column 16, color 3
	sw	$0, 2756($t0)		# erase the unit on row 21, column 17, color 3
	sw	$0, 2760($t0)		# erase the unit on row 21, column 18, color 3
	sw	$0, 2772($t0)		# erase the unit on row 21, column 21, color 3
	sw	$0, 2776($t0)		# erase the unit on row 21, column 22, color 3
	sw	$0, 2780($t0)		# erase the unit on row 21, column 23, color 3
	sw	$0, 2820($t0)		# erase the unit on row 22, column 1, color 3
	sw	$0, 2832($t0)		# erase the unit on row 22, column 4, color 3
	sw	$0, 2840($t0)		# erase the unit on row 22, column 6, color 3
	sw	$0, 2852($t0)		# erase the unit on row 22, column 9, color 3
	sw	$0, 2860($t0)		# erase the unit on row 22, column 11, color 3
	sw	$0, 2880($t0)		# erase the unit on row 22, column 16, color 3
	sw	$0, 2892($t0)		# erase the unit on row 22, column 19, color 3
	sw	$0, 2900($t0)		# erase the unit on row 22, column 21, color 3
	sw	$0, 2912($t0)		# erase the unit on row 22, column 24, color 3
	sw	$0, 2948($t0)		# erase the unit on row 23, column 1, color 3
	sw	$0, 2960($t0)		# erase the unit on row 23, column 4, color 3
	sw	$0, 2968($t0)		# erase the unit on row 23, column 6, color 3
	sw	$0, 2980($t0)		# erase the unit on row 23, column 9, color 3
	sw	$0, 2992($t0)		# erase the unit on row 23, column 12, color 3
	sw	$0, 2996($t0)		# erase the unit on row 23, column 13, color 3
	sw	$0, 3008($t0)		# erase the unit on row 23, column 16, color 3
	sw	$0, 3020($t0)		# erase the unit on row 23, column 19, color 3
	sw	$0, 3028($t0)		# erase the unit on row 23, column 21, color 3
	sw	$0, 3032($t0)		# erase the unit on row 23, column 22, color 3
	sw	$0, 3036($t0)		# erase the unit on row 23, column 23, color 3
	sw	$0, 3076($t0)		# erase the unit on row 24, column 1, color 3
	sw	$0, 3080($t0)		# erase the unit on row 24, column 2, color 3
	sw	$0, 3084($t0)		# erase the unit on row 24, column 3, color 3
	sw	$0, 3088($t0)		# erase the unit on row 24, column 4, color 3
	sw	$0, 3096($t0)		# erase the unit on row 24, column 6, color 3
	sw	$0, 3100($t0)		# erase the unit on row 24, column 7, color 3
	sw	$0, 3104($t0)		# erase the unit on row 24, column 8, color 3
	sw	$0, 3108($t0)		# erase the unit on row 24, column 9, color 3
	sw	$0, 3128($t0)		# erase the unit on row 24, column 14, color 3
	sw	$0, 3136($t0)		# erase the unit on row 24, column 16, color 3
	sw	$0, 3148($t0)		# erase the unit on row 24, column 19, color 3
	sw	$0, 3156($t0)		# erase the unit on row 24, column 21, color 3
	sw	$0, 3204($t0)		# erase the unit on row 25, column 1, color 3
	sw	$0, 3216($t0)		# erase the unit on row 25, column 4, color 3
	sw	$0, 3224($t0)		# erase the unit on row 25, column 6, color 3
	sw	$0, 3236($t0)		# erase the unit on row 25, column 9, color 3
	sw	$0, 3244($t0)		# erase the unit on row 25, column 11, color 3
	sw	$0, 3248($t0)		# erase the unit on row 25, column 12, color 3
	sw	$0, 3252($t0)		# erase the unit on row 25, column 13, color 3
	sw	$0, 3264($t0)		# erase the unit on row 25, column 16, color 3
	sw	$0, 3268($t0)		# erase the unit on row 25, column 17, color 3
	sw	$0, 3272($t0)		# erase the unit on row 25, column 18, color 3
	sw	$0, 3284($t0)		# erase the unit on row 25, column 21, color 3
	jr	$ra			# exit()

drawSpaceship:
	lw	$t0, displayAddress		# draw the spaceship according to its position in row and column
	lw	$t1, shipRow			# load row of space ship
	sll	$t1, $t1, 7			# get offset by rows
	lw	$t2, shipColumn			# load column of the ship
	sll	$t2, $t2, 2			# get offset by columns
	add	$t0, $t0, $t1			# calculate the start point of printing for spaceship
	add	$t0, $t0, $t2
	
	li	$t1, 0x9e9e9e			# $t1 stores the light grey color code
	li	$t2, 0x464646			# $t2 stores the dark grey color code
	li	$t3, 0xffd266			# $t3 stores the yellow color code
	sw	$t2, 4($t0)			# paint the unit on row 0, column 1, color 2
	sw	$t2, 8($t0)			# paint the unit on row 0, column 2, color 2
	sw	$t1, 128($t0)			# paint the unit on row 1, column 0, color 1
	sw	$t1, 132($t0)			# paint the unit on row 1, column 1, color 1
	sw	$t1, 136($t0)			# paint the unit on row 1, column 2, color 1
	sw	$t1, 140($t0)			# paint the unit on row 1, column 3, color 1
	sw	$t1, 256($t0)			# paint the unit on row 2, column 0, color 1
	sw	$t1, 260($t0)			# paint the unit on row 2, column 1, color 1
	sw	$t1, 264($t0)			# paint the unit on row 2, column 2, color 1
	sw	$t1, 388($t0)			# paint the unit on row 3, column 1, color 1
	
	jr	$ra				# exit()

eraseSpaceship:					# erase the spaceship
	lw	$t0, displayAddress		# get the spaceship position as target memory address
	lw	$t1, shipRow			# load row of space ship
	sll	$t1, $t1, 7			# get offset by rows
	lw	$t2, shipColumn			# load column of the ship
	sll	$t2, $t2, 2			# get offset by columns
	add	$t0, $t0, $t1			# calculate the start point of printing for spaceship
	add	$t0, $t0, $t2
	
	sw	$0, 4($t0)			# erase the unit on row 0, column 1, color 2
	sw	$0, 8($t0)			# erase the unit on row 0, column 2, color 2
	sw	$0, 128($t0)			# erase the unit on row 1, column 0, color 1
	sw	$0, 132($t0)			# erase the unit on row 1, column 1, color 1
	sw	$0, 136($t0)			# erase the unit on row 1, column 2, color 1
	sw	$0, 140($t0)			# erase the unit on row 1, column 3, color 1
	sw	$0, 256($t0)			# erase the unit on row 2, column 0, color 1
	sw	$0, 260($t0)			# erase the unit on row 2, column 1, color 1
	sw	$0, 264($t0)			# erase the unit on row 2, column 2, color 1
	sw	$0, 388($t0)			# erase the unit on row 3, column 1, color 1
	
	jr	$ra				# exit()

drawObstacle:	
	lw	$t1, displayAddress
	li	$t4, 0				# i = 0
	mul	$t5, $s2, 4			# get total number of obstacles according to difficulty
	condDrawObstacleLoop:
	bge	$t4, $t5, endDrawObstacleLoop
	bodyDrawObstacleLoop:
	sll	$t6, $t4, 2
	lw	$t7, obstacleType($t6)
	lw	$t8, obstacleRow($t6)
	lw	$t9, obstacleColumn($t6)
	
	bge	$t9, 32, addIDrawObstacleLoop
	
	sll	$t8, $t8, 7
	sll	$t9, $t9, 2
	add	$t0, $t8, $t9
	add	$t0, $t0, $t1
	
	li	$t3, 0xffd266			# $t3 stores the yellow color code
	li	$t2, 0x9e9e9e			# $t1 stores the light grey color code
	li	$t8, 0x464646			# $t2 stores the dark grey color code
	li	$t9, 0
	C1:					# check for collision
	lw	$t7, 0($t0)
	beq	$t7, $t2, H1
	beq	$t7, $t8, H1
	sw	$t3, 0($t0)			# paint the unit on row 0, column 0, color 3
	j	C2
	H1:
	addi	$t9, $t9, 1			# record one hit
	
	C2:					# check for collision
	lw	$t7, 128($t0)
	beq	$t7, $t2, H2
	beq	$t7, $t8, H2
	sw	$t3, 128($t0)			# paint the unit on row 1, column 0, color 3
	j	C3
	H2:
	addi	$t9, $t9, 1			# record one hit
	
	C3:					# check for collision
	lw	$t7, 256($t0)
	beq	$t7, $t2, H3
	beq	$t7, $t8, H3
	sw	$t3, 256($t0)			# paint the unit on row 2, column 0, color 3
	j	C4
	H3:
	addi	$t9, $t9, 1			# record one hit
	
	C4:					# check for collision
	lw	$t7, 384($t0)
	beq	$t7, $t2, H4
	beq	$t7, $t8, H4
	sw	$t3, 384($t0)			# paint the unit on row 0, column 0, color 3
	j	afterCheckDrawObstacleLoop
	H4:
	addi	$t9, $t9, 1			# record one hit
	
	afterCheckDrawObstacleLoop:
	beqz	$t9, addIDrawObstacleLoop
	addi	$s3, $s3, 1			# one collision, add one to the damage $s3
						# erase the obstacle drew and generate new again
	sw	$0, 0($t0)			# erase the unit on row 0, column 0, color 3
	sw	$0, 128($t0)			# erase the unit on row 1, column 0, color 3
	sw	$0, 256($t0)			# erase the unit on row 2, column 0, color 3
	sw	$0, 384($t0)			# erase the unit on row 3, column 0, color 3
	
	li 	$v0, 42         	# Service 42, random int range
	li 	$a0, 0          	# Select random generator 0
	li 	$a1, 28	   		# Select upper bound of random number
	syscall            		# Generate random int (returns in $a0)
	
	addi	$t7, $a0, 0		# get row position in $t7
		
	#li 	$v0, 42         	# Service 42, random int range
	#li 	$a0, 0          	# Select random generator 0
	#addi	$a1, $0, 0		# Biggest possible type will be difficulty - 1
	#syscall            		# Generate random int (returns in $a0)
	
	addi	$t5, $0, 0		# get type in $t5
		
	sw	$t5, obstacleType($t6)
	li	$t8, 31
	sw	$t8, obstacleColumn($t6)
	sw	$t7, obstacleRow($t6)
	
	addIDrawObstacleLoop:
	addi	$t4, $t4, 1			# i += 1
	j	condDrawObstacleLoop
	
	endDrawObstacleLoop:
	jr	$ra
	
eraseObstacle:					# erase obstacles
	lw	$t1, displayAddress		# draw the obstacle according to given type and position
	li	$t4, 0				# i = 0
	move	$t5, $s2			# get total number of obstacles according to difficulty
	sll	$t5, $t5, 2
	condEraseObstacleLoop:
	bge	$t4, 4, endDrawObstacleLoop
	bodyEraseObstacleLoop:
	sll	$t6, $t4, 2			# get the position in memory for the obstacle
	lw	$t7, obstacleType($t6)
	lw	$t8, obstacleRow($t6)
	lw	$t9, obstacleColumn($t6)
	sll	$t8, $t8, 7
	sll	$t9, $t9, 2
	add	$t8, $t8, $t9
	add	$t0, $t1, $t8
	
	sw	$0, 0($t0)			# erase the unit on row 0, column 0, color 3
	sw	$0, 128($t0)			# erase the unit on row 1, column 0, color 3
	sw	$0, 256($t0)			# erase the unit on row 2, column 0, color 3
	sw	$0, 384($t0)			# erase the unit on row 3, column 0, color 3
	
	addi	$t4, $t4, 1			# i += 1
	j	condEraseObstacleLoop
	
	endEraseObstacleLoop:
	jr	$ra
	
drawStatusBar:					# draw health points
	lw	$t0, displayAddress
	li	$t3, 0xff95b5			# store the color of bright red for health points
	
	beq	$s1, 0, endDrawStatusBar	# if health != 0, draw 1 half
	sw	$t3, 4($t0)
	sw	$t3, 128($t0)
	sw	$t3, 132($t0)
	sw	$t3, 256($t0)
	sw	$t3, 260($t0)
	sw	$t3, 388($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 1, endDrawStatusBar	# if health != 1, draw 2 halves
	sw	$t3, 0($t0)
	sw	$t3, 128($t0)
	sw	$t3, 132($t0)
	sw	$t3, 256($t0)
	sw	$t3, 260($t0)
	sw	$t3, 384($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 2, endDrawStatusBar	# if health > 2, draw 3 halves
	sw	$t3, 4($t0)
	sw	$t3, 128($t0)
	sw	$t3, 132($t0)
	sw	$t3, 256($t0)
	sw	$t3, 260($t0)
	sw	$t3, 388($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 3, endDrawStatusBar	# if health > 3, draw 4 halves
	sw	$t3, 0($t0)
	sw	$t3, 128($t0)
	sw	$t3, 132($t0)
	sw	$t3, 256($t0)
	sw	$t3, 260($t0)
	sw	$t3, 384($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 4, endDrawStatusBar	# if health > 4, draw 5 halves
	sw	$t3, 4($t0)
	sw	$t3, 128($t0)
	sw	$t3, 132($t0)
	sw	$t3, 256($t0)
	sw	$t3, 260($t0)
	sw	$t3, 388($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 5, endDrawStatusBar	# if health > 5, draw 6 halves
	sw	$t3, 0($t0)
	sw	$t3, 128($t0)
	sw	$t3, 132($t0)
	sw	$t3, 256($t0)
	sw	$t3, 260($t0)
	sw	$t3, 384($t0)
	addi	$t0, $t0, 8
	
	endDrawStatusBar:
	jr	$ra

eraseStatusBar:					# erase health points
	lw	$t0, displayAddress
	
	beq	$s1, 0, endEraseStatusBar	# if health != 0, erase 1 half
	sw	$0, 4($t0)
	sw	$0, 128($t0)
	sw	$0, 132($t0)
	sw	$0, 256($t0)
	sw	$0, 260($t0)
	sw	$0, 388($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 1, endEraseStatusBar	# if health != 1, erase 2 halves
	sw	$0, 0($t0)
	sw	$0, 128($t0)
	sw	$0, 132($t0)
	sw	$0, 256($t0)
	sw	$0, 260($t0)
	sw	$0, 384($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 2, endEraseStatusBar	# if health > 2, erase 3 halves
	sw	$0, 4($t0)
	sw	$0, 128($t0)
	sw	$0, 132($t0)
	sw	$0, 256($t0)
	sw	$0, 260($t0)
	sw	$0, 388($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 3, endEraseStatusBar	# if health > 3, erase 4 halves
	sw	$0, 0($t0)
	sw	$0, 128($t0)
	sw	$0, 132($t0)
	sw	$0, 256($t0)
	sw	$0, 260($t0)
	sw	$0, 384($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 4, endEraseStatusBar	# if health > 4, erase 5 halves
	sw	$0, 4($t0)
	sw	$0, 128($t0)
	sw	$0, 132($t0)
	sw	$0, 256($t0)
	sw	$0, 260($t0)
	sw	$0, 388($t0)
	addi	$t0, $t0, 8
	
	beq	$s1, 5, endEraseStatusBar	# if health > 5, erase 6 halves
	sw	$0, 0($t0)
	sw	$0, 128($t0)
	sw	$0, 132($t0)
	sw	$0, 256($t0)
	sw	$0, 260($t0)
	sw	$0, 384($t0)
	addi	$t0, $t0, 8
	
	endEraseStatusBar:
	jr	$ra

drawEndScreen:					# draw the end of game screen
	lw	$t0, displayAddress	# $t0 stores the base address for display
	li	$t1, 0x9e9e9e		# $t1 stores the light grey color code
	li	$t2, 0x464646		# $t2 stores the dark grey color code
	li	$t3, 0xffd266		# $t3 stores the yellow color code
	sw	$t1, 136($t0)		#paint the unit on row 1, column 2, color 1
	sw	$t1, 140($t0)		#paint the unit on row 1, column 3, color 1
	sw	$t1, 144($t0)		#paint the unit on row 1, column 4, color 1
	sw	$t1, 160($t0)		#paint the unit on row 1, column 8, color 1
	sw	$t1, 164($t0)		#paint the unit on row 1, column 9, color 1
	sw	$t1, 168($t0)		#paint the unit on row 1, column 10, color 1
	sw	$t1, 180($t0)		#paint the unit on row 1, column 13, color 1
	sw	$t1, 196($t0)		#paint the unit on row 1, column 17, color 1
	sw	$t1, 204($t0)		#paint the unit on row 1, column 19, color 1
	sw	$t1, 208($t0)		#paint the unit on row 1, column 20, color 1
	sw	$t1, 212($t0)		#paint the unit on row 1, column 21, color 1
	sw	$t1, 216($t0)		#paint the unit on row 1, column 22, color 1
	sw	$t1, 220($t0)		#paint the unit on row 1, column 23, color 1
	sw	$t1, 260($t0)		#paint the unit on row 2, column 1, color 1
	sw	$t1, 276($t0)		#paint the unit on row 2, column 5, color 1
	sw	$t1, 284($t0)		#paint the unit on row 2, column 7, color 1
	sw	$t1, 300($t0)		#paint the unit on row 2, column 11, color 1
	sw	$t1, 308($t0)		#paint the unit on row 2, column 13, color 1
	sw	$t1, 312($t0)		#paint the unit on row 2, column 14, color 1
	sw	$t1, 320($t0)		#paint the unit on row 2, column 16, color 1
	sw	$t1, 324($t0)		#paint the unit on row 2, column 17, color 1
	sw	$t1, 332($t0)		#paint the unit on row 2, column 19, color 1
	sw	$t1, 388($t0)		#paint the unit on row 3, column 1, color 1
	sw	$t1, 412($t0)		#paint the unit on row 3, column 7, color 1
	sw	$t1, 428($t0)		#paint the unit on row 3, column 11, color 1
	sw	$t1, 436($t0)		#paint the unit on row 3, column 13, color 1
	sw	$t1, 444($t0)		#paint the unit on row 3, column 15, color 1
	sw	$t1, 452($t0)		#paint the unit on row 3, column 17, color 1
	sw	$t1, 460($t0)		#paint the unit on row 3, column 19, color 1
	sw	$t1, 464($t0)		#paint the unit on row 3, column 20, color 1
	sw	$t1, 468($t0)		#paint the unit on row 3, column 21, color 1
	sw	$t1, 472($t0)		#paint the unit on row 3, column 22, color 1
	sw	$t1, 476($t0)		#paint the unit on row 3, column 23, color 1
	sw	$t1, 516($t0)		#paint the unit on row 4, column 1, color 1
	sw	$t1, 524($t0)		#paint the unit on row 4, column 3, color 1
	sw	$t1, 528($t0)		#paint the unit on row 4, column 4, color 1
	sw	$t1, 532($t0)		#paint the unit on row 4, column 5, color 1
	sw	$t1, 540($t0)		#paint the unit on row 4, column 7, color 1
	sw	$t1, 544($t0)		#paint the unit on row 4, column 8, color 1
	sw	$t1, 548($t0)		#paint the unit on row 4, column 9, color 1
	sw	$t1, 552($t0)		#paint the unit on row 4, column 10, color 1
	sw	$t1, 556($t0)		#paint the unit on row 4, column 11, color 1
	sw	$t1, 564($t0)		#paint the unit on row 4, column 13, color 1
	sw	$t1, 580($t0)		#paint the unit on row 4, column 17, color 1
	sw	$t1, 588($t0)		#paint the unit on row 4, column 19, color 1
	sw	$t1, 644($t0)		#paint the unit on row 5, column 1, color 1
	sw	$t1, 660($t0)		#paint the unit on row 5, column 5, color 1
	sw	$t1, 668($t0)		#paint the unit on row 5, column 7, color 1
	sw	$t1, 684($t0)		#paint the unit on row 5, column 11, color 1
	sw	$t1, 692($t0)		#paint the unit on row 5, column 13, color 1
	sw	$t1, 708($t0)		#paint the unit on row 5, column 17, color 1
	sw	$t1, 716($t0)		#paint the unit on row 5, column 19, color 1
	sw	$t1, 776($t0)		#paint the unit on row 6, column 2, color 1
	sw	$t1, 780($t0)		#paint the unit on row 6, column 3, color 1
	sw	$t1, 784($t0)		#paint the unit on row 6, column 4, color 1
	sw	$t1, 788($t0)		#paint the unit on row 6, column 5, color 1
	sw	$t1, 796($t0)		#paint the unit on row 6, column 7, color 1
	sw	$t1, 812($t0)		#paint the unit on row 6, column 11, color 1
	sw	$t1, 820($t0)		#paint the unit on row 6, column 13, color 1
	sw	$t1, 836($t0)		#paint the unit on row 6, column 17, color 1
	sw	$t1, 844($t0)		#paint the unit on row 6, column 19, color 1
	sw	$t1, 848($t0)		#paint the unit on row 6, column 20, color 1
	sw	$t1, 852($t0)		#paint the unit on row 6, column 21, color 1
	sw	$t1, 856($t0)		#paint the unit on row 6, column 22, color 1
	sw	$t1, 860($t0)		#paint the unit on row 6, column 23, color 1
	sw	$t1, 1056($t0)		#paint the unit on row 8, column 8, color 1
	sw	$t1, 1060($t0)		#paint the unit on row 8, column 9, color 1
	sw	$t1, 1064($t0)		#paint the unit on row 8, column 10, color 1
	sw	$t1, 1076($t0)		#paint the unit on row 8, column 13, color 1
	sw	$t1, 1092($t0)		#paint the unit on row 8, column 17, color 1
	sw	$t1, 1100($t0)		#paint the unit on row 8, column 19, color 1
	sw	$t1, 1104($t0)		#paint the unit on row 8, column 20, color 1
	sw	$t1, 1108($t0)		#paint the unit on row 8, column 21, color 1
	sw	$t1, 1112($t0)		#paint the unit on row 8, column 22, color 1
	sw	$t1, 1116($t0)		#paint the unit on row 8, column 23, color 1
	sw	$t1, 1124($t0)		#paint the unit on row 8, column 25, color 1
	sw	$t1, 1128($t0)		#paint the unit on row 8, column 26, color 1
	sw	$t1, 1132($t0)		#paint the unit on row 8, column 27, color 1
	sw	$t1, 1136($t0)		#paint the unit on row 8, column 28, color 1
	sw	$t1, 1180($t0)		#paint the unit on row 9, column 7, color 1
	sw	$t1, 1196($t0)		#paint the unit on row 9, column 11, color 1
	sw	$t1, 1204($t0)		#paint the unit on row 9, column 13, color 1
	sw	$t1, 1220($t0)		#paint the unit on row 9, column 17, color 1
	sw	$t1, 1228($t0)		#paint the unit on row 9, column 19, color 1
	sw	$t1, 1252($t0)		#paint the unit on row 9, column 25, color 1
	sw	$t1, 1268($t0)		#paint the unit on row 9, column 29, color 1
	sw	$t1, 1308($t0)		#paint the unit on row 10, column 7, color 1
	sw	$t1, 1324($t0)		#paint the unit on row 10, column 11, color 1
	sw	$t1, 1332($t0)		#paint the unit on row 10, column 13, color 1
	sw	$t1, 1348($t0)		#paint the unit on row 10, column 17, color 1
	sw	$t1, 1356($t0)		#paint the unit on row 10, column 19, color 1
	sw	$t1, 1360($t0)		#paint the unit on row 10, column 20, color 1
	sw	$t1, 1364($t0)		#paint the unit on row 10, column 21, color 1
	sw	$t1, 1368($t0)		#paint the unit on row 10, column 22, color 1
	sw	$t1, 1372($t0)		#paint the unit on row 10, column 23, color 1
	sw	$t1, 1380($t0)		#paint the unit on row 10, column 25, color 1
	sw	$t1, 1384($t0)		#paint the unit on row 10, column 26, color 1
	sw	$t1, 1388($t0)		#paint the unit on row 10, column 27, color 1
	sw	$t1, 1392($t0)		#paint the unit on row 10, column 28, color 1
	sw	$t1, 1436($t0)		#paint the unit on row 11, column 7, color 1
	sw	$t1, 1452($t0)		#paint the unit on row 11, column 11, color 1
	sw	$t1, 1460($t0)		#paint the unit on row 11, column 13, color 1
	sw	$t1, 1476($t0)		#paint the unit on row 11, column 17, color 1
	sw	$t1, 1484($t0)		#paint the unit on row 11, column 19, color 1
	sw	$t1, 1508($t0)		#paint the unit on row 11, column 25, color 1
	sw	$t1, 1516($t0)		#paint the unit on row 11, column 27, color 1
	sw	$t1, 1564($t0)		#paint the unit on row 12, column 7, color 1
	sw	$t1, 1580($t0)		#paint the unit on row 12, column 11, color 1
	sw	$t1, 1592($t0)		#paint the unit on row 12, column 14, color 1
	sw	$t1, 1600($t0)		#paint the unit on row 12, column 16, color 1
	sw	$t1, 1612($t0)		#paint the unit on row 12, column 19, color 1
	sw	$t1, 1636($t0)		#paint the unit on row 12, column 25, color 1
	sw	$t1, 1648($t0)		#paint the unit on row 12, column 28, color 1
	sw	$t1, 1696($t0)		#paint the unit on row 13, column 8, color 1
	sw	$t1, 1700($t0)		#paint the unit on row 13, column 9, color 1
	sw	$t1, 1704($t0)		#paint the unit on row 13, column 10, color 1
	sw	$t1, 1724($t0)		#paint the unit on row 13, column 15, color 1
	sw	$t1, 1740($t0)		#paint the unit on row 13, column 19, color 1
	sw	$t1, 1744($t0)		#paint the unit on row 13, column 20, color 1
	sw	$t1, 1748($t0)		#paint the unit on row 13, column 21, color 1
	sw	$t1, 1752($t0)		#paint the unit on row 13, column 22, color 1
	sw	$t1, 1756($t0)		#paint the unit on row 13, column 23, color 1
	sw	$t1, 1764($t0)		#paint the unit on row 13, column 25, color 1
	sw	$t1, 1780($t0)		#paint the unit on row 13, column 29, color 1
	
	addi	$t9, $s5, 0		# set $t9 to be the score ($s5) to display
	
	rem	$v1, $t9, 10		# set v1 to number to display
	addi	$v0, $t0, 2528		# set address to display
	jal	displayNumber		# display the number
	div	$t9, $t9, 10		# divide $t9 by 10
	
	rem	$v1, $t9, 10		# set v1 to number to display
	addi	$v0, $t0, 2508		# set address to display
	jal	displayNumber		# display the number
	div	$t9, $t9, 10		# divide $t9 by 10
	
	rem	$v1, $t9, 10		# set v1 to number to display
	addi	$v0, $t0, 2488		# set address to display
	jal	displayNumber		# display the number
	div	$t9, $t9, 10		# divide $t9 by 10
	
	rem	$v1, $t9, 10		# set v1 to number to display
	addi	$v0, $t0, 2468		# set address to display
	jal	displayNumber		# display the number
	div	$t9, $t9, 10		# divide $t9 by 10
	
	rem	$v1, $t9, 10		# set v1 to number to display
	addi	$v0, $t0, 2448		# set address to display
	jal	displayNumber		# display the number
	
	jr	$ra			# return;

#################################################
# game sleep function

gameSleep:
	li 	$v0, 32				# sleep syscall
	li 	$a0, 100			# sleep 0.025 second 
	syscall
	jr	$ra

#################################################
# getInput function
# get input from keyboard

getInput:
	li 	$t9, 0xffff0000
	lw 	$t8, 0($t9)
	beq 	$t8, 1, processInput
	jr	$ra

	processInput:
	lw	$t8, 4($t9)			# get the input character
	beq	$t8, 'w', wPressed
	beq	$t8, 'a', aPressed
	beq	$t8, 's', sPressed
	beq	$t8, 'd', dPressed
	beq	$t8, 'p', pPressed
	beq	$t8, 'e', ePressed
	jr	$ra
	
	wPressed:
	lw	$t8, shipRow
	beq	$t8, 0, exitGetInput
	addi	$t8, $t8, -1
	sw	$t8, shipRow
	j	exitGetInput
	
	aPressed:
	lw	$t8, shipColumn
	beq	$t8, 0, exitGetInput
	addi	$t8, $t8, -1
	sw	$t8, shipColumn
	j	exitGetInput

	sPressed:
	lw	$t8, shipRow
	beq	$t8, 31, exitGetInput
	addi	$t8, $t8, 1
	sw	$t8, shipRow
	j	exitGetInput
	
	dPressed:
	lw	$t8, shipColumn
	beq	$t8, 31, exitGetInput
	addi	$t8, $t8, 1
	sw	$t8, shipColumn
	j	exitGetInput

	pPressed:					# restart game
	j	startGame
	
	ePressed:					# end the game
	j	endGame
	
	exitGetInput:
	jr	$ra
	
#################################################
# updateObstacle function
# updates the position of obstacles / create new
# reducing the column position by difficult each time
# if is at the edge(column == 0), generate new at right edge
updateObstacle:
	sll	$t2, $s2, 2
	
	initUpdateLoop:
	li	$t0, 0
	condUpdateLoop:
	bge	$t0, $t2, endUpdateLoop		# here the 4 need to be changed according to difficulty
	bodyUpdateLoop:
		sll	$t3, $t0, 2
		lw	$t4, obstacleColumn($t3)
		
		blt	$t4, 0, generateNewObstacle
		
		sub	$t4, $t4, $s2		# new column = prev column - difficulty 
		sw	$t4, obstacleColumn($t3)
		addi	$t0, $t0, 1
		j	condUpdateLoop
		
		generateNewObstacle:
		mul	$t7, $s2, 10		# Add score to player, linear to difficulty
		add	$s5, $s5, $t7
		
		li 	$v0, 42         	# Service 42, random int range
		li 	$a0, 0          	# Select random generator 0
		li 	$a1, 28	   		# Select upper bound of random number
		syscall            		# Generate random int (returns in $a0)
	
		addi	$t4, $a0, 0		# get row position in $t4
		
		li 	$v0, 42         	# Service 42, random int range
		li 	$a0, 0          	# Select random generator 0
		addi	$a1, $s2, 0		# Biggest possible type will be difficulty - 1
		syscall            		# Generate random int (returns in $a0)
	
		addi	$t5, $a0, 0		# get type in $t5
		
		sw	$t5, obstacleType($t3)
		li	$t6, 31
		sw	$t6, obstacleColumn($t3)
		sw	$t4, obstacleRow($t3)
		addi	$t0, $t0, 1
		j	condUpdateLoop
	endUpdateLoop:
	jr	$ra
	
# Collision animation
collisionAnimation:
	startAnimation:
	
	beqz	$s3, endAnimation		# no damage, no animation
	
	li 	$v0, 32				# sleep syscall
	li 	$a0, 200			# sleep 0.2 second 
	syscall
	
	lw	$t0, displayAddress		# draw the spaceship according to its position in row and column
	lw	$t1, shipRow			# load row of space ship
	sll	$t1, $t1, 7			# get offset by rows
	lw	$t2, shipColumn			# load column of the ship
	sll	$t2, $t2, 2			# get offset by columns
	add	$t0, $t0, $t1			# calculate the start point of printing for spaceship
	add	$t0, $t0, $t2
	
	li	$v0, 1
	addi	$a0, $s3, 0
	syscall
	
	li	$v0, 11
	li	$a0, ' '
	syscall
	
	bge	$s3, 2, fullDamage
	
	li 	$v0, 42         		# Service 42, random int range
	li 	$a0, 1          		# Select random generator 0
	li	$a1, 3				# Biggest possible damage will be 2: 50% of chance getting half damage
	syscall            			# Generate random int (returns in $a0)
	
	addi	$s3, $a0, 0			# store the damage
	bgt	$s3, 1, fullDamage		# if gazing case happened, show different animation and only reduce health by 1

	halfDamage:
	li	$t1, 0xffffff			# $t1 stores the light grey color code
	li	$t2, 0xffffff			# $t2 stores the dark grey color code
	sw	$t2, 4($t0)			# paint the unit on row 0, column 1, color 2
	sw	$t2, 8($t0)			# paint the unit on row 0, column 2, color 2
	sw	$t1, 128($t0)			# paint the unit on row 1, column 0, color 1
	sw	$t1, 132($t0)			# paint the unit on row 1, column 1, color 1
	sw	$t1, 136($t0)			# paint the unit on row 1, column 2, color 1
	sw	$t1, 140($t0)			# paint the unit on row 1, column 3, color 1
	sw	$t1, 256($t0)			# paint the unit on row 2, column 0, color 1
	sw	$t1, 260($t0)			# paint the unit on row 2, column 1, color 1
	sw	$t1, 264($t0)			# paint the unit on row 2, column 2, color 1
	sw	$t1, 388($t0)			# paint the unit on row 3, column 1, color 1
	
	li 	$v0, 32				# sleep syscall
	li 	$a0, 100			# sleep 0.1 second 
	syscall
						# erase the ship
	sw	$0, 4($t0)			# paint the unit on row 0, column 1, color 2
	sw	$0, 8($t0)			# paint the unit on row 0, column 2, color 2
	sw	$0, 128($t0)			# paint the unit on row 1, column 0, color 1
	sw	$0, 132($t0)			# paint the unit on row 1, column 1, color 1
	sw	$0, 136($t0)			# paint the unit on row 1, column 2, color 1
	sw	$0, 140($t0)			# paint the unit on row 1, column 3, color 1
	sw	$0, 256($t0)			# paint the unit on row 2, column 0, color 1
	sw	$0, 260($t0)			# paint the unit on row 2, column 1, color 1
	sw	$0, 264($t0)			# paint the unit on row 2, column 2, color 1
	sw	$0, 388($t0)			# paint the unit on row 3, column 1, color 1
	j	endAnimation0

	fullDamage:	
	li	$t1, 0xff00ff			# $t1 stores the light grey color code
	li	$t2, 0xff0000			# $t2 stores the dark grey color code
	sw	$t2, 4($t0)			# paint the unit on row 0, column 1, color 2
	sw	$t2, 8($t0)			# paint the unit on row 0, column 2, color 2
	sw	$t1, 128($t0)			# paint the unit on row 1, column 0, color 1
	sw	$t1, 132($t0)			# paint the unit on row 1, column 1, color 1
	sw	$t1, 136($t0)			# paint the unit on row 1, column 2, color 1
	sw	$t1, 140($t0)			# paint the unit on row 1, column 3, color 1
	sw	$t1, 256($t0)			# paint the unit on row 2, column 0, color 1
	sw	$t1, 260($t0)			# paint the unit on row 2, column 1, color 1
	sw	$t1, 264($t0)			# paint the unit on row 2, column 2, color 1
	sw	$t1, 388($t0)			# paint the unit on row 3, column 1, color 1
	
	li 	$v0, 32				# sleep syscall
	li 	$a0, 100			# sleep 0.1 second 
	syscall
						# erase the ship
	sw	$0, 4($t0)			# paint the unit on row 0, column 1, color 2
	sw	$0, 8($t0)			# paint the unit on row 0, column 2, color 2
	sw	$0, 128($t0)			# paint the unit on row 1, column 0, color 1
	sw	$0, 132($t0)			# paint the unit on row 1, column 1, color 1
	sw	$0, 136($t0)			# paint the unit on row 1, column 2, color 1
	sw	$0, 140($t0)			# paint the unit on row 1, column 3, color 1
	sw	$0, 256($t0)			# paint the unit on row 2, column 0, color 1
	sw	$0, 260($t0)			# paint the unit on row 2, column 1, color 1
	sw	$0, 264($t0)			# paint the unit on row 2, column 2, color 1
	sw	$0, 388($t0)			# paint the unit on row 3, column 1, color 1
	
	li	$s3, 2
	
	endAnimation0:
	li	$v0, 1
	addi	$a0, $s3, 0
	syscall
	
	li	$v0, 11
	li	$a0, '\n'
	syscall
	endAnimation:
	sub	$s1, $s1, $s3			# reduce health
	li	$s3, 0
	jr	$ra				# return;

#################################################
# display number, display the score on the end screen
# $v0: display address
# $v1: number to display
displayNumber:
	sw	$t0, ($sp)
	addi	$sp, $sp, 4
	
	addi	$t1, $v0, 0
	addi	$t0, $v1, 0
	li	$t2, 0xffdddd
	
	beq	$t0, 0, disp0
	beq	$t0, 1, disp1
	beq	$t0, 2, disp2
	beq	$t0, 3, disp3
	beq	$t0, 4, disp4
	beq	$t0, 5, disp5
	beq	$t0, 6, disp6
	beq	$t0, 7, disp7
	beq	$t0, 8, disp8
	beq	$t0, 9, disp9

endDisplay:
	addi	$sp, $sp, -4
	lw	$t0, ($sp)
	jr	$ra
	
disp0:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 128($t1)
	sw	$t2, 140($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 384($t1)
	sw	$t2, 396($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay

disp1:
	sw	$t2, 12($t1)
	
	sw	$t2, 140($t1)
	
	sw	$t2, 268($t1)
	
	sw	$t2, 396($t1)
	
	sw	$t2, 524($t1)
	
	j	endDisplay

disp2:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 140($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 384($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay
	
disp3:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 140($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 396($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay

disp4:
	sw	$t2, 0($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 128($t1)
	sw	$t2, 140($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 396($t1)
	
	sw	$t2, 524($t1)
	
	j	endDisplay
	
disp5:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 128($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 396($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay

disp6:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 128($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 384($t1)
	sw	$t2, 396($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay

disp7:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 140($t1)
	
	sw	$t2, 268($t1)
	
	sw	$t2, 396($t1)
	
	sw	$t2, 524($t1)
	
	j	endDisplay

disp8:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 128($t1)
	sw	$t2, 140($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 384($t1)
	sw	$t2, 396($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay

disp9:
	sw	$t2, 0($t1)
	sw	$t2, 4($t1)
	sw	$t2, 8($t1)
	sw	$t2, 12($t1)
	
	sw	$t2, 128($t1)
	sw	$t2, 140($t1)
	
	sw	$t2, 256($t1)
	sw	$t2, 260($t1)
	sw	$t2, 264($t1)
	sw	$t2, 268($t1)
	
	sw	$t2, 396($t1)
	
	sw	$t2, 512($t1)
	sw	$t2, 516($t1)
	sw	$t2, 520($t1)
	sw	$t2, 524($t1)
	
	j	endDisplay
