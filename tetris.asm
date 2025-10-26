################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Ip Fong Wong, 1009320209
# Student 2: Name, Student Number (if applicable)
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       8
# - Unit height in pixels:      8
# - Display width in pixels:    160
# - Display height in pixels:   168
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
    board: .space 1680
    tetromino: .space 32
    collision_detect: .space 1680
    score: .space 1680
    
    down_sound: .word 96
    down_volume: .word 100
    down_notes:
        .word 60
              
    down_duration:
        .word 100
    down_melody1_index: .word 0
    down_melody1_cd: .word 0
    down_melody1_length: .word 1
    
    left_sound: .word 24
    left_volume: .word 100
    left_notes:
        .word 60
              
    left_duration:
        .word 100
    left_melody1_index: .word 0
    left_melody1_cd: .word 0
    left_melody1_length: .word 1
    
    right_sound: .word 32
    right_volume: .word 100
    right_notes:
        .word 60
              
    right_duration:
        .word 100
    right_melody1_index: .word 0
    right_melody1_cd: .word 0
    right_melody1_length: .word 1
    
    rotate_sound: .word 120
    rotate_volume: .word 100
    rotate_notes:
        .word 60
              
    rotate_duration:
        .word 100
    rotate_melody1_index: .word 0
    rotate_melody1_cd: .word 0
    rotate_melody1_length: .word 1
    
    number: .word
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0x000000, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff
    0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0x000000, 0x000000, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000,
    0xffffff, 0xffffff, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff
    0xffffff, 0x000000, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0x000000, 0x000000, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000,
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000,
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0x000000, 0x000000, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0x000000, 0x000000, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff
    0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x000000, 0xffffff,
    0xffffff, 0xffffff, 0xffffff, 0x000000, 0x000000, 0xffffff,
    0x000000, 0x000000, 0xffffff
    number_space: .word 1100, 1104, 1108, 1180, 1184, 1188, 1260, 1264, 1268, 1340, 1344, 1348, 1420, 1424, 1428
    score: .word 1
    square: .word 80
    percussion: .word 118
    square_volume: .word 20
    percussion_volume: .word 30
    time_step: .word 50
    notes1:
        .word 76 71 72 74 76 74 72 71 # A
              69 69 72 76 74 72
              71 64 71 72 74 76
              72 69 69
              74 77 81 72 72 79 77
              76 72 76 69 67 74 72
              71 64 71 72 74 68 76 68
              72 64 69 69
              76 71 72 74 76 74 72 71 # B
              69 69 72 76 74 72
              71 64 71 72 74 76
              72 69 69
              74 77 81 72 72 79 77
              76 72 76 69 67 74 72
              71 64 71 72 74 68 76 68
              72 64 69 69 # C
              64 60 
              62 59
              60 57
              56
              64 60 
              62 59
              60 64 69 69
              68 0
              
    duration1:
        .word 400 200 200 200 100 100 200 200 # A
              400 200 200 400 200 200
              200 200 200 200 400 400
              400 400 800
              600 200 200 100 100 200 200
              600 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 400 800
              400 200 200 200 100 100 200 200 # b
              400 200 200 400 200 200
              200 200 200 200 400 400
              400 400 800
              600 200 200 100 100 200 200
              600 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 400 800
              800 800 # C
              800 800
              800 800
              1600
              800 800
              800 800
              400 400 400 400
              800 800
    melody1_index: .word 0
    melody1_cd: .word 0
    melody1_length: .word 115
    
    notes2:
        .word 0 68 69 71 72 71 69 68 # A
              64 64 69 72 71 69
              68 0 68 69 71 72
              69 64 64
              65 69 72 0 0 71 69
              67 64 67 0 0 65 64
              68 0 68 69 71 0 72 0
              69 0 64 64
              0 68 69 71 72 71 69 68 # B
              64 64 69 72 71 69
              68 0 68 69 71 72
              69 64 64
              65 69 72 0 0 71 69
              67 64 67 0 0 65 64
              68 0 68 69 71 0 72 0
              69 0 64 64
              60 57 # C
              59 56
              57 52
              52
              60 57
              59 56
              57 60 64 57
              59 0
    duration2:
        .word 400 200 200 200 100 100 200 200 # A
              400 200 200 400 200 200
              200 200 200 200 400 400
              400 400 800
              600 200 200 100 100 200 200
              600 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 400 800
              400 200 200 200 100 100 200 200 # B
              400 200 200 400 200 200
              200 200 200 200 400 400
              400 400 800
              600 200 200 100 100 200 200
              600 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 400 800
              800 800 #C
              800 800
              800 800
              1600
              800 800
              800 800
              400 400 400 400
              800 800
    melody2_index: .word 0
    melody2_cd: .word 0
    
    notes3:
        .word 40 52 40 52 40 52 40 52 # A
              45 57 45 57 45 57 45 57
              44 56 44 56 40 52 40 52
              45 57 45 57 45 57 47 48
              50 38 0 38 0 38 45 41
              36 48 0 48 36 43 43 0
              47 59 0 59 0 52 0 56
              45 57 45 57 45
              40 52 40 52 40 52 40 52 # B
              45 57 45 57 45 57 45 57
              44 56 44 56 40 52 40 52
              45 57 45 57 45 57 47 48
              50 38 0 38 0 38 45 41
              36 48 0 48 36 43 43 0
              47 59 0 59 0 52 0 56
              45 57 45 57 45
              57 64 57 64 57 64 57 64 # C
              56 64 56 64 56 64 56 64
              57 64 57 64 57 64 57 64
              56 64 56 64 56 64 56 64
              57 64 57 64 57 64 57 64
              56 64 56 64 56 64 56 64
              57 64 57 64 57 64 57 64
              56 64 56 64 0
    duration3:
        .word 200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 800
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 800
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 800
    melody3_index: .word 0
    melody3_cd: .word 0
    
    # percussion
    notes4:
        .word 0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
              0 40 0 40 0 40 40 0 40
              0 40 0 40 0 40 40 40
    duration4:
        .word 200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
              200 200 200 200 200 100 100 200 200
              200 200 200 200 200 200 200 200
    melody4_index: .word 0
    melody4_cd: .word 0


