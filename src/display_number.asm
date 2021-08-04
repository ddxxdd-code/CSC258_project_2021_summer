# Display number
# Dedong Xie 2021-08-04
#

main:
	li	$v0, 0x10008000
	li	$v1, 9
	jal	displayNumber
	li	$v0, 10
	syscall
	
displayNumber:
	addi	$t1, $v0, 0
	addi	$t0, $v1, 0
	li	$t2, 0xffffff
	
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