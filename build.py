class preprocess:

    def __init__(self,index):
        self.index = index
        self.type = 'preprocess'
    def __str__(self):
        i =self.index
        return f'preprocess p{i}(term0[{i}],term1[{i}],p[{i}],g[{i}]);'
    def get_variable(self):
        i = self.index
        return f'p[{i}],g[{i}]'

class process:

    def __init__(self,block_a,block_b,level,index):
        self.level = level
        self.index = index
        self.block_a = block_a
        self.block_b = block_b
        self.type = 'process'
    def __str__(self):
        if self.index==0 and self.level==0:
            return "process l0_pr0(p[0],g[0],1'b0,cin,l0_p0,l0_g0);"
        else:
            pass
    def get_variable(self):
        i = self.index
        l =self.level
        return f'l{l}_p{i},l{l}_g{i}'
        


class add:

    def __init__(self,index,block):
        self.index = index
        self.type=='add'