##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.
main:
    li $v0, 33
    li $a0, 0
    li $a1, 0
    lw $a2, square
    lw $a3, square_volume
    syscall
    li $v0, 33
    li $a0, 0
    li $a1, 0
    lw $a2, percussion
    lw $a3, percussion_volume
    syscall
    
    # init
    jal reset_index
    # Initialize the game
    li $s3, 0xff0000        # Load red into $a0
    li $s4, 0x282628        # Load grey into $a1
    li $s5, 0        # Load 0 into $a2
    la $t0, board             # Load the address of the array into $t0
    la $t8, collision_detect             # Load the address of the array into $t0
    li $s0, 1680             # Load the maximum of the array into $t2
    li $s1, 20             # Load the maximum of the array into $t2
    li $s2, 4               # Load the blocks of the tetromino into $s2
    li $t3, 20                 # Load 4 into $t3
    li $t4, 0                  # Load 0 into $t4
    li $t5, 0                 # Load 0 into $t5
    li $t6, 0                # Load 0 into $t6
    li $t1, 0                # Load 0 into $t1
    li $t7, 12                # Load 0 into $t7
    li $t9, 1                # Load 0 into $t9
    
    even_odd:
    li $t4, 0                  # Load 0 into $t4
    li $t5, 0                # Load 0 into $t5
    sw $s3, 0($t0) # Store adress $a0 at memory location array + 0
    sw $t9, 0($t8) # Store adress $t9 at memory location array + 0
    addi $t0, $t0, 4   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 4   # Assuming each integer takes 4 bytes, increment index by 4
    andi $t2, $t6, 1          # Perform bitwise AND between $t0 and 1, result in $t1
    beq $t2, 0, even          # If the result is 0, number is even, jump to Even label
    addi $t0, $t0, -4   # Assuming each integer takes 4 bytes, increment index by -4
    addi $t8, $t8, -4   # Assuming each integer takes 4 bytes, increment index by -4
    j odd                     # Else, number is odd, jump to Odd label
     
    even:
    sw $s4, 0($t0) # Store adress $t1 at memory location array + 0
    addi $t0, $t0, 8   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 8   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t4, $t4, 4   # Assuming each integer takes 4 bytes, increment index by 4
    bne $t4, $t3, even
    sw $s3, 0($t0) # Store adress $a0 at memory location array + 0
    sw $t9, 0($t8) # Store adress $t9 at memory location array + 0
    addi $t0, $t0, 36   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 36   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t6, $t6, 1   # Assuming each integer takes 4 bytes, increment index by 4
    bne $t6, $s1, even_odd
    j game_loop
    
    odd:
    addi $t0, $t0, 8   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 8   # Assuming each integer takes 4 bytes, increment index by 4
    sw $s4, 0($t0) # Store adress $t1 at memory location array + 0
    addi $t5, $t5, 4   # Assuming each integer takes 4 bytes, increment index by 4
    bne $t5, $t3, odd
    addi $t0, $t0, 4   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 4   # Assuming each integer takes 4 bytes, increment index by 4
    sw $s3, 0($t0) # Store adress $t1 at memory location array + 0
    sw $t9, 0($t8) # Store adress $t1 at memory location array + 0
    addi $t0, $t0, 36   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 36   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t6, $t6, 1   # Assuming each integer takes 4 bytes, increment index by 4
    beq $t6, $s1, bottom
    bne $t6, $s1, even_odd
    
    bottom:
    addi $t2, $zero, 2
    sw $s3, 0($t0) # Store adress $t1 at memory location array + 0
    sw $t2, 0($t8) # Store adress $t1 at memory location array + 0
    addi $t0, $t0, 4   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t8, $t8, 4   # Assuming each integer takes 4 bytes, increment index by 4
    addi $t1, $t1, 1   # Assuming each integer takes 4 bytes, increment index by 4
    bne $t1, $t7, bottom
    
    preview_pannel:
        la $t0, board
        li $t1, 0
        preview_pannel_top_bottom:
            li $t2, 8
            sw $s3, 48($t0)
            sw $s3, 688($t0)
            addi $t0, $t0, 4
            addi $t1, $t1, 1
            bne $t1, $t2, preview_pannel_top_bottom
        la $t0, board
        li $t1, 0
        preview_pannel_left_right:
            li $t2, 8
            sw $s3, 48($t0)
            sw $s3, 76($t0)
            addi $t0, $t0, 80
            addi $t1, $t1, 1
            bne $t1, $t2, preview_pannel_left_right
        la $t0, board
        li $t1, 0
        li $t3, 0x0000ff
        preview_pannel_tetro:
            li $t2, 4
            sw $t3, 376($t0)
            addi $t0, $t0, 4
            addi $t1, $t1, 1
            bne $t1, $t2, preview_pannel_tetro
    
    I_tetromino:
    la $t0, tetromino # Load the address of the array into $t0
    li $t1, 4
    li $t2, 0
    li $t3, 5
    li $t4, 0
    li $t5, 6
    li $t6, 0
    li $t7, 7
    li $t8, 0
    sw $t1, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t2, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t3, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t4, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t5, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t6, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t7, 0($t0) # Store adress $a0 at memory location array + 0
    addi $t0, $t0, 4
    sw $t8, 0($t0) # Store adress $a0 at memory location array + 0
    
    # I_tetromino:
    # la $t0, tetromino # Load the address of the array into $t0
    # lw $t1, ADDR_DSPL # Load the address of the board
    # addi $t1, $t1, 16
    # sw $t1, 0($t0) # Store adress $a0 at memory location array + 0
    # addi $t0, $t0, 4
    # addi $t1, $t1, 4
    # sw $t1, 0($t0) # Store adress $a0 at memory location array + 0
    # addi $t0, $t0, 4
    # addi $t1, $t1, 4
    # sw $t1, 0($t0) # Store adress $a0 at memory location array + 0
    # addi $t0, $t0, 4
    # addi $t1, $t1, 4
    # sw $t1, 0($t0) # Store adress $a0 at memory location array + 0

