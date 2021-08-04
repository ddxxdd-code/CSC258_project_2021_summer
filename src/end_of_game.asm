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
	sw	$t2, 2448($t0)		#paint the unit on row 19, column 4, color 2
	sw	$t1, 2452($t0)		#paint the unit on row 19, column 5, color 1
	sw	$t1, 2456($t0)		#paint the unit on row 19, column 6, color 1
	sw	$t2, 2468($t0)		#paint the unit on row 19, column 9, color 2
	sw	$t1, 2472($t0)		#paint the unit on row 19, column 10, color 1
	sw	$t1, 2476($t0)		#paint the unit on row 19, column 11, color 1
	sw	$t2, 2488($t0)		#paint the unit on row 19, column 14, color 2
	sw	$t1, 2492($t0)		#paint the unit on row 19, column 15, color 1
	sw	$t1, 2496($t0)		#paint the unit on row 19, column 16, color 1
	sw	$t2, 2508($t0)		#paint the unit on row 19, column 19, color 2
	sw	$t1, 2512($t0)		#paint the unit on row 19, column 20, color 1
	sw	$t1, 2516($t0)		#paint the unit on row 19, column 21, color 1
	sw	$t2, 2528($t0)		#paint the unit on row 19, column 24, color 2
	sw	$t1, 2532($t0)		#paint the unit on row 19, column 25, color 1
	sw	$t1, 2536($t0)		#paint the unit on row 19, column 26, color 1
	sw	$t1, 2576($t0)		#paint the unit on row 20, column 4, color 1
	sw	$t1, 2588($t0)		#paint the unit on row 20, column 7, color 1
	sw	$t1, 2596($t0)		#paint the unit on row 20, column 9, color 1
	sw	$t1, 2608($t0)		#paint the unit on row 20, column 12, color 1
	sw	$t1, 2616($t0)		#paint the unit on row 20, column 14, color 1
	sw	$t1, 2628($t0)		#paint the unit on row 20, column 17, color 1
	sw	$t1, 2636($t0)		#paint the unit on row 20, column 19, color 1
	sw	$t1, 2648($t0)		#paint the unit on row 20, column 22, color 1
	sw	$t1, 2656($t0)		#paint the unit on row 20, column 24, color 1
	sw	$t1, 2668($t0)		#paint the unit on row 20, column 27, color 1
	sw	$t1, 2704($t0)		#paint the unit on row 21, column 4, color 1
	sw	$t1, 2716($t0)		#paint the unit on row 21, column 7, color 1
	sw	$t1, 2724($t0)		#paint the unit on row 21, column 9, color 1
	sw	$t1, 2736($t0)		#paint the unit on row 21, column 12, color 1
	sw	$t1, 2744($t0)		#paint the unit on row 21, column 14, color 1
	sw	$t1, 2756($t0)		#paint the unit on row 21, column 17, color 1
	sw	$t1, 2764($t0)		#paint the unit on row 21, column 19, color 1
	sw	$t1, 2776($t0)		#paint the unit on row 21, column 22, color 1
	sw	$t1, 2784($t0)		#paint the unit on row 21, column 24, color 1
	sw	$t1, 2796($t0)		#paint the unit on row 21, column 27, color 1
	sw	$t1, 2832($t0)		#paint the unit on row 22, column 4, color 1
	sw	$t1, 2844($t0)		#paint the unit on row 22, column 7, color 1
	sw	$t1, 2852($t0)		#paint the unit on row 22, column 9, color 1
	sw	$t1, 2864($t0)		#paint the unit on row 22, column 12, color 1
	sw	$t1, 2872($t0)		#paint the unit on row 22, column 14, color 1
	sw	$t1, 2884($t0)		#paint the unit on row 22, column 17, color 1
	sw	$t1, 2892($t0)		#paint the unit on row 22, column 19, color 1
	sw	$t1, 2904($t0)		#paint the unit on row 22, column 22, color 1
	sw	$t1, 2912($t0)		#paint the unit on row 22, column 24, color 1
	sw	$t1, 2924($t0)		#paint the unit on row 22, column 27, color 1
	sw	$t1, 2964($t0)		#paint the unit on row 23, column 5, color 1
	sw	$t1, 2968($t0)		#paint the unit on row 23, column 6, color 1
	sw	$t1, 2984($t0)		#paint the unit on row 23, column 10, color 1
	sw	$t1, 2988($t0)		#paint the unit on row 23, column 11, color 1
	sw	$t1, 3004($t0)		#paint the unit on row 23, column 15, color 1
	sw	$t1, 3008($t0)		#paint the unit on row 23, column 16, color 1
	sw	$t1, 3024($t0)		#paint the unit on row 23, column 20, color 1
	sw	$t1, 3028($t0)		#paint the unit on row 23, column 21, color 1
	sw	$t1, 3044($t0)		#paint the unit on row 23, column 25, color 1
	sw	$t1, 3048($t0)		#paint the unit on row 23, column 26, color 1
Exit:
	li	$v0, 10			# terminate the program gracefuly
	syscall