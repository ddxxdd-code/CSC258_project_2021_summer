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
Exit:
	li	$v0, 10			# terminate the program gracefuly
	syscall