game_loop:

    initialize_board:
	la $t0, board     # Load the address of the array into $t0
	lw $t1, ADDR_DSPL         # Load the base address of the bitmap into $t1
	li $t2, 0  # Load 0 into $t2
	draw_board:
	lw $t3, 0($t0)  # Load the current RGB word from the board array into $t3
	sw $t3, 0($t1)  # Store the word into the target memory location
	addi $t0, $t0, 4  # Increment the board array address pointer by 4 bytes to the next RGB value
	addi $t1, $t1, 4  # Increment the target memory address pointer by 4 bytes
	addi $t2, $t2, 4   # Assuming each integer takes 4 bytes, increment index by 4
	bne $t2, $s0, draw_board
	
	draw_placed_tetromino:
	la $t0, collision_detect
	lw $t4, ADDR_DSPL
	li $t5, 0
	li $t2, 0x0000FF
	actual_draw:
	lw $t1, 0($t0)
	beq $t1, -1, can_draw_placed_tetromino
	j go_next
	can_draw_placed_tetromino:
	sw $t2, 0($t4)
	go_next:
	addi $t4, $t4, 4
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	bne $t5, $s0,actual_draw
	
	initialize_tetromino:
	la $t0, tetromino     # Load the address of the array into $t0
	lw $t1, ADDR_DSPL         # Load the base address of the bitmap into $t1
	li $t2, 0  # Load 0 into $t2
	li $t9, 80
	li $t6, 0x0000FF        # Load the blue pixel value into $t5 (adjust as per your bitmap format)
	li $t8, 4
	draw_tetromino:
	lw $t1, ADDR_DSPL     # Load the address of the array into $t0
	lw $t3, 0($t0)          # Load one of the addresses from the tetromino array into $t4
	addi $t0, $t0, 4
	lw $t4, 0($t0)
	addi $t0, $t0, 4
	mul $t5, $t4, $t9
	add $t1, $t1, $t5
	mul $t3, $t3, $t8
	add $t1, $t1, $t3
	sw $t6, 0($t1)
	addi $t1, $t1, 4
	addi $t2, $t2, 1        # Increment loop counter
	bne $t2, $s2, draw_tetromino

	# 1a. Check if key has been pressed
	key_pressed:
	jal play_each_loop
    
    

    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    bne $t8, 1, no_input      # If first word 1, key is pressed
    #b game_loop
    # 1b. Check which key has been pressed
    keyboard_input:                     # A key is pressed
    lw $s3, 4($t0)                  # Load second word from keyboard
    beq $s3, 0x71, respond_to_Q     # Check if the key q was pressed
    beq $s3, 0x73, respond_to_S     # Check if the key s was pressed
    beq $s3, 0x61, respond_to_A     # Check if the key a was pressed
    beq $s3, 0x64, respond_to_D     # Check if the key d was pressed
    beq $s3, 0x77, respond_to_W     # Check if the key w was pressed
    beq $s3, 0x70, respond_to_P     # Check if the key p was pressed
    beq $s3, 0x72, respond_to_R     # Check if the key p was pressed
    no_input:
    # sleep time step
    li $v0, 32
    lw $a0, time_step
    syscall

    # li $v0, 1                       # ask system to print $a0
    # syscall

    b key_pressed
    respond_to_Q:
	li $v0, 10                      # Quit gracefully
	syscall
	respond_to_S:
	play_down_melodies:
    # init
    li $t0, -1
    sw $t0, down_melody1_index
    sw $zero, down_melody1_cd

