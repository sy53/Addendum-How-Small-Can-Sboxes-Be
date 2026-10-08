from sat import sat
from espresso import genConstr
from basic_sbox import truth_table,uni,lin
from print import parse_solution,verify_sbox

def array(model, n, gates_num, X, D, a0, a1, b, q, t):
    [X0,X1] = X
    nand_gate = [ [0, 0, 0, 1], [0, 0, 1, 1], [0, 1, 0, 1], [0, 1, 1, 0] ]
    nor_gate = [ [1, 0, 0, 1], [1, 0, 1, 0], [1, 1, 0, 0], [1, 1, 1, 0] ]
    gate = nand_gate + nor_gate
    Constr_Gate = genConstr(gate)

    for i in range(gates_num):
        # e = 1 for a0 = a1; e = 0 otherwise
        e = model.addVar()
        model.DOT_PRODUCT( a0[i], a1[i], e)

        # constr for D
        q1_D = [ model.addVar() for _ in range( 3 ) ]
        for j in range(3):
            var_D = [X0]*n + [ row[j] for row in D[:i] ]
            model.DOT_PRODUCT( var_D, a1[i], q1_D[j])
        model.CAL_D( q1_D, e, D[i] )

        for index in range(1<<n):
            # constr for a and q
            # var for internal variables can be used now
            var = []
            ipad = bin(index)[2:].zfill(n)
            ii = [eval(ipad[x]) for x in range(n)]
            for j in range(n):
                if (ii[j] == 0):
                    var.append(X0)
                else:
                    var.append(X1) 
            var = var + t[index][:i]
            model.DOT_PRODUCT( var, a0[i], q[index][2*i] )
            model.DOT_PRODUCT( var, a1[i], q[index][2*i+1] )

            # constr for b, q and t
            model.exclude_set([b[i], q[index][2*i], q[index][2*i+1], t[index][i]], Constr_Gate)

    return 1

def sbox_with_bp(model, n, g, d):
    # auxiliary variable
    X0 = model.addVar()
    X1 = model.addVar()
    model.ASSIGN(X0,0)
    model.ASSIGN(X1,1)

    D = [ [ model.addVar() for i in range( 3 ) ] for j in range(g) ]
    # value_constr for D
    for i in range(g-1):
        model.LE_D( D[i], D[i+1] )

    # a chooses which wire for gate inputs
    a0 = [ [ model.addVar() for i in range( n+j ) ] for j in range(g) ]
    a1 = [ [ model.addVar() for i in range( n+j ) ] for j in range(g) ]
    # value_constr for a
    for i in range(g):
        model.ONE1( a0[i] )
        model.ONE1( a1[i] )
        model.GE_A( a0[i], a1[i] )
    # b chooses gates, 0 for NAND, 1 for NOR
    b = [ model.addVar() for _ in range( g ) ]

    # q equals the gate inputs value
    q = [ [ model.addVar() for i in range( 2*g ) ] for j in range(1<<n) ]
    # t equals the gate outputs value
    t = [ [ model.addVar() for i in range( g ) ] for j in range(1<<n) ]

    # all output of a n-bit function
    Y = [ [ model.addVar() for i in range(1<<n) ] for j in range( n ) ]
    ay = [ [ model.addVar() for i in range( n+g ) ] for j in range( n ) ]
    dy = [ [ model.addVar() for i in range( 3 ) ] for j in range( n ) ]
    for i in range(n):
        model.ONE1( ay[i] )
        for j in range(3):
            var_D = [X0]*n + [ row[j] for row in D ]
            model.DOT_PRODUCT( var_D, ay[i], dy[i][j])

        for index in range(1<<n):
            # var for internal variables can be used now
            var = []
            ipad = bin(index)[2:].zfill(n)
            ii = [eval(ipad[x]) for x in range(n)]
            for j in range(n):
                if (ii[j] == 0):
                    var.append(X0)
                else:
                    var.append(X1) 
            var = var + t[index]
            model.DOT_PRODUCT( var, ay[i], Y[i][index] )

        for j in range(8):
            if (j > d):
                jpad = bin(j)[2:].zfill(3)
                jj = [eval(jpad[x]) for x in range(3)]
                model.exclude_vector(dy[i],jj)
    
    # no gates fan-out number is 0
    for i in range(n+g):
        L = []
        for j in range(g):
            if (i < len(a0[j])):
                L.append(a0[j][i])
                L.append(a1[j][i])
        for j in range(n):
            L.append(ay[j][i])
        model.ORn( L+[X1], len(L) )

    array(model,n,g,[X0,X1],D,a0,a1,b,q,t)

    return (Y, D, a0, a1, b, ay, dy)

