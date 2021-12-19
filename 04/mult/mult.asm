// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Hack symbolic assembly language addresses:
// Memory units RAM, via @12 -> A=12, RAM[12] selected
// Instruction Memory ROM, lines of symbolic assembly
// CPU for computation via C-instructions dest = comp ; jump

// Some built-in assistance include variables (@lowercase), labels (@UPPERCASE, UPPERCASE) for control flow

// First write pseudo-code, translate into Address & Compute instructions
// R0 add to itself R1 times - use a for loop
// 1) declare variables: result = R0, R1, counter
// 2) execute & end loop
// for (counter : R1(limit)) {
//      result(counter*R0) = result(0) + R0
//      counter = counter(0 -- 4) + 1
//      if R1 - counter(1) = 0
//      then END}
// iflimit=5; i=0|result=1*R0, i=1|result=2*R0, 2/3, 3/4, 4/5, 5 END
// 3) load result into R2 

//////////////////////// CODE ///////////////////////////

//-------------- INITIALIZE VARIABLES ----------------//
// declares variable result 
@result
M=0 
// selects R1, load value into D register; declares variable result as limit
@R1
D=M
@limit
M=D
// declare a counter variable
@counter
M=0

//--------------- EXECUTE LOOP COMPUTATION -------------//
// compute and increment result by R0
//+++++++++++++++++++++++++++++++++//
// example R0 / increment = 2 and R1 / limit = 5
// counter--+--result--+--compare
//      0 --+--    2 --+--(-5)
//      1 --+--    4 --+--(-4)
//      2 --+--    6 --+--(-3)
//      3 --+--    8 --+--(-2)
//      4 --+--   10 --+--(-1)
//      5 --+-- STOP
(LOOP)

    // compare counter against limit/R1 (counter - limit)
    @counter
    D=M
    @limit
    D=D-M
    @STOP
    D;JEQ // ends loop if R1 - counter = 0
    
    // increment result by R0
    @result
    D=M
    @R0
    D=D+M
    @result
    M=D // D = result + R0
    
    // increment counter by 1
    @counter
    M=M+1 
    @LOOP
    0;JMP

//------------- RETURN RESULT & END PROGRAM ---------//
(STOP)
    @result
    D=M
    @R2
    M=D
(END)
    @END
    0;JMP

// appendix //
// alernate way to add
//    @R0
//    D=M
//    @result
//    M=D+M // result=R0+result(R0) --> this line doesn't work / illegal?