play_down_melody:
    
    # else play next note
    # increase index
    lw $t0, down_melody1_index
    addi $t0, $t0, 1
    sw $t0, down_melody1_index
    
    # load note and duration base address
    la $t0, down_notes
    la $t1, down_duration
    
    # compute offset
    lw $t2, down_melody1_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, down_sound
    lw $a3, down_volume
    syscall
	
	check_line:
    la $t0, collision_detect
    li $t2, 0
    li $t3, 12
    li $t5, 0
    li $t6, 1600
    check:
    beq $t5, $t6, finished_check
    beq $t2, $t3, clear_line
    lw $t4, 0($t0)
    addi $t5, $t5, 4
    addi $t0, $t0, 4
    bne $t4, 0, add_count
    j move_next
    add_count:
    addi $t2, $t2, 1
    j check
    move_next:
    add $t2, $zero, $zero
    j check
    clear_line:
    addi $t0, $t0, -8
    li $t2, 0
    li $t3, 10
    real_clear:
    sw $zero, 0($t0)
    addi $t0, $t0, -4
    addi $t2, $t2, 1
    bne $t3, $t2, real_clear
    
    draw_score:
        li $t3, 15
        li $t4, 60
        la $t1, score
        lw $t2, 0($t1)
        mult $t4, $t2, $t4
        add $t2, $t2, 1
        sw $t2, 0($t1)
        la $t9, number_space
        la $s6, number
        add $s6, $s6, $t4
        actual_draw_score:
        la $t8, board
        lw $s4, 0($t9)
        lw $s7, 0($s6)
        add $t8, $t8, $s4
        sw $s7, 0($t8)
        add $s6, $s6, 4
        add $t9, $t9, 4
        addi $t3, $t3, -1
        bnez $t3, actual_draw_score
    
    move_above_down:
    la $t4, collision_detect
    li $t2, -1
    addi $t1, $t0, -4
    add $t7, $zero, $t1
    j can_do
    check_hv_block:
    beq $t4, $t7, trytry
    add $t1, $zero, $t7
    #addi $t1, $t1, -4
    can_do:
    lw $t3, 0($t1)
    beq $t3, -1, move_down_one_line
    addi $t7, $t7, -4
    j check_hv_block
    move_down_one_line:
    sw $zero, 0($t1)
    add $t7, $zero, $t1
    addi $t1, $t1, 80
    sw $t2, 0($t1)
    addi $t7, $t7, -4
    bne $t4, $t7, check_hv_block
    trytry:
    li $t2, 0
    bne $t5, $t6, check
    
	finished_check:
	la $t0, tetromino # Load the address of the array into $t0
    li $t1, 8             # Load the size of the array into $t1
    li $t2, 0                # Initialize loop counter $t2 to 0
    li $t3, 80                # Value to increment each element by 80
    addi $t0, $t0 ,-4
    down_check_collision:
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, placed
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, placed
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, placed
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, placed
    beq $t8, $zero,down_I_tetromino
    
    placed:
    li $t1, -1
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    li $t3, 0
    li $t2, 4
    #li $t0, 0x0000FF
    add $s5, $zero, $zero
    replacing:
    la $t5, collision_detect
    #la $t7, board
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    #addi $t7, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    #add $t7, $t7, $t9
    add $t5, $t5, $t8
    #add $t7, $t7, $t8
    sw $t1, 0($t5)
    #sw $t0, 0($t7)
    addi $t4, $t4, 4
    addi $t3, $t3, 1
    bne $t3, $t2, replacing
    
    # b game_loop
    
    j I_tetromino
    
    down_I_tetromino:
    #la $t0, tetromino # Load the address of the array into $t0
    addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, 1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    
    addi $t2, $t2, 1         # Increment loop counter
    bne $t2, $t1 down_I_tetromino                   # Jump back to the start of the loop
    b game_loop
    respond_to_A:
    play_left_melodies:
    # init
    li $t0, -1
    sw $t0, left_melody1_index
    sw $zero, left_melody1_cd

