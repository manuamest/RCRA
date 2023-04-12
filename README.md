Autores:
    Jose Manuel Amestoy Lopez     manuel.amestoy@udc.es
    Juan Villaverde Rodriguez     juan.villaverde.rodriguez@udc.es

Encoder usage:         python3 encode.py < shingoki1.txt > shingoki1.lp

Decoder usage:         clingo shingokiKB.lp shingoki1.lp | python decode.py > solution1.txt

ShingkokiKB usage:     clingo 0 shingokiKB.lp shingoki1.lp