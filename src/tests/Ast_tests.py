#!/usr/bin/python
# -*- coding: utf-8 -*-

import unittest
import sys
sys.path.append('.')

from cwombat.AstTree import AstTree

class AstTests(unittest.TestCase):

#    lleaf: nil, node: :const, rleaf: nil, val: 2
    def test_tree(self):
        arbol0 = AstTree(node='const', leaf_left=None,
                         leaf_right=None, valor=2)
        
        arbol1 = AstTree(node='ret', leaf_left=arbol0,
                         leaf_right=None, valor=None)
        
        self.assertEqual(AstTree.recorrer(arbol1), {'linea': None,
                                                    'nodo': 'ret',
                                                    'leaf_left': {
                                                        'linea': None,
                                                        'nodo': 'const',
                                                        'leaf_left': None,
                                                        'leaf_right': None,
                                                        'valor': 2},
                                                    'leaf_right': None,
                                                    'valor': None})


unittest.main()