play_left_melody:
    
    # else play next note
    # increase index
    lw $t0, left_melody1_index
    addi $t0, $t0, 1
    sw $t0, left_melody1_index
    
    # load note and duration base address
    la $t0, left_notes
    la $t1, left_duration
    
    # compute offset
    lw $t2, left_melody1_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, left_sound
    lw $a3, left_volume
    syscall
    
	la $t0, tetromino # Load the address of the array into $t0
    li $t1, 4             # Load the size of the array into $t1
    li $t2, 0                # Initialize loop counter $t2 to 0
    li $t3, -4                # Value to increment each element by
    
    left_check_collision:
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t8, -1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t8, -1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t8, -1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t7, $t8, -1
    mul $t8, $t8, 4
    mul $t9, $t7, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    
    left_I_tetromino:
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, -1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    
    addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
    addi $t2, $t2, 1         # Increment loop counter
    bne $t2, $t1 left_I_tetromino                   # Jump back to the start of the loop
    b game_loop
    respond_to_D:
    play_right_melodies:
    # init
    li $t0, -1
    sw $t0, right_melody1_index
    sw $zero, right_melody1_cd

play_right_melody:
    
    # else play next note
    # increase index
    lw $t0, right_melody1_index
    addi $t0, $t0, 1
    sw $t0, right_melody1_index
    
    # load note and duration base address
    la $t0, right_notes
    la $t1, right_duration
    
    # compute offset
    lw $t2, right_melody1_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, right_sound
    lw $a3, right_volume
    syscall
    
	la $t0, tetromino # Load the address of the array into $t0
    li $t1, 4             # Load the size of the array into $t1
    li $t2, 0                # Initialize loop counter $t2 to 0
    li $t3, 4                # Value to increment each element by
    
    right_check_collision:
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    la $t5, collision_detect
    addi $t4, $t4, 4
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    bne $t8, $zero, game_loop
    
    right_I_tetromino:
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, 1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    
    addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
    addi $t2, $t2, 1         # Increment loop counter
    bne $t2, $t1 right_I_tetromino                   # Jump back to the start of the loop
    b game_loop
    respond_to_W:
    play_rotate_melodies:
    # init
    li $t0, -1
    sw $t0, rotate_melody1_index
    sw $zero, rotate_melody1_cd

