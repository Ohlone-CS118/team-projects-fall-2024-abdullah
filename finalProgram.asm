.data
# set display to:
#	-Pixels width and height to 16x16
#	-Display width and height to 516x516
#	Base address = 0x10010000
# This will make our screen width 64x64 (256/4 = 64)
#	64 * 64 * 4 = 16384 required bytes
display:	.space 16384

define:
# screen information
	.eqv PIXEL_SIZE 4
	.eqv WIDTH 32
	.eqv HEIGHT 32
	.eqv DISPLAY 0x10010000

introPath: 			.asciiz "C:\\Users\\kogam\\OneDrive\\Desktop\\Intro.txt"
outroPath: 			.asciiz "C:\\Users\\kogam\\OneDrive\\Desktop\\Outro.txt"
introBuffer:	  		.space 200
yourAnswer:			.asciiz	"Your Anser: "
safeOutput:			.asciiz	"Your current cooking system is safe for the future."
unsafeOutput:		.asciiz	"Your current cooking system is soon to be outdated(CONSIDER UPDATING TO A MORE MODERN COOKING SYSTEM)."
actionNeededOutput:	.asciiz	"YOUR CURRENT COOKING SYSTEM IS CURRENTLY OUTDATED! UPDATE IMEDIATELY!!!"

Question1:	.asciiz	"\nDoes your cooking system use a non-renewable source of fuel?\n"
Answer1:	.asciiz	": Consider switching to a more sustainable fuel source such as solar, wind, or hydro."
Question2:	.asciiz	"\nDoes your cooking system use polluting renewable sources of fuels (trash, rubber, paper, crop waste, dung)?\n"
Answer2:	.asciiz	": Consider using a less poluting source of renewable fuel such as solar, wind, or hydro."
Question3:	.asciiz	"\nIs your cooking system made of Clay or Metal?\n"
Answer3:	.asciiz	": Consider swaping to a less toxic material such as steel or ceramic."
Question4:	.asciiz	"\nIs there a way to know if the cooking system heats up more than it's supposed to?\n"
Answer4:	.asciiz	": Consider adding a temperature gauge to prevent fires from starting."
Question5:	.asciiz 	"\nIs there a ventilation system in place close to your cooking system?\n"
Answer5:	.asciiz	": Consider adding a ventilation system to decrease the chance of mold growth."
Question6:	.asciiz	"\nIs there an automatic shut-off for the system as a safety feature if left unchecked for a while?\n"
Answer6:	.asciiz	": Consider adding an automatic shut-off to prevent overheating."
Question7:	.asciiz 	"\nIs there a fire alarm sensor nearby the cooking system that would sound before the fire spreads out too much?\n"
Answer7:	.asciiz	": Consider adding  a fire alarm near your cooking system to catch fires eary on."
Question8:	.asciiz 	"\nIs there a fire extinguisher next to the cooking system just in case if needed to put out the fire?\n"
Answer8:	.asciiz	": Consider adding a fire extinguisher near your cooking system to stop fires from spreading."
Question9:	.asciiz 	"\nIs your cooking system located next to a water source?\n"
Answer9:	.asciiz	": Consider having a water source near your cooking system to help put out fires and minimize time away from your cooking system."
Question10:	.asciiz 	"\nDo you use cookware that is coated with Teflon or other chemical non-stick coatings such as PTFE or PFOA?\n"
Answer10:	.asciiz	": Consider using stainless steal cookware to limit your exposure to harmful toxins."
Question11:	.asciiz 	"\nIs your cookware composed of glazes and coatings that leach heavy metals?\n"
Answer11:	.asciiz	": Consider using glaze and coating free cookware to limit your exposure to harmful toxins."
Question12:	.asciiz 	"\nAre any of your cookware damaged?\n"
Answer12:	.asciiz	": Consider getting new cookware to decrease your exposure to toxins."
Question13:	.asciiz 	"\nAre your cooking utensils(spatula, spoon, knife, forks, ladle, etc) made of plastic?\n"
Answer13:	.asciiz	": Consider getting stainless steel cooking utensils."

.text

main:

drawGraph: # make the background white
	li $a0, 0xFFFFFFFF
	jal backgroundColor

yAxis: # draws the y-axis
	li $a0, 2
	li $a1, 2
	li $a2, 0x00000000
	li $t0, 29
	
yAxisLoop:
	jal draw_pixel
	addiu $a1, $a1, 1
	beq $a1, $t0, yAxisLoopDone
	j yAxisLoop
	
yAxisLoopDone:

yAxisIndent: # draws the y-axis indents
	li $a0, 1
	li $a1, 2
	li $a2, 0x00000000
	li $t0, 30
	
