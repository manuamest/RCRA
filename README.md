Autores:

    Jose Manuel Amestoy Lopez     manuel.amestoy@udc.es
    
    Juan Villaverde Rodriguez     juan.villaverde.rodriguez@udc.es

Encoder usage:         python3 encode.py < shingoki1.txt > shingoki1.lp

Decoder usage:         clingo shingokiKB.lp shingoki1.lp | python decode.py > solution1.txt

ShingkokiKB usage:     clingo 0 shingokiKB.lp shingoki1.lp

Our program consists of three main files: encode.py, decode.py, and shingokiKB.lp.

encode.py is responsible for encoding a given matrix, converting it into a suitable format for further processing. decode.py reverses this process, taking the solution data and reconstructing a new matrix. These two files work together to handle the input and output of the program, ensuring the data is correctly formatted.

shingokiKB.lp is the core of the program, acting as a solver for the Shingoki puzzle using the Clingo logic programming system. It takes the encoded matrix provided by encode.py and processes it to find a solution to the puzzle. Once a solution is found, it can be passed to decode.py to return the solved matrix.