play_rotate_melody:
    
    # else play next note
    # increase index
    lw $t0, rotate_melody1_index
    addi $t0, $t0, 1
    sw $t0, rotate_melody1_index
    
    # load note and duration base address
    la $t0, rotate_notes
    la $t1, rotate_duration
    
    # compute offset
    lw $t2, rotate_melody1_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, rotate_sound
    lw $a3, rotate_volume
    syscall
    
	la $t0, tetromino # Load the address of the array into $t0
    li $t1, 4             # Load the size of the array into $t1
    li $t2, 0                # Initialize loop counter $t2 to 0
    li $t3, 4                # Value to increment each element by
    addi $s5, $s5, 1
    li $t6, 1                # Initialize loop counter $t6 to 0
    li $t7, 2                # Initialize loop counter $t7 to 0
    li $t8, 3                # Initialize loop counter $t8 to 0
    li $t9, 4                # Initialize loop counter $t9 to 0
    beq $s5, $t6 first_rotate_I_tetromino
    beq $s5, $t7 second_rotate_I_tetromino
    beq $s5, $t8 third_rotate_I_tetromino
    beq $s5, $t9 fourth_rotate_I_tetromino
    
    first_rotate_I_tetromino:
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    addi $t4, $t4, 8
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, -1
    addi $t6, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    beq $t8, $zero, first_continue
    add $s5, $zero, $zero
    bne $t8, $zero, game_loop
    
    first_continue:
        la $t5, collision_detect
        addi $t4, $t4, 4
        lw $t8, 0($t4)
        addi $t4, $t4, 4
        lw $t6, 0($t4)
        addi $t8, $t8, -2
        addi $t6, $t6, 2
        mul $t8, $t8, 4
        mul $t9, $t6, 80
        add $t5, $t5, $t9
        add $t5, $t5, $t8
        lw $t8, 0($t5)
        beq $t8, $zero, first_continue1
        add $s5, $zero, $zero
        bne $t8, $zero, game_loop
    first_continue1:
        la $t5, collision_detect
        addi $t4, $t4, 4
        lw $t8, 0($t4)
        addi $t4, $t4, 4
        lw $t6, 0($t4)
        addi $t8, $t8, -3
        addi $t6, $t6, 3
        mul $t8, $t8, 4
        mul $t9, $t6, 80
        add $t5, $t5, $t9
        add $t5, $t5, $t8
        lw $t8, 0($t5)
        beq $t8, $zero, can_first_rotate
        add $s5, $zero, $zero
        bne $t8, $zero, game_loop
    
    can_first_rotate:
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, 1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, -2        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, 2        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, -3        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, 3        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    b game_loop
    second_rotate_I_tetromino:
        la $t4, tetromino # Load the address of the array into $t0
        la $t5, collision_detect
        addi $t4, $t4, 8
        lw $t8, 0($t4)
        addi $t4, $t4, 4
        lw $t6, 0($t4)
        addi $t8, $t8, -1
        addi $t6, $t6, -1
        mul $t8, $t8, 4
        mul $t9, $t6, 80
        add $t5, $t5, $t9
        add $t5, $t5, $t8
        lw $t8, 0($t5)
        beq $t8, $zero, continue
        add $s5, $zero, 1
        bne $t8, $zero, game_loop
        continue:
            la $t5, collision_detect
            addi $t4, $t4, 4
            lw $t8, 0($t4)
            addi $t4, $t4, 4
            lw $t6, 0($t4)
            addi $t8, $t8, -2
            addi $t6, $t6, -2
            mul $t8, $t8, 4
            mul $t9, $t6, 80
            add $t5, $t5, $t9
            add $t5, $t5, $t8
            lw $t8, 0($t5)
            beq $t8, $zero, continue1
            add $s5, $zero, 1
            bne $t8, $zero, game_loop
        continue1:
            la $t5, collision_detect
            addi $t4, $t4, 4
            lw $t8, 0($t4)
            addi $t4, $t4, 4
            lw $t6, 0($t4)
            addi $t8, $t8, -3
            addi $t6, $t6, -3
            mul $t8, $t8, 4
            mul $t9, $t6, 80
            add $t5, $t5, $t9
            add $t5, $t5, $t8
            lw $t8, 0($t5)
            beq $t8, $zero, can_second_rotate
            add $s5, $zero, 1
            bne $t8, $zero, game_loop
    
        can_second_rotate:
            lw $t4, 0($t0)           # Load the current element of the array into $t4
            addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
            add $t4, $t4, -1        # Add the increment value to the current element
            sw $t4, 0($t0)           # Store the updated value back into the array
            addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
            lw $t4, 0($t0)           # Load the current element of the array into $t4
            add $t4, $t4, -1        # Add the increment value to the current element
            sw $t4, 0($t0)           # Store the updated value back into the array
            addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
            lw $t4, 0($t0)           # Load the current element of the array into $t4
            add $t4, $t4, -2        # Add the increment value to the current element
            sw $t4, 0($t0)           # Store the updated value back into the array
            addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
            lw $t4, 0($t0)           # Load the current element of the array into $t4
            add $t4, $t4, -2        # Add the increment value to the current element
            sw $t4, 0($t0)           # Store the updated value back into the array
            addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
            lw $t4, 0($t0)           # Load the current element of the array into $t4
            add $t4, $t4, -3        # Add the increment value to the current element
            sw $t4, 0($t0)           # Store the updated value back into the array
            addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
            lw $t4, 0($t0)           # Load the current element of the array into $t4
            add $t4, $t4, -3        # Add the increment value to the current element
            sw $t4, 0($t0)           # Store the updated value back into the array
        b game_loop
    third_rotate_I_tetromino:
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    addi $t4, $t4, 8
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, 1
    addi $t6, $t6, -1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    beq $t8, $zero, can_third_rotate
    add $s5, $zero, 2
    bne $t8, $zero, game_loop
    
    can_third_rotate:
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, 1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    addi $t4, $t4, -1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 2        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, -2        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 3        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, -3        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    b game_loop
    
    fourth_rotate_I_tetromino:
    la $t4, tetromino # Load the address of the array into $t0
    la $t5, collision_detect
    addi $t4, $t4, 8
    lw $t8, 0($t4)
    addi $t4, $t4, 4
    lw $t6, 0($t4)
    addi $t8, $t8, 1
    addi $t6, $t6, 1
    mul $t8, $t8, 4
    mul $t9, $t6, 80
    add $t5, $t5, $t9
    add $t5, $t5, $t8
    lw $t8, 0($t5)
    beq $t8, $zero, forth_continue
    add $s5, $zero, 3
    bne $t8, $zero, game_loop
    
    forth_continue:
        la $t5, collision_detect
        addi $t4, $t4, 4
        lw $t8, 0($t4)
        addi $t4, $t4, 4
        lw $t6, 0($t4)
        addi $t8, $t8, 2
        addi $t6, $t6, 2
        mul $t8, $t8, 4
        mul $t9, $t6, 80
        add $t5, $t5, $t9
        add $t5, $t5, $t8
        lw $t8, 0($t5)
        beq $t8, $zero, forth_continue1
        add $s5, $zero, 3
        bne $t8, $zero, game_loop
    forth_continue1:
        la $t5, collision_detect
        addi $t4, $t4, 4
        lw $t8, 0($t4)
        addi $t4, $t4, 4
        lw $t6, 0($t4)
        addi $t8, $t8, 3
        addi $t6, $t6, 3
        mul $t8, $t8, 4
        mul $t9, $t6, 80
        add $t5, $t5, $t9
        add $t5, $t5, $t8
        lw $t8, 0($t5)
        beq $t8, $zero, can_forth_rotate
        add $s5, $zero, 3
        bne $t8, $zero, game_loop
    
    can_forth_rotate:
    addi $t0, $t0, 8         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 1        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 2        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 2        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 3        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    addi $t0, $t0, 4         # Move to the next element in the array (4 bytes per element)
    lw $t4, 0($t0)           # Load the current element of the array into $t4
    add $t4, $t4, 3        # Add the increment value to the current element
    sw $t4, 0($t0)           # Store the updated value back into the array
    add $s5, $zero, $zero
    b game_loop
    
    respond_to_P:
        lw $t1, ADDR_DSPL
        li $t2, 0xffffff
        li $t3, 0
        li $t4, 15
        draw_pause:
            sw $t2, 256($t1)
            sw $t2, 260($t1)
            sw $t2, 264($t1)
            sw $t2, 268($t1)
            sw $t2, 272($t1)
            sw $t2, 284($t1)
            sw $t2, 288($t1)
            sw $t2, 292($t1)
            sw $t2, 296($t1)
            sw $t2, 300($t1)
            addi $t1, $t1, 80
            addi $t3, $t3, 1
            bne $t3, $t4, draw_pause
        li $v0, 32
        li $s3, 1
        syscall
        lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
        lw $t8, 0($t0)                  # Load first word from keyboard
        bne $t8, 1, respond_to_P     # If first word 1, key is pressed
        P_key_pressed:
            lw $s3, 4($t0)                  # Load second word from keyboard
            beq $s3, 0x70, game_loop     # Check if the key p was pressed
            b respond_to_P
            
    respond_to_R:
        b main
        
    play_each_loop:
    # play each melody
    addi $sp $sp -4
    sw $ra 0($sp)
    jal play_notes
    lw $ra 0($sp)
    addi $sp $sp 4
    
    addi $sp $sp -4
    sw $ra 0($sp)
    jal descrease_cd
    lw $ra 0($sp)
    addi $sp $sp 4
    
    # reset melody1 index if length reached
    lw $t0 melody1_length
    lw $t1 melody1_index
    bne $t1 $t0 return_play
    move $s0 $ra
    jal reset_index
    move $ra $s0