yAxisIndentLoop:
	jal draw_pixel
	addiu $a1, $a1, 2
	beq $a1, $t0, yAxisIndentLoopDone
	j yAxisIndentLoop
	
yAxisIndentLoopDone:

xAxis: # draws the x-axis
	li $a0, 2
	li $a1, 29
	li $a2, 0x00000000
	li $t0, 29
	
xAxisLoop:
	jal draw_pixel
	addiu $a0, $a0, 1
	beq $a0, $t0, xAxisLoopDone
	j xAxisLoop
	
xAxisLoopDone:

xAxisIndent: # draws the x-axis indents
	li $a0, 4
	li $a1, 30
	li $a2, 0x00000000
	li $t0, 30
	
xAxisIndentLoop:
	jal draw_pixel
	addiu $a0, $a0, 2
	beq $a0, $t0, xAxisIndentLoopDone
	j xAxisIndentLoop
	
xAxisIndentLoopDone:

	li $t0, 0 # quiz counter
	li $t1, 89 # $t1 = 'Y'
	li $t2, 78 # $t2 = 'N'
	la $a0, introPath # set the path
	la $a1, introBuffer # set the buffer
	jal readFile # call readFile
	
	li $v0, 4 # read in intro from file
	la $a0, introBuffer
	syscall

Q1:
	la $a0, Question1 # print Question1
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question1
	syscall
	
	beq $v0, $t1, Question1Increment # counter++ if 'Y' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
			
	j Q2
	
Question1Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer1
	la $a0, Answer1
	syscall
	
Q1IncrementedBar:
	li $a0, 3 
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 23
	
Q1IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q1IncrementedBarLoop1done
	j Q1IncrementedBarLoop1

Q1IncrementedBarLoop1done:

	li $a0, 4
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 23

Q1IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q1IncrementedBarLoop2done
	j Q1IncrementedBarLoop2

Q1IncrementedBarLoop2done:
	
Q2:
	li $v0, 4 # print Question2
	la $a0, Question2 
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question2
	syscall
	
	beq $v0, $t1, Question2Increment # counter++ if 'Y'
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q3
	
Question2Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer2
	la $a0, Answer2
	syscall
	
Q2IncrementedBar:
	li $a0, 5
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 25
	
Q2IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q2IncrementedBarLoop1done
	j Q2IncrementedBarLoop1

Q2IncrementedBarLoop1done:

	li $a0, 6
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 25

Q2IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q2IncrementedBarLoop2done
	j Q2IncrementedBarLoop2

Q2IncrementedBarLoop2done:
		
Q3:
	li $v0, 4 # print Question3
	la $a0, Question3
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question3
	syscall
	
	beq $v0, $t2, Question3Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q4
	
Question3Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer3
	la $a0, Answer3
	syscall
	
Q3IncrementedBar:
	li $a0, 7 
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 24
	
Q3IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q3IncrementedBarLoop1done
	j Q3IncrementedBarLoop1

Q3IncrementedBarLoop1done:

	li $a0, 8
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 24

Q3IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q3IncrementedBarLoop2done
	j Q3IncrementedBarLoop2

Q3IncrementedBarLoop2done:
	
Q4:
	li $v0, 4 # print Question4
	la $a0, Question4 
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question4
	syscall
	
	beq $v0, $t2, Question4Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q5
	
Question4Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer4
	la $a0, Answer4
	syscall

Q4IncrementedBar:
	li $a0, 9
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 25
	
Q4IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q4IncrementedBarLoop1done
	j Q4IncrementedBarLoop1

Q4IncrementedBarLoop1done:

	li $a0, 10
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 25

Q4IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q4IncrementedBarLoop2done
	j Q4IncrementedBarLoop2

Q4IncrementedBarLoop2done:

Q5:
	li $v0, 4 # print Question5
	la $a0, Question5 
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question4
	syscall
	
	beq $v0, $t2, Question5Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q6
	
Question5Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer5
	la $a0, Answer5
	syscall
	
Q5IncrementedBar:
	li $a0, 11
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 26
	
Q5IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q5IncrementedBarLoop1done
	j Q5IncrementedBarLoop1

Q5IncrementedBarLoop1done:

	li $a0, 12
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 26

Q5IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q5IncrementedBarLoop2done
	j Q5IncrementedBarLoop2

Q5IncrementedBarLoop2done:
	
Q6:
	li $v0, 4 # print Question6
	la $a0, Question6 
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question4
	syscall
	
	beq $v0, $t2, Question6Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q7
	
Question6Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer6
	la $a0, Answer6
	syscall

Q6IncrementedBar:
	li $a0, 13
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 20
	
Q6IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q6IncrementedBarLoop1done
	j Q6IncrementedBarLoop1

