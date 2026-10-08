from print_tree import draw_circuit_graph

def nand(x,y):
    if (x == 1) and (y == 1):
        return 0
    else:
        return 1
    
def nor(x,y):
    if (x == 0) and (y == 0):
        return 1
    else:
        return 0

def no(x):
    return 1-x

def compute_value(n,st):
    '''
    compute a truth table of a boolean function in form string
    '''
    res = []
    for x0 in range(2):
        xx0 = 1-x0
        for x1 in range(2):
            xx1 = 1-x1
            for x2 in range(2):
                xx2 = 1-x2
                if (n == 3):
                    res.append(eval(st))
                    continue
                for x3 in range(2):
                    xx3 = 1-x3
                    if (n == 4):
                        res.append(eval(st))
                        continue
                    for x4 in range(2):
                        xx4 = 1-x4
                        if (n == 5):
                            res.append(eval(st))
                            continue
                        for x5 in range(2):
                            xx5 = 1-x5
                            if (n == 6):
                                res.append(eval(st))
                                continue
                            for x6 in range(2):
                                xx6 = 1-x6
                                if (n == 7):
                                    res.append(eval(st))
                                    continue
                                for x7 in range(2):
                                    xx7 = 1-x7
                                    if (n == 8):
                                        res.append(eval(st))
                                        continue
                                    for x8 in range(2):
                                        xx8 = 1-x8
                                        if (n == 9):
                                            res.append(eval(st))
                                            continue
                                        for x9 in range(2):
                                            xx9 = 1-x9
                                            if (n == 10):
                                                res.append(eval(st))
                                                continue
    return res

def deal(st):
    temp = st.replace("NOR","nor").replace("NAND","nand").replace("NOT","no")
    temp = temp.replace("~","x")
    return temp

def print_tree_function(n, d, A, I, G, resdict, table = []):
    '''
    for a solution, print its circuit
    '''
    leaves = 1<<d
    V = []*( 2*leaves - 1 )

    for i in range(leaves-1):
        if ( resdict[G[i]] == 0 ):
            V.append('NAND')
        else:
            V.append('NOR')

    for leaf in range(leaves):
        temp = []
        for i in range(n):
            temp.append(resdict[A[leaf][i]])
        s = 'x' + str(temp.index(1))
        if (resdict[I[leaf]] == 1):
            s = '~' + s
        V.append(s)


    for i in range(leaves-2,-1,-1):
        V[i] = V[i] + '(' + V[2*i+1] + ',' + V[2*i+2] + ')'
    print(V[0])

    return V[0]

def verify_function(n, tree, table = []):
    '''
    verify its truth table whether equals table
    '''
    st = deal(tree)
    tt = compute_value(n,st)

    if (len(table)):
        for i in range(len(table)):
            if (tt[i] != table[i]):
                return -1
    else:
        print(tt,"\n")
    return tt



def operate( L ):
    var = ''
    if ( L[0] == 'NOT' ):
        var = 'NOT(%s)' % L[1]
    else:
        var = '%s(%s, %s)' % ( L[0],L[1],L[2] )
    return var