return_play:
    jr $ra

reset_index:
    li $t0, -1
    sw $t0, melody1_index
    sw $zero, melody1_cd
    sw $t0, melody2_index
    sw $zero, melody2_cd
    sw $t0, melody3_index
    sw $zero, melody3_cd
    sw $t0, melody4_index
    sw $zero, melody4_cd
    jr $ra
    
descrease_cd:
    # decrease cd
    lw $t0, melody1_cd
    lw $t1, time_step
    sub $t0, $t0, $t1
    sw $t0, melody1_cd
    
    lw $t0, melody2_cd
    lw $t1, time_step
    sub $t0, $t0, $t1
    sw $t0, melody2_cd
    
    lw $t0, melody3_cd
    lw $t1, time_step
    sub $t0, $t0, $t1
    sw $t0, melody3_cd
    
    lw $t0, melody4_cd
    lw $t1, time_step
    sub $t0, $t0, $t1
    sw $t0, melody4_cd
    
    jr $ra

play_notes:
    addi $sp $sp -4
    sw $ra 0($sp)
    jal play_melody1
    lw $ra 0($sp)
    addi $sp $sp 4
    
    addi $sp $sp -4
    sw $ra 0($sp)
    jal play_melody2
    lw $ra 0($sp)
    addi $sp $sp 4
    
    addi $sp $sp -4
    sw $ra 0($sp)
    jal play_melody3
    lw $ra 0($sp)
    addi $sp $sp 4
    
    addi $sp $sp -4
    sw $ra 0($sp)
    jal play_melody4
    lw $ra 0($sp)
    addi $sp $sp 4
    
    jr $ra

