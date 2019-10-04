#!/usr/bin/python
# -*- coding: utf-8 -*-

class AstTree:
    def __init__(self, node=None, line=None, leaf_left=None,
                 leaf_right=None, valor=None):
        """
        :type leaf_left: AstTree
        :type leaf_right: AstTree
        """
        self.node = node
        self.line = line
        self.leaf_left = leaf_left
        self.leaf_right = leaf_right
        self.valor = valor

    @classmethod
    def recorrer(cls, arbol):
        ab = {'linea': arbol.line,
              'nodo':arbol.node,
              'leaf_left':cls.recorrer(arbol.leaf_left) if isinstance(arbol.leaf_left, AstTree) else None,
              'leaf_right':cls.recorrer(arbol.leaf_right) if isinstance(arbol.leaf_right, AstTree) else None,
              'valor':arbol.valor}

        return ab
            


        

    
if __name__ == '__main__':
    import pprint as p
    arbol1 = AstTree(valor=1)
    arbol2 = AstTree(node='algo', leaf_left=arbol1, valor=2)
    arbol3 = AstTree(node='algo', leaf_left=arbol2, leaf_right=arbol1)
    p.pprint(AstTree.recorrer(arbol3))
            