def sbox_value_with_bp(n, g, d, s):
    print(g,s)
    model = sat()

    (Y, D, a0, a1, b, ay, dy) = sbox_with_bp(model,n,g,d)
    tb = truth_table(n,n,s)
    for i in range(n):
        for j in range(1<<n):
            model.ASSIGN( Y[i][j], tb[i][j] )

    flag, resdict = model.solve( time = 5*24*3600, seed = 31, solver = 'kissat', delete = True )

    print( flag )

    if (flag == 1):
        res_s = parse_solution(n, g, d, D, a0, a1, b, ay, dy, resdict, s)
        if (verify_sbox(n, res_s, s)):
            print("verify success!\n")

    return flag

if __name__ == '__main__':

    # find a circuit with bit permutation for a sbox and verify it
    lblock_s0 = [14, 9, 15, 0, 13, 4, 10, 11, 1, 2, 8, 3, 7, 6, 12, 5]
    piccolo = [0xe,0x4,0xb,0x2,0x3,0x8,0x0,0x9,0x1,0xa,0x7,0xf,0x6,0xc,0x5,0xd]
    skinny_64 = [0xc,0x6,0x9,0x0,0x1,0xa,0x2,0xb,0x3,0x8,0x5,0xd,0x4,0xe,0x7,0xf]
    rectangle = [0x6,0x5,0xC,0xA,0x1,0xE,0x7,0x9,0xB,0x0,0x3,0xD,0x8,0xF,0x4,0x2]
    twine = [12,0,15,10,2,11,9,5,8,3,13,7,1,14,6,4]
    present = [12,5,6,11,9,0,10,13,3,14,15,8,4,7,1,2]
    
    
    mantis = [0xc,0xa,0xd,0x3,0xe,0xb,0xf,0x7,0x8,0x9,0x1,0x5,0x0,0x2,0x4,0x6]
    prince = [0xb,0xf,0x3,0x2,0xa,0xc,0x9,0x1,0x6,0x7,0x8,0x0,0xe,0x5,0xd,0x4]
    qarma = [[0,14,2,10,9,15,8,11,6,4,3,7,13,12,1,5],
            [10,13,14,6,15,7,3,5,9,8,0,12,11,1,2,4],
            [11,6,8,15,12,0,9,14,3,7,4,5,13,2,1,10]]
    midori = [[0xc,0xa,0xd,0x3,0xe,0xb,0xf,0x7,0x8,0x9,0x1,0x5,0x0,0x2,0x4,0x6],
            [0x1,0x0,0x5,0x3,0xe,0x2,0xf,0x7,0xd,0xa,0x9,0xb,0xc,0x8,0x4,0x6]]
    

    keccak = [0x0,0x9,0x12,0xb,0x5,0xc,0x16,0xf,0xa,0x3,0x18,0x1,0xd,0x4,0x1e,0x7,0x14,
              0x15,0x6,0x17,0x11,0x10,0x2,0x13,0x1a,0x1b,0x8,0x19,0x1d,0x1c,0xe,0x1f]
    ascon = [0x4,0xb,0x1f,0x14,0x1a,0x15,0x9,0x2,0x1b,0x5,0x8,0x12,0x1d,0x3,0x6,0x1c,
             0x1e,0x13,0x7,0xe,0x0,0xd,0x11,0x18,0x10,0xc,0x1,0x19,0x16,0xa,0xf,0x17]

    # sbox_value_with_bp(4, 27, 4, lblock_s0)   28√ 27×
    # sbox_value_with_bp(4, 25, 4, piccolo)     26√ 25×
    # sbox_value_with_bp(4, 27, 4, skinny_64)   28√ 27×
    # sbox_value_with_bp(4, 52, 4, rectangle)   53√ 52×
    # sbox_value_with_bp(4, 48, 4, present)     49√
    # sbox_value_with_bp(4, 38, 4, twine)       41√

    # sbox_value_with_bp(5, 28, 3, keccak)      28√ 27×
    # sbox_value_with_bp(5, 100, 5, ascon)

    # sbox_value_with_bp(4, 21, 3, mantis)      22√ 21×
    # sbox_value_with_bp(4, 22, 4, prince)      23√ 22×
    # sbox_value_with_bp(4, 20, 4, qarma[0])
    # sbox_value_with_bp(4, 30, 4, qarma[1])
    # sbox_value_with_bp(4, 30, 4, qarma[2])
    # sbox_value_with_bp(4, 22, 3, midori[0])
    # sbox_value_with_bp(4, 20, 4, midori[1])

    print("finish!\n")