play_melody1:
    lw $t0, melody1_cd
    bne $t0 $zero return_play_melody1 # do nothing if melody1_cd is not 0
    
    # else play next note
    # increase index
    lw $t0, melody1_index
    addi $t0, $t0, 1
    sw $t0, melody1_index
    
    # load note and duration base address
    la $t0, notes1
    la $t1, duration1
    
    # compute offset
    lw $t2, melody1_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, square
    lw $a3, square_volume
    syscall
    
    # set cd
    lw $t0, 0($t1)
    sw $t0, melody1_cd
    
return_play_melody1:
    jr $ra

play_melody2:
    lw $t0, melody2_cd
    bne $t0 $zero return_play_melody2 # do nothing if melody2_cd is not 0
    
    # else play next note
    # increase index
    lw $t0, melody2_index
    addi $t0, $t0, 1
    sw $t0, melody2_index
    
    # load note and duration base address
    la $t0, notes2
    la $t1, duration2
    
    # compute offset
    lw $t2, melody2_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, square
    lw $a3, square_volume
    syscall
    
    # set cd
    lw $t0, 0($t1)
    sw $t0, melody2_cd
    
return_play_melody2:
    jr $ra

play_melody3:
    lw $t0, melody3_cd
    bne $t0 $zero return_play_melody3 # do nothing if melody1_cd is not 0
    
    # else play next note
    # increase index
    lw $t0, melody3_index
    addi $t0, $t0, 1
    sw $t0, melody3_index
    
    # load note and duration base address
    la $t0, notes3
    la $t1, duration3
    
    # compute offset
    lw $t2, melody3_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, square
    lw $a3, square_volume
    syscall
    
    # set cd
    lw $t0, 0($t1)
    sw $t0, melody3_cd
    
return_play_melody3:
    jr $ra

play_melody4:
    lw $t0, melody4_cd
    bne $t0 $zero return_play_melody4 # do nothing if melody1_cd is not 0
    
    # else play next note
    # increase index
    lw $t0, melody4_index
    addi $t0, $t0, 1
    sw $t0, melody4_index
    
    # load note and duration base address
    la $t0, notes4
    la $t1, duration4
    
    # compute offset
    lw $t2, melody4_index
    sll $t2, $t2, 2
    
    # compute current note and duration address
    add $t0, $t0, $t2
    add $t1, $t1, $t2
    
    # syscall 31
    li $v0, 31
    lw $a0, 0($t0)
    lw $a1, 0($t1)
    lw $a2, percussion
    lw $a3, percussion_volume
    syscall
    
    # set cd
    lw $t0, 0($t1)
    sw $t0, melody4_cd
    
return_play_melody4:
    jr $ra
    
	
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	
	
	# 4. Sleep

    #5. Go back to 1
    b game_loop
