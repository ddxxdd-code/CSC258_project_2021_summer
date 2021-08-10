# CSC258 lab08
# 2021-07-16
# Dedong Xie
# Draw an airplane avatar on the screen
# Bitmap Display Configuration:
# - Unit width in pixels: 8x
# - Unit height in pixels: 8d
# - Display width in pixels: 256d
# - Display height in pixels: 256c
# - Base Address for Display: 0x10008000 ($gp)r
#
.data
displayAddress:
	.word 0x10008000

.text
Main:
	lw	$t0, displayAddress	# $t0 stores the base address for display
	li	$t1, 0x9e9e9e		# $t1 stores the light grey color code
	li	$t2, 0x464646		# $t2 stores the dark grey color code
	li	$t3, 0xffd266		# $t3 stores the yellow color code
	sw	$t1, 132($t0)		# paint the unit on row 1, column 1, color 1
	sw	$t1, 156($t0)		# paint the unit on row 1, column 7, color 1
	sw	$t1, 160($t0)		# paint the unit on row 1, column 8, color 1
	sw	$t1, 164($t0)		# paint the unit on row 1, column 9, color 1
	sw	$t1, 168($t0)		# paint the unit on row 1, column 10, color 1
	sw	$t1, 172($t0)		# paint the unit on row 1, column 11, color 1
	sw	$t1, 180($t0)		# paint the unit on row 1, column 13, color 1
	sw	$t1, 196($t0)		# paint the unit on row 1, column 17, color 1
	sw	$t1, 204($t0)		# paint the unit on row 1, column 19, color 1
	sw	$t1, 208($t0)		# paint the unit on row 1, column 20, color 1
	sw	$t1, 212($t0)		# paint the unit on row 1, column 21, color 1
	sw	$t1, 216($t0)		# paint the unit on row 1, column 22, color 1
	sw	$t1, 220($t0)		# paint the unit on row 1, column 23, color 1
	sw	$t1, 228($t0)		# paint the unit on row 1, column 25, color 1
	sw	$t1, 260($t0)		# paint the unit on row 2, column 1, color 1
	sw	$t1, 284($t0)		# paint the unit on row 2, column 7, color 1
	sw	$t1, 308($t0)		# paint the unit on row 2, column 13, color 1
	sw	$t1, 324($t0)		# paint the unit on row 2, column 17, color 1
	sw	$t1, 332($t0)		# paint the unit on row 2, column 19, color 1
	sw	$t1, 356($t0)		# paint the unit on row 2, column 25, color 1
	sw	$t1, 388($t0)		# paint the unit on row 3, column 1, color 1
	sw	$t1, 412($t0)		# paint the unit on row 3, column 7, color 1
	sw	$t1, 416($t0)		# paint the unit on row 3, column 8, color 1
	sw	$t1, 420($t0)		# paint the unit on row 3, column 9, color 1
	sw	$t1, 424($t0)		# paint the unit on row 3, column 10, color 1
	sw	$t1, 428($t0)		# paint the unit on row 3, column 11, color 1
	sw	$t1, 436($t0)		# paint the unit on row 3, column 13, color 1
	sw	$t1, 452($t0)		# paint the unit on row 3, column 17, color 1
	sw	$t1, 460($t0)		# paint the unit on row 3, column 19, color 1
	sw	$t1, 464($t0)		# paint the unit on row 3, column 20, color 1
	sw	$t1, 468($t0)		# paint the unit on row 3, column 21, color 1
	sw	$t1, 472($t0)		# paint the unit on row 3, column 22, color 1
	sw	$t1, 476($t0)		# paint the unit on row 3, column 23, color 1
	sw	$t1, 484($t0)		# paint the unit on row 3, column 25, color 1
	sw	$t1, 516($t0)		# paint the unit on row 4, column 1, color 1
	sw	$t1, 540($t0)		# paint the unit on row 4, column 7, color 1
	sw	$t1, 564($t0)		# paint the unit on row 4, column 13, color 1
	sw	$t1, 580($t0)		# paint the unit on row 4, column 17, color 1
	sw	$t1, 588($t0)		# paint the unit on row 4, column 19, color 1
	sw	$t1, 612($t0)		# paint the unit on row 4, column 25, color 1
	sw	$t1, 644($t0)		# paint the unit on row 5, column 1, color 1
	sw	$t1, 668($t0)		# paint the unit on row 5, column 7, color 1
	sw	$t1, 696($t0)		# paint the unit on row 5, column 14, color 1
	sw	$t1, 704($t0)		# paint the unit on row 5, column 16, color 1
	sw	$t1, 716($t0)		# paint the unit on row 5, column 19, color 1
	sw	$t1, 740($t0)		# paint the unit on row 5, column 25, color 1
	sw	$t1, 772($t0)		# paint the unit on row 6, column 1, color 1
	sw	$t1, 776($t0)		# paint the unit on row 6, column 2, color 1
	sw	$t1, 780($t0)		# paint the unit on row 6, column 3, color 1
	sw	$t1, 784($t0)		# paint the unit on row 6, column 4, color 1
	sw	$t1, 788($t0)		# paint the unit on row 6, column 5, color 1
	sw	$t1, 796($t0)		# paint the unit on row 6, column 7, color 1
	sw	$t1, 800($t0)		# paint the unit on row 6, column 8, color 1
	sw	$t1, 804($t0)		# paint the unit on row 6, column 9, color 1
	sw	$t1, 808($t0)		# paint the unit on row 6, column 10, color 1
	sw	$t1, 812($t0)		# paint the unit on row 6, column 11, color 1
	sw	$t1, 828($t0)		# paint the unit on row 6, column 15, color 1
	sw	$t1, 844($t0)		# paint the unit on row 6, column 19, color 1
	sw	$t1, 848($t0)		# paint the unit on row 6, column 20, color 1
	sw	$t1, 852($t0)		# paint the unit on row 6, column 21, color 1
	sw	$t1, 856($t0)		# paint the unit on row 6, column 22, color 1
	sw	$t1, 860($t0)		# paint the unit on row 6, column 23, color 1
	sw	$t1, 868($t0)		# paint the unit on row 6, column 25, color 1
	sw	$t1, 872($t0)		# paint the unit on row 6, column 26, color 1
	sw	$t1, 876($t0)		# paint the unit on row 6, column 27, color 1
	sw	$t1, 880($t0)		# paint the unit on row 6, column 28, color 1
	sw	$t1, 884($t0)		# paint the unit on row 6, column 29, color 1
	sw	$t3, 1320($t0)		# paint the unit on row 10, column 10, color 3
	sw	$t3, 1336($t0)		# paint the unit on row 10, column 14, color 3
	sw	$t3, 1448($t0)		# paint the unit on row 11, column 10, color 3
	sw	$t3, 1464($t0)		# paint the unit on row 11, column 14, color 3
	sw	$t3, 1576($t0)		# paint the unit on row 12, column 10, color 3
	sw	$t3, 1592($t0)		# paint the unit on row 12, column 14, color 3
	sw	$t3, 1604($t0)		# paint the unit on row 12, column 17, color 3
	sw	$t3, 1608($t0)		# paint the unit on row 12, column 18, color 3
	sw	$t3, 1612($t0)		# paint the unit on row 12, column 19, color 3
	sw	$t3, 1616($t0)		# paint the unit on row 12, column 20, color 3
	sw	$t3, 1620($t0)		# paint the unit on row 12, column 21, color 3
	sw	$t3, 1704($t0)		# paint the unit on row 13, column 10, color 3
	sw	$t3, 1720($t0)		# paint the unit on row 13, column 14, color 3
	sw	$t3, 1732($t0)		# paint the unit on row 13, column 17, color 3
	sw	$t3, 1748($t0)		# paint the unit on row 13, column 21, color 3
	sw	$t3, 1832($t0)		# paint the unit on row 14, column 10, color 3
	sw	$t3, 1848($t0)		# paint the unit on row 14, column 14, color 3
	sw	$t3, 1860($t0)		# paint the unit on row 14, column 17, color 3
	sw	$t3, 1876($t0)		# paint the unit on row 14, column 21, color 3
	sw	$t3, 1960($t0)		# paint the unit on row 15, column 10, color 3
	sw	$t3, 1964($t0)		# paint the unit on row 15, column 11, color 3
	sw	$t3, 1968($t0)		# paint the unit on row 15, column 12, color 3
	sw	$t3, 1972($t0)		# paint the unit on row 15, column 13, color 3
	sw	$t3, 1976($t0)		# paint the unit on row 15, column 14, color 3
	sw	$t3, 1988($t0)		# paint the unit on row 15, column 17, color 3
	sw	$t3, 1992($t0)		# paint the unit on row 15, column 18, color 3
	sw	$t3, 1996($t0)		# paint the unit on row 15, column 19, color 3
	sw	$t3, 2000($t0)		# paint the unit on row 15, column 20, color 3
	sw	$t3, 2004($t0)		# paint the unit on row 15, column 21, color 3
	sw	$t3, 2116($t0)		# paint the unit on row 16, column 17, color 3
	sw	$t3, 2244($t0)		# paint the unit on row 17, column 17, color 3
	sw	$t3, 2372($t0)		# paint the unit on row 18, column 17, color 3
	sw	$t3, 2492($t0)		# paint the unit on row 19, column 15, color 3
	sw	$t3, 2500($t0)		# paint the unit on row 19, column 17, color 3
	sw	$t3, 2616($t0)		# paint the unit on row 20, column 14, color 3
	sw	$t3, 2620($t0)		# paint the unit on row 20, column 15, color 3
	sw	$t3, 2624($t0)		# paint the unit on row 20, column 16, color 3
	sw	$t3, 2740($t0)		# paint the unit on row 21, column 13, color 3
	sw	$t3, 2744($t0)		# paint the unit on row 21, column 14, color 3
	sw	$t3, 2748($t0)		# paint the unit on row 21, column 15, color 3
	sw	$t3, 2752($t0)		# paint the unit on row 21, column 16, color 3
	sw	$t3, 2756($t0)		# paint the unit on row 21, column 17, color 3
	sw	$t3, 2864($t0)		# paint the unit on row 22, column 12, color 3
	sw	$t3, 2868($t0)		# paint the unit on row 22, column 13, color 3
	sw	$t3, 2872($t0)		# paint the unit on row 22, column 14, color 3
	sw	$t3, 2876($t0)		# paint the unit on row 22, column 15, color 3
	sw	$t3, 2880($t0)		# paint the unit on row 22, column 16, color 3
	sw	$t3, 2884($t0)		# paint the unit on row 22, column 17, color 3
	sw	$t3, 2888($t0)		# paint the unit on row 22, column 18, color 3
	sw	$t3, 2988($t0)		# paint the unit on row 23, column 11, color 3
	sw	$t3, 2992($t0)		# paint the unit on row 23, column 12, color 3
	sw	$t3, 2996($t0)		# paint the unit on row 23, column 13, color 3
	sw	$t3, 3000($t0)		# paint the unit on row 23, column 14, color 3
	sw	$t3, 3004($t0)		# paint the unit on row 23, column 15, color 3
	sw	$t3, 3008($t0)		# paint the unit on row 23, column 16, color 3
	sw	$t3, 3012($t0)		# paint the unit on row 23, column 17, color 3
	sw	$t3, 3016($t0)		# paint the unit on row 23, column 18, color 3
	sw	$t3, 3020($t0)		# paint the unit on row 23, column 19, color 3
	sw	$t3, 3112($t0)		# paint the unit on row 24, column 10, color 3
	sw	$t3, 3116($t0)		# paint the unit on row 24, column 11, color 3
	sw	$t3, 3120($t0)		# paint the unit on row 24, column 12, color 3
	sw	$t3, 3124($t0)		# paint the unit on row 24, column 13, color 3
	sw	$t3, 3128($t0)		# paint the unit on row 24, column 14, color 3
	sw	$t3, 3132($t0)		# paint the unit on row 24, column 15, color 3
	sw	$t3, 3136($t0)		# paint the unit on row 24, column 16, color 3
	sw	$t3, 3140($t0)		# paint the unit on row 24, column 17, color 3
	sw	$t3, 3144($t0)		# paint the unit on row 24, column 18, color 3
	sw	$t3, 3148($t0)		# paint the unit on row 24, column 19, color 3
	sw	$t3, 3152($t0)		# paint the unit on row 24, column 20, color 3
	sw	$t3, 3256($t0)		# paint the unit on row 25, column 14, color 3
	sw	$t3, 3260($t0)		# paint the unit on row 25, column 15, color 3
	sw	$t3, 3264($t0)		# paint the unit on row 25, column 16, color 3
	sw	$t3, 3384($t0)		# paint the unit on row 26, column 14, color 3
	sw	$t3, 3388($t0)		# paint the unit on row 26, column 15, color 3
	sw	$t3, 3392($t0)		# paint the unit on row 26, column 16, color 3
	sw	$t3, 3512($t0)		# paint the unit on row 27, column 14, color 3
	sw	$t3, 3516($t0)		# paint the unit on row 27, column 15, color 3
	sw	$t3, 3520($t0)		# paint the unit on row 27, column 16, color 3
	sw	$t3, 3640($t0)		# paint the unit on row 28, column 14, color 3
	sw	$t3, 3644($t0)		# paint the unit on row 28, column 15, color 3
	sw	$t3, 3648($t0)		# paint the unit on row 28, column 16, color 3
	sw	$t3, 3768($t0)		# paint the unit on row 29, column 14, color 3
	sw	$t3, 3772($t0)		# paint the unit on row 29, column 15, color 3
	sw	$t3, 3776($t0)		# paint the unit on row 29, column 16, color 3
	sw	$t3, 3896($t0)		# paint the unit on row 30, column 14, color 3
	sw	$t3, 3900($t0)		# paint the unit on row 30, column 15, color 3
	sw	$t3, 3904($t0)		# paint the unit on row 30, column 16, color 3
	sw	$t3, 4024($t0)		# paint the unit on row 31, column 14, color 3
	sw	$t3, 4028($t0)		# paint the unit on row 31, column 15, color 3
	sw	$t3, 4032($t0)		# paint the unit on row 31, column 16, color 3
Exit:
	li	$v0, 10			# terminate the program gracefuly
	syscall