Q6IncrementedBarLoop1done:

	li $a0, 14
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 20

Q6IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q6IncrementedBarLoop2done
	j Q6IncrementedBarLoop2

Q6IncrementedBarLoop2done:
	
Q7:
	li $v0, 4 # print Question7
	la $a0, Question7
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question4
	syscall
	
	beq $v0, $t2, Question7Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q8
	
Question7Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer7
	la $a0, Answer7
	syscall
	
Q7IncrementedBar:
	li $a0, 15
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 23
	
Q7IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q7IncrementedBarLoop1done
	j Q7IncrementedBarLoop1

Q7IncrementedBarLoop1done:

	li $a0, 16
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 23

Q7IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q7IncrementedBarLoop2done
	j Q7IncrementedBarLoop2

Q7IncrementedBarLoop2done:
	
Q8:
	li $v0, 4 # print Question8
	la $a0, Question8
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question4
	syscall
	
	beq $v0, $t2, Question8Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q9
	
Question8Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer8
	la $a0, Answer8
	syscall
	
Q8IncrementedBar:
	li $a0, 17
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 17
	
Q8IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q8IncrementedBarLoop1done
	j Q8IncrementedBarLoop1

Q8IncrementedBarLoop1done:

	li $a0, 18
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 17

Q8IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q8IncrementedBarLoop2done
	j Q8IncrementedBarLoop2

Q8IncrementedBarLoop2done:
	
Q9:
	li $v0, 4 # print Question8
	la $a0, Question9
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question4
	syscall
	
	beq $v0, $t2, Question9Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q10
	
Question9Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer9
	la $a0, Answer9
	syscall
	
Q9IncrementedBar:
	li $a0, 19
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 26
	
Q9IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q9IncrementedBarLoop1done
	j Q9IncrementedBarLoop1

Q9IncrementedBarLoop1done:

	li $a0, 20
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 26

Q9IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q9IncrementedBarLoop2done
	j Q9IncrementedBarLoop2

Q9IncrementedBarLoop2done:
	
Q10:
	li $v0, 4 # print Question10
	la $a0, Question10
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question10
	syscall
	
	beq $v0, $t1, Question10Increment # counter++ if 'Y' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q11
	
Question10Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer10
	la $a0, Answer10
	syscall
	
Q10IncrementedBar:
	li $a0, 21
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 19
	
Q10IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q10IncrementedBarLoop1done
	j Q10IncrementedBarLoop1

Q10IncrementedBarLoop1done:

	li $a0, 22
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 19

Q10IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q10IncrementedBarLoop2done
	j Q10IncrementedBarLoop2

Q10IncrementedBarLoop2done:
	
Q11:
	li $v0, 4 # print Question11
	la $a0, Question11
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question11
	syscall
	
	beq $v0, $t2, Question11Increment # counter++ if 'N' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q12
	
Question11Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer11
	la $a0, Answer11
	syscall
	
Q11IncrementedBar:
	li $a0, 23
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 23
	
Q11IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q11IncrementedBarLoop1done
	j Q11IncrementedBarLoop1

Q11IncrementedBarLoop1done:

	li $a0, 24
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 23

Q11IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q11IncrementedBarLoop2done
	j Q11IncrementedBarLoop2

Q11IncrementedBarLoop2done:
	
Q12:
	li $v0, 4 # print Question12
	la $a0, Question12
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question12
	syscall
	
	beq $v0, $t1, Question12Increment # counter++ if 'Y' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j Q13
	
Question12Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer12
	la $a0, Answer12
	syscall
	
Q12IncrementedBar:
	li $a0, 25
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 14
	
Q12IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q12IncrementedBarLoop1done
	j Q12IncrementedBarLoop1

Q12IncrementedBarLoop1done:

	li $a0, 26
	li $a1, 28
	li $a2, 0x000000FF
	li $t3, 14

Q12IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q12IncrementedBarLoop2done
	j Q12IncrementedBarLoop2
	
Q12IncrementedBarLoop2done:
	
Q13:
	li $v0, 4 # print Question13
	la $a0, Question13
	syscall
	la $a0, yourAnswer # print yourAnswer
	syscall
	
	li $v0, 12 # get the answer to Question13
	syscall
	
	beq $v0, $t1, Question13Increment # counter++ if 'Y' 
	
	li $a2 25 # load a guitar instrument
	li $a3 100 # set the volume
	
	li $a0 67 # play middle G
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 72 # play middle C
	li $a1 1000 # play for one second
	
	li $v0 33 # play sound
	syscall
	
	li $a0 65 # play E minor
	li $a1 500 # play for one half second
	
	li $v0 33 # play sound
	syscall
	
	j done
	
