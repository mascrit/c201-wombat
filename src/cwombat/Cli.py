#!/usr/bin/python
# -*- coding: utf-8 -*-

from os.path import abspath, isfile
from argparse import ArgumentParser
#from cwombat import 

class Cli:

    __output = 'Se define el archivo de entrada'
    __input = 'Se define earchivo de entrada'
    __parser = 'Imprime lo que hace el parcer'
    __lexer = 'Imprime lo que hace el Lexer'
    __ensamblador = "Imprime lo que hace el Generador de Código ASM"

    def __init__(self):
        self.parser = ArgumentParser()

        self.parser.add_argument('-o', '--output', nargs='?', default=None,
                                 type=str, help=self.__output)
        self.parser.add_argument('-i', '--input_file', nargs='?', default=None,
                                 type=str, help=self.__input)
        self.parser.add_argument('-p', '--parser', default=False, action='store_true',
                                 help=self.__parser)
        self.parser.add_argument('-l', '--lexer', default=False, action='store_true',
                                 help=self.__lexer)
        self.parser.add_argument('-s', '--assembly', default=False, action='store_true',
                                 help=self.__ensamblador)
        self.args = self.parser.parse_args()

    def evaluar_args(self):
        val_ret, msg_out = 0, '\033[92mCompilando\033[0m: '
        params = self.args
        print(not params.input_file is None)
        if not params.input_file is None:

            out_file = params.output
            input_file = abspath(params.input_file)
            if isfile(input_file):

                msg_out += '\033[94m' + input_file+'\033[94m\n'
                if out_file is None:

                    out_file = abspath('.')
                else:
                    out_file = abspath(params.output)

            else:
                msg_out = '\033[31mError\033[0m: No existe el archivo '+\
                    '\033[94m' + input_file + '\033[94m'
                val_ret = 1
        else:
            msg_out = '\033[31mError\033[0m: No se ha cargado ningun archivo'
            val_ret = 1
        return msg_out, val_ret

    def compile(self, input_file, output_file):
        pass
