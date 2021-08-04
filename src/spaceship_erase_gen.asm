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
	sw	$0, 4($t0)		# erase the unit on row 0, column 1, color 2
	sw	$0, 8($t0)		# erase the unit on row 0, column 2, color 2
	sw	$0, 128($t0)		# erase the unit on row 1, column 0, color 1
	sw	$0, 132($t0)		# erase the unit on row 1, column 1, color 1
	sw	$0, 136($t0)		# erase the unit on row 1, column 2, color 1
	sw	$0, 140($t0)		# erase the unit on row 1, column 3, color 1
	sw	$0, 256($t0)		# erase the unit on row 2, column 0, color 1
	sw	$0, 260($t0)		# erase the unit on row 2, column 1, color 1
	sw	$0, 264($t0)		# erase the unit on row 2, column 2, color 1
	sw	$0, 388($t0)		# erase the unit on row 3, column 1, color 1
Exit:
	li	$v0, 10			# terminate the program gracefuly
	syscall