def compute_cordinates(BIT, G, resdict, GATE):
    d_count = { 0: [BIT,0] }
    X = { 'x%d' % i: 10*i/(BIT-1) for i in range( BIT ) }
    Y = { 'x%d' % i: 0 for i in range( BIT ) }
    for d in resdict['D'].values():
        if d in d_count.keys():
            d_count[d][0] += 1
        else:
            d_count[d] = [1,0]

    for g in range( G ):
        Y[GATE[BIT + g]] = resdict['D'][str(g)]
        temp = d_count[resdict['D'][str(g)]]
        if (temp[0]%2 == 0):
            # X[GATE[BIT + g]] = 5
            X[GATE[BIT + g]] = 6 + 2.5*(temp[1]-(temp[0]//2))
        else:
            # X[GATE[BIT + g]] = 10*temp[1]/(temp[0]-1)
            X[GATE[BIT + g]] = 5 + 2.5*(temp[1]-(temp[0]//2))
        d_count[resdict['D'][str(g)]][1] += 1
    return X,Y

def parse_solution(n, g, d, D, a0, a1, b, ay, dy, resdict, sbox = []):
    res = { 'GATE' : {}, 'A0' : {}, 'A1' : {}, 'YA' : {}, 'D' : {} }

    for i in range(g):
        res['GATE'][str(i)] = '0b' + str(resdict[b[i]])

        res['A0'][str(i)] = '0b'
        res['A1'][str(i)] = '0b'
        for j in range(n+i):
            res['A0'][str(i)] += str(resdict[a0[i][j]])
            res['A1'][str(i)] += str(resdict[a1[i][j]])

        tempd = []
        for j in range(3):
            tempd.append(resdict[D[i][j]])
            res['D'][str(i)] = int(''.join(map(str, tempd)), 2)


    for i in range(n):
        res['YA'][str(i)] = '0b'
        for j in range(n+g):
            res['YA'][str(i)] += str(resdict[ay[i][j]])
    print( res )
    return parse_resdict_2_graph( n, g, res, sbox )

def parse_resdict_2_graph( BIT, G, resdict, sbox = [] ):
    VAR = [ 'x%d' % i for i in range( BIT ) ]
    EDGE = []
    GATE = { i: 'x%d' % i for i in range( BIT ) }
    GATE.update( { i + G + BIT: 'y%d' % i for i in range( BIT ) } )

    for g in range( G ):
        L = []
        gate = resdict['GATE'][str(g)][2:]

        a0 = resdict['A0'][str(g)]
        if ( a0[0:2] == '0x' ):
            a0 = bin( int( a0, 16 ) )[2:].zfill( BIT + g )
        else:
            a0 = a0[2:]

        a1 = resdict['A1'][str(g)]
        if ( a1[0:2] == '0x' ):
            a1 = bin( int( a1, 16 ) )[2:].zfill( BIT + g )
        else:
            a1 = a1[2:]

        if ( a0 == a1 ):
            L.append( 'NOT' )
            resdict['D'][str(g)] += 0.5
        elif ( gate == '0' ):
            L.append( 'NAND' )
        else:
            L.append( 'NOR' )

        for i in range( BIT + g ):
            if ( a0[i] == '1' ):
                L.append( VAR[i] )
                EDGE.append( (i,BIT + g) )
            if ( a1[i] == '1' ):
                L.append( VAR[i] )
                EDGE.append( (i,BIT + g) )
                
        VAR.append( operate(L) )

        if ( L[0] == 'NOT' ):
            del EDGE[-1]
            GATE[BIT + g] = 'NOT_%d' % g
        elif ( L[0] == 'NAND' ):
            GATE[BIT + g] = 'NAND_%d' % g
        else:
            GATE[BIT + g] = 'NOR_%d' % g
    
    cordinate_X, cordinate_Y = compute_cordinates( BIT, G, resdict, GATE )
    # print(cordinate_X, cordinate_Y)

    Y = []
    for n in range( BIT ):
        ya = resdict['YA'][str(n)]
        if ( ya[0:2] == '0x' ):
            ya = bin( int( ya, 16 ) )[2:].zfill( BIT + G )
        else:
            ya = ya[2:]

        for i in range( BIT + G ):
            if ( ya[i] == '1' ):
                Y.append( VAR[i] )
                cordinate_X['y%d' % n] = cordinate_X[GATE[i]]
                cordinate_Y['y%d' % n] = cordinate_Y[GATE[i]]

    print(Y)
    # print(cordinate_X, cordinate_Y)
    draw_circuit_graph( VAR, EDGE, GATE, cordinate_X, cordinate_Y )

    return Y

def verify_sbox(n, circuit, sbox = []):
    '''
    verify its s-box constructed by truth table whether equals sbox
    '''

    tt = []
    for i in range(n):
        st = deal(circuit[i])
        tt.append(compute_value(n,st))

    ss = []
    for i in range(1<<n):
        temp = []
        for j in range(n):
            temp.append(tt[j][i])
        ss.append( int("".join(map(str, temp)), 2) )

    if (len(sbox)):
        for i in range(len(sbox)):
            if (ss[i] != sbox[i]):
                return 0
    else:
        print(ss,"\n")
    return ss