Question13Increment:
	addiu $t0, $t0, 1
	li $v0, 4 # print Answer13
	la $a0, Answer13
	syscall
	
Q13IncrementedBar:
	li $a0, 27
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 25
	
Q13IncrementedBarLoop1:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q13IncrementedBarLoop1done
	j Q13IncrementedBarLoop1

Q13IncrementedBarLoop1done:

	li $a0, 28
	li $a1, 28
	li $a2, 0x00FF0000
	li $t3, 25

Q13IncrementedBarLoop2:
	jal draw_pixel
	subiu $a1, $a1, 1
	beq $a1, $t3, Q13IncrementedBarLoop2done
	j Q13IncrementedBarLoop2
	
Q13IncrementedBarLoop2done:

done:
	li $t1, 3 # safe
	li $t2, 6 # caution
	
	bgt $t0, $t2, isActionNeeded # if (counter > 7) go to isActionNeeded
	ble $t0, $t1, isSafe # if (counter <= 3) go to isSafe
	ble $t0, $t2, isUnsafe # if (counter <= 7) go to isUnsafe
	
isSafe:
	la $a0, outroPath # print safeOutput in Outro.txt
	la $a1, safeOutput
	jal writeAFile 
	j outputDone
	
isUnsafe:
	la $a0, outroPath # print unsafeOutput in Outro.txt
	la $a1, unsafeOutput
	jal writeAFile 
	j outputDone
	
isActionNeeded:
	la $a0, outroPath # print actionNeededOutput in Outro.txt
	la $a1, actionNeededOutput
	jal writeAFile
	j outputDone

outputDone:
	li $v0, 10 # Exit Safely
	syscall 
	
# precondition: $a0 is set to the color
backgroundColor:
	li $s1, DISPLAY # The first pixel on the display 
	li $s2, WIDTH # set $s2 = the last memory address of the display
	mul $s2, $s2, HEIGHT
	mul $s2, $s2, 4 # word
	add $s2, $s1, $s2 

backgroundLoop:
	sw $a0, 0($s1)
	addiu $s1, $s1, 4
	ble $s1, $s2, backgroundLoop
	
	jr $ra

# preconditions
# 	$a0 = x
#	$a1 = y
#	$a2 = color
draw_pixel:
	# $s1 = address = DISPLAY + 4 * (x + (y * WIDTH))
	mul $s1, $a1, WIDTH  # $s1 = y * WIDTH
	add $s1, $s1, $a0 # $s1 = x + (y * WIDTH)
	mul $s1, $s1, 4 # $s1 = 4 * (x + (y * WIDTH))
	sw $a2, DISPLAY($s1) 
	jr $ra
	
	
# preconditions:
#	$a0 = file path
#	$a1 = buffer
# postcondition: The buffer address holds the file text.
readFile:
	move $s0, $a0 # stash the file path
	move $s1, $a1 # stash the buffer address
	
	li $v0, 13 # open the file
	move $a0, $s0 # set the file path
	li $a1, 0
	li $a3, 0
	syscall
	
	move $s3, $v0 # save the file handler
	
	li $v0, 14 # read the file
	move $a0, $s3 # set the file handler
	move $a1, $s1 # set the buffer
	li $a2, 199 # set teh max length
	syscall
	
	move $s4, $v0 # save the number of chars read
	
	add $s5, $s4, $s1
	sb $zero, 0($s5) # insert the terminating null char (\0)
	
	li $v0, 16 # close the file
	move $a0, $s3 # set the file handler
	syscall
	
	jr $ra # return
	
# precondition:
#	$a0 = file path
#	$a1 = buffer
# postcondition: String in the buffer written to the path
writeAFile:
	move $s0, $a0 # Stash the path
	move $s1, $a1 # Stash the buffer
	
	li $s3, 0 # set the counter to 0
	add $s4, $s3, $s1 # memory address of the next char in the string
	
	li $s3, 0 # set the counter to 0

counter_loop:
	add $s4, $s3, $s1 # memory address of the next char in the string
	lb $s5, 0($s4) # load the byte
	addi $s3, $s3, 1 # counter++
	bnez $s5, counter_loop
	
	subi $s3, $s3, 1 # back up one char(byte)
	
	li $v0, 13
	move $a0, $s0 
	li $a1, 1 # write
	li $a2, 0 # I don't know why
	syscall
	
	move $s2, $v0 # stash the file handler
	
	li $v0, 15 # write to file 
	move $a0, $s2 # set the file handler
	move $a1, $s1 # adress of the buffer
	move $a2, $s3 # number of chars(bytes) to write
	syscall
	
	li $v0, 16 # close the file
	syscall
	
	jr $ra
