import math
from argparse import ArgumentParser
import io
from string import Template
import random
template_code = Template( open('templates/modules.v','r').read())
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
        i = self.index
        l =self.level
        if self.index==0 and self.level==0:
            return "process l0_pr0(p[0],g[0],1'b0,cin,l0_p0,l0_g0);"
        else:
            return f"process l{l}_pr{i}({self.block_a.get_variable()},{self.block_b.get_variable()},l{l}_p{i},l{l}_g{i});"
    
    def get_variable(self):
        i = self.index
        l =self.level
        return f'l{l}_p{i},l{l}_g{i}'
        
class add:

    def __init__(self,index,block):
        self.index = index
        self.block = block

    def __str__(self):
        i =self.index
        i_b = self.block.index
        l_b = self.block.level
        if i==0:
            return 'add a0(term0[0],term1[0],cin,sum[0]);'
        else:
            return f'add a{i}(term0[{i}],term1[{i}],l{l_b}_g{i_b},sum[{i}]);'

def get_prev(j,i):
    j = j & ~(1<<i)
    j = j | ((1<<i)-1)
    return j

args = ArgumentParser()
args.add_argument('-n',default=16)
args.add_argument('-t')
args = args.parse_args()
n = int(args.n)

n_levels = int(math.log(n,2)) 
layer = []
verilog = io.StringIO()

for i in range(n_levels):
    print('wire',end=" ",file=verilog)
    for j in range(n//2):
        print(end=f'l{i}_p{j},l{i}_g{j}',file=verilog)
        if j==(n//2-1):
            print(end=';',file=verilog)
        else:
            print(end=', ',file=verilog)
    print(file=verilog)
print(file=verilog)

for i in range(n-1):
    p = preprocess(i)
    layer.append(preprocess(i))
    # code+=f'{p}\n'
    print(str(p),file=verilog)
print(file=verilog)

for i in range(n_levels):
    next_layer =layer.copy()
    curr_index =0
    for j in range(n):
        if (j & 1<<i):
            block_a = layer[j-1]
            block_b = layer[get_prev(j,i)-1] #invalid when -1 but it doesnt matter
            p =process(block_a,block_b,i,curr_index)
            curr_index+=1
            next_layer[j-1] = p
            # code+=f'{p}\n'
            print(str(p),file=verilog)
    print(file=verilog)
    layer =next_layer

# code+='\n'

for i in range(n):
    # code+=f'{}\n'
    print(str(add(i,layer[i-1])),file=verilog)

verilog.seek(0)
data = {
    "n":n-1,
    "npp":n-2,
    "code":'\t'.join(verilog.readlines()),
    "cout":f'l{layer[-1].level}_g{layer[-1].index}'
}

modules = template_code.substitute(**data)
open('modules.v','w').write(modules)

##test cases
if args.t:
    t = int(args.t)
    test_cases = io.StringIO()
    tb_add = Template(open('templates/tb_add.v').read())

    def get_hex(n,n_bits):
        width = n_bits//4
        h = hex(n)[2:]
        h = "0"*(width-len(h))+h
        h = f"{n_bits}'h{h}"
        return h

    for i in range(t):
        n1 = round(random.randrange(0,1<<(n) ),-3)
        n2 = round(random.randrange(0,1<<(n-1)),-3 ) # reduce
        term0 = get_hex(n1,n )
        term1 = get_hex(n2,n)
        cin = random.randint(0,1)

        print(end=f'term0 = {term0};\nterm1 = {term1};\ncin={cin};\n#10;\n',file=test_cases)

    test_cases.seek(0)
    data = {
        "n":n-1,
        "test":'\t'.join(test_cases.readlines()),
    }
    open('tb_add.v','w').write(tb_add.substitute(**data) )