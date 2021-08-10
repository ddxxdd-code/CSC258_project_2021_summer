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
	sw	$0, 132($t0)		# erase the unit on row 1, column 1, color 1
	sw	$0, 156($t0)		# erase the unit on row 1, column 7, color 1
	sw	$0, 160($t0)		# erase the unit on row 1, column 8, color 1
	sw	$0, 164($t0)		# erase the unit on row 1, column 9, color 1
	sw	$0, 168($t0)		# erase the unit on row 1, column 10, color 1
	sw	$0, 172($t0)		# erase the unit on row 1, column 11, color 1
	sw	$0, 180($t0)		# erase the unit on row 1, column 13, color 1
	sw	$0, 196($t0)		# erase the unit on row 1, column 17, color 1
	sw	$0, 204($t0)		# erase the unit on row 1, column 19, color 1
	sw	$0, 208($t0)		# erase the unit on row 1, column 20, color 1
	sw	$0, 212($t0)		# erase the unit on row 1, column 21, color 1
	sw	$0, 216($t0)		# erase the unit on row 1, column 22, color 1
	sw	$0, 220($t0)		# erase the unit on row 1, column 23, color 1
	sw	$0, 228($t0)		# erase the unit on row 1, column 25, color 1
	sw	$0, 260($t0)		# erase the unit on row 2, column 1, color 1
	sw	$0, 284($t0)		# erase the unit on row 2, column 7, color 1
	sw	$0, 308($t0)		# erase the unit on row 2, column 13, color 1
	sw	$0, 324($t0)		# erase the unit on row 2, column 17, color 1
	sw	$0, 332($t0)		# erase the unit on row 2, column 19, color 1
	sw	$0, 356($t0)		# erase the unit on row 2, column 25, color 1
	sw	$0, 388($t0)		# erase the unit on row 3, column 1, color 1
	sw	$0, 412($t0)		# erase the unit on row 3, column 7, color 1
	sw	$0, 416($t0)		# erase the unit on row 3, column 8, color 1
	sw	$0, 420($t0)		# erase the unit on row 3, column 9, color 1
	sw	$0, 424($t0)		# erase the unit on row 3, column 10, color 1
	sw	$0, 428($t0)		# erase the unit on row 3, column 11, color 1
	sw	$0, 436($t0)		# erase the unit on row 3, column 13, color 1
	sw	$0, 452($t0)		# erase the unit on row 3, column 17, color 1
	sw	$0, 460($t0)		# erase the unit on row 3, column 19, color 1
	sw	$0, 464($t0)		# erase the unit on row 3, column 20, color 1
	sw	$0, 468($t0)		# erase the unit on row 3, column 21, color 1
	sw	$0, 472($t0)		# erase the unit on row 3, column 22, color 1
	sw	$0, 476($t0)		# erase the unit on row 3, column 23, color 1
	sw	$0, 484($t0)		# erase the unit on row 3, column 25, color 1
	sw	$0, 516($t0)		# erase the unit on row 4, column 1, color 1
	sw	$0, 540($t0)		# erase the unit on row 4, column 7, color 1
	sw	$0, 564($t0)		# erase the unit on row 4, column 13, color 1
	sw	$0, 580($t0)		# erase the unit on row 4, column 17, color 1
	sw	$0, 588($t0)		# erase the unit on row 4, column 19, color 1
	sw	$0, 612($t0)		# erase the unit on row 4, column 25, color 1
	sw	$0, 644($t0)		# erase the unit on row 5, column 1, color 1
	sw	$0, 668($t0)		# erase the unit on row 5, column 7, color 1
	sw	$0, 696($t0)		# erase the unit on row 5, column 14, color 1
	sw	$0, 704($t0)		# erase the unit on row 5, column 16, color 1
	sw	$0, 716($t0)		# erase the unit on row 5, column 19, color 1
	sw	$0, 740($t0)		# erase the unit on row 5, column 25, color 1
	sw	$0, 772($t0)		# erase the unit on row 6, column 1, color 1
	sw	$0, 776($t0)		# erase the unit on row 6, column 2, color 1
	sw	$0, 780($t0)		# erase the unit on row 6, column 3, color 1
	sw	$0, 784($t0)		# erase the unit on row 6, column 4, color 1
	sw	$0, 788($t0)		# erase the unit on row 6, column 5, color 1
	sw	$0, 796($t0)		# erase the unit on row 6, column 7, color 1
	sw	$0, 800($t0)		# erase the unit on row 6, column 8, color 1
	sw	$0, 804($t0)		# erase the unit on row 6, column 9, color 1
	sw	$0, 808($t0)		# erase the unit on row 6, column 10, color 1
	sw	$0, 812($t0)		# erase the unit on row 6, column 11, color 1
	sw	$0, 828($t0)		# erase the unit on row 6, column 15, color 1
	sw	$0, 844($t0)		# erase the unit on row 6, column 19, color 1
	sw	$0, 848($t0)		# erase the unit on row 6, column 20, color 1
	sw	$0, 852($t0)		# erase the unit on row 6, column 21, color 1
	sw	$0, 856($t0)		# erase the unit on row 6, column 22, color 1
	sw	$0, 860($t0)		# erase the unit on row 6, column 23, color 1
	sw	$0, 868($t0)		# erase the unit on row 6, column 25, color 1
	sw	$0, 872($t0)		# erase the unit on row 6, column 26, color 1
	sw	$0, 876($t0)		# erase the unit on row 6, column 27, color 1
	sw	$0, 880($t0)		# erase the unit on row 6, column 28, color 1
	sw	$0, 884($t0)		# erase the unit on row 6, column 29, color 1
	sw	$0, 1320($t0)		# erase the unit on row 10, column 10, color 3
	sw	$0, 1336($t0)		# erase the unit on row 10, column 14, color 3
	sw	$0, 1448($t0)		# erase the unit on row 11, column 10, color 3
	sw	$0, 1464($t0)		# erase the unit on row 11, column 14, color 3
	sw	$0, 1576($t0)		# erase the unit on row 12, column 10, color 3
	sw	$0, 1592($t0)		# erase the unit on row 12, column 14, color 3
	sw	$0, 1604($t0)		# erase the unit on row 12, column 17, color 3
	sw	$0, 1608($t0)		# erase the unit on row 12, column 18, color 3
	sw	$0, 1612($t0)		# erase the unit on row 12, column 19, color 3
	sw	$0, 1616($t0)		# erase the unit on row 12, column 20, color 3
	sw	$0, 1620($t0)		# erase the unit on row 12, column 21, color 3
	sw	$0, 1704($t0)		# erase the unit on row 13, column 10, color 3
	sw	$0, 1720($t0)		# erase the unit on row 13, column 14, color 3
	sw	$0, 1732($t0)		# erase the unit on row 13, column 17, color 3
	sw	$0, 1748($t0)		# erase the unit on row 13, column 21, color 3
	sw	$0, 1832($t0)		# erase the unit on row 14, column 10, color 3
	sw	$0, 1848($t0)		# erase the unit on row 14, column 14, color 3
	sw	$0, 1860($t0)		# erase the unit on row 14, column 17, color 3
	sw	$0, 1876($t0)		# erase the unit on row 14, column 21, color 3
	sw	$0, 1960($t0)		# erase the unit on row 15, column 10, color 3
	sw	$0, 1964($t0)		# erase the unit on row 15, column 11, color 3
	sw	$0, 1968($t0)		# erase the unit on row 15, column 12, color 3
	sw	$0, 1972($t0)		# erase the unit on row 15, column 13, color 3
	sw	$0, 1976($t0)		# erase the unit on row 15, column 14, color 3
	sw	$0, 1988($t0)		# erase the unit on row 15, column 17, color 3
	sw	$0, 1992($t0)		# erase the unit on row 15, column 18, color 3
	sw	$0, 1996($t0)		# erase the unit on row 15, column 19, color 3
	sw	$0, 2000($t0)		# erase the unit on row 15, column 20, color 3
	sw	$0, 2004($t0)		# erase the unit on row 15, column 21, color 3
	sw	$0, 2116($t0)		# erase the unit on row 16, column 17, color 3
	sw	$0, 2244($t0)		# erase the unit on row 17, column 17, color 3
	sw	$0, 2372($t0)		# erase the unit on row 18, column 17, color 3
	sw	$0, 2492($t0)		# erase the unit on row 19, column 15, color 3
	sw	$0, 2500($t0)		# erase the unit on row 19, column 17, color 3
	sw	$0, 2616($t0)		# erase the unit on row 20, column 14, color 3
	sw	$0, 2620($t0)		# erase the unit on row 20, column 15, color 3
	sw	$0, 2624($t0)		# erase the unit on row 20, column 16, color 3
	sw	$0, 2740($t0)		# erase the unit on row 21, column 13, color 3
	sw	$0, 2744($t0)		# erase the unit on row 21, column 14, color 3
	sw	$0, 2748($t0)		# erase the unit on row 21, column 15, color 3
	sw	$0, 2752($t0)		# erase the unit on row 21, column 16, color 3
	sw	$0, 2756($t0)		# erase the unit on row 21, column 17, color 3
	sw	$0, 2864($t0)		# erase the unit on row 22, column 12, color 3
	sw	$0, 2868($t0)		# erase the unit on row 22, column 13, color 3
	sw	$0, 2872($t0)		# erase the unit on row 22, column 14, color 3
	sw	$0, 2876($t0)		# erase the unit on row 22, column 15, color 3
	sw	$0, 2880($t0)		# erase the unit on row 22, column 16, color 3
	sw	$0, 2884($t0)		# erase the unit on row 22, column 17, color 3
	sw	$0, 2888($t0)		# erase the unit on row 22, column 18, color 3
	sw	$0, 2988($t0)		# erase the unit on row 23, column 11, color 3
	sw	$0, 2992($t0)		# erase the unit on row 23, column 12, color 3
	sw	$0, 2996($t0)		# erase the unit on row 23, column 13, color 3
	sw	$0, 3000($t0)		# erase the unit on row 23, column 14, color 3
	sw	$0, 3004($t0)		# erase the unit on row 23, column 15, color 3
	sw	$0, 3008($t0)		# erase the unit on row 23, column 16, color 3
	sw	$0, 3012($t0)		# erase the unit on row 23, column 17, color 3
	sw	$0, 3016($t0)		# erase the unit on row 23, column 18, color 3
	sw	$0, 3020($t0)		# erase the unit on row 23, column 19, color 3
	sw	$0, 3112($t0)		# erase the unit on row 24, column 10, color 3
	sw	$0, 3116($t0)		# erase the unit on row 24, column 11, color 3
	sw	$0, 3120($t0)		# erase the unit on row 24, column 12, color 3
	sw	$0, 3124($t0)		# erase the unit on row 24, column 13, color 3
	sw	$0, 3128($t0)		# erase the unit on row 24, column 14, color 3
	sw	$0, 3132($t0)		# erase the unit on row 24, column 15, color 3
	sw	$0, 3136($t0)		# erase the unit on row 24, column 16, color 3
	sw	$0, 3140($t0)		# erase the unit on row 24, column 17, color 3
	sw	$0, 3144($t0)		# erase the unit on row 24, column 18, color 3
	sw	$0, 3148($t0)		# erase the unit on row 24, column 19, color 3
	sw	$0, 3152($t0)		# erase the unit on row 24, column 20, color 3
	sw	$0, 3256($t0)		# erase the unit on row 25, column 14, color 3
	sw	$0, 3260($t0)		# erase the unit on row 25, column 15, color 3
	sw	$0, 3264($t0)		# erase the unit on row 25, column 16, color 3
	sw	$0, 3384($t0)		# erase the unit on row 26, column 14, color 3
	sw	$0, 3388($t0)		# erase the unit on row 26, column 15, color 3
	sw	$0, 3392($t0)		# erase the unit on row 26, column 16, color 3
	sw	$0, 3512($t0)		# erase the unit on row 27, column 14, color 3
	sw	$0, 3516($t0)		# erase the unit on row 27, column 15, color 3
	sw	$0, 3520($t0)		# erase the unit on row 27, column 16, color 3
	sw	$0, 3640($t0)		# erase the unit on row 28, column 14, color 3
	sw	$0, 3644($t0)		# erase the unit on row 28, column 15, color 3
	sw	$0, 3648($t0)		# erase the unit on row 28, column 16, color 3
	sw	$0, 3768($t0)		# erase the unit on row 29, column 14, color 3
	sw	$0, 3772($t0)		# erase the unit on row 29, column 15, color 3
	sw	$0, 3776($t0)		# erase the unit on row 29, column 16, color 3
	sw	$0, 3896($t0)		# erase the unit on row 30, column 14, color 3
	sw	$0, 3900($t0)		# erase the unit on row 30, column 15, color 3
	sw	$0, 3904($t0)		# erase the unit on row 30, column 16, color 3
	sw	$0, 4024($t0)		# erase the unit on row 31, column 14, color 3
	sw	$0, 4028($t0)		# erase the unit on row 31, column 15, color 3
	sw	$0, 4032($t0)		# erase the unit on row 31, column 16, color 3
Exit:
	li	$v0, 10			# terminate the program gracefuly
	syscall