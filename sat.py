import os, re, random

class sat: 
    def __init__( self ):
        self._V = 0 # the index of variables
        self._clause = [] # the sets of clause

    def reset( self ):
        '''
        the function that reset the model
        '''
        self._V = 0
        self._clause = []

    def addVar( self ):
        self._V += 1
        return self._V 

    def addClause( self, c ):
        '''
        declare a new variable
        '''
        self._clause.append( c )

    def exclude_vector( self, X, v ):
        '''
        let the value of X cannot be vector V
        '''
        assert len(X) == len(v), 'the lengths of X and v are not equal'
        s = ''
        for i in range( len(X) ):
            if v[i] == '1' or v[i] == 1:
                s += '-%d ' % ( X[i] ) 
            elif v[i] == '0' or v[i] == 0:
                s += '%d ' % ( X[i] ) 
            else:
                pass
        s += '0' 
        self.addClause( s )

    def exclude_set( self, X, V ):
        '''
        let the value of X cannot be vectors in V
        '''
        for v in V:
            self.exclude_vector( X, v )

    def OR1( self, X ):
        s = ' '.join( list( map( str, X ) ) )
        s += ' 0'
        #print( s )
        self.addClause( s )
        
    def XOR( self, X ):
        '''
        add constraints for a ^ b = c 
        '''
        assert len(X) == 3, 'Length of X is wrong' % X
        L = [ [0, 0, 1], [0, 1, 0], [1, 0, 0], [1, 1, 1] ]
        self.exclude_set( X, L )

    def AND( self, X ):
        '''
        add constraints for a & b = c 
        '''
        assert len(X) == 3, 'Length of X is wrong' % X
        L = [ [0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 0] ]
        self.exclude_set( X, L )

    def XORn( self, X, n ):
        '''
        add constraints for n variables xor
        '''
        assert len(X) == (n+1), 'Length of X is wrong' % X
        L = []
        for i in range(1<<n):
            ipad = bin(i)[2:].zfill(n)
            ii = [eval(ipad[x]) for x in range(n)]
            res = 0
            for j in range(n):
                res ^= ii[j]
            if (res == 1):
                L.append(ii+[0])
            else:
                L.append(ii+[1])
        self.exclude_set( X, L )

    def ORn( self, X, n ):
        '''
        add constraints for n variables or
        '''
        assert len(X) == (n+1), 'Length of X is wrong' % X
        self.exclude_vector( X, [0]*n + [1] )

    def ONE1( self, X ):
        '''
        add constraints for exactly one '1' in X
        '''
        for i in range(len(X)):
            for j in range(i+1,len(X)):
                self.exclude_vector( [X[i], X[j]], [1,1] )
        self.exclude_vector( X, [0]*len(X) )

    # def CAL_D( self, e, d0, d1, d):
    #     '''
    #     add constraints for d = max(d0,d1) + 1 if e = 0
    #     add constraints for d = d0 = d1 if e = 1
    #     d0,d1,d2 <= 7
    #     '''
    #     assert len(d0) == len(d1), 'Length of d0,d1 are wrong'
    #     assert len(d0) == len(d), 'Length of d is wrong'
    #     s = [['-', '-', '-', '1', '1', '1', '-', '-', '-', '0'],
    #          ['-', '1', '1', '-', '-', '-', '1', '-', '-', '0'], 
    #          ['-', '-', '1', '-', '-', '0', '-', '0', '-', '0'], 
    #          ['-', '0', '-', '-', '-', '0', '-', '1', '1', '1'], 
    #          ['-', '-', '0', '-', '0', '-', '-', '1', '1', '1'], 
    #          ['-', '-', '-', '-', '-', '1', '-', '0', '0', '-'], 
    #          ['0', '-', '0', '1', '0', '0', '-', '-', '0', '-'], 
    #          ['-', '0', '-', '0', '-', '0', '1', '-', '0', '-'], 
    #          ['0', '-', '1', '1', '-', '-', '-', '0', '-', '-'], 
    #          ['-', '0', '0', '-', '-', '1', '0', '-', '-', '0'], 
    #          ['0', '1', '-', '1', '-', '-', '-', '-', '0', '-'], 
    #          ['0', '-', '-', '-', '1', '-', '1', '-', '0', '-'], 
    #          ['0', '-', '-', '-', '-', '1', '1', '0', '-', '-'], 
    #          ['0', '-', '-', '-', '1', '1', '1', '-', '-', '-'], 
    #          ['0', '1', '1', '1', '-', '-', '-', '-', '-', '-'], 
    #          ['-', '0', '-', '0', '0', '-', '0', '1', '-', '-'], 
    #          ['-', '-', '1', '-', '-', '-', '-', '0', '0', '-'], 
    #          ['-', '0', '-', '-', '1', '-', '0', '-', '-', '0'], 
    #          ['-', '1', '-', '0', '0', '-', '-', '-', '-', '0'], 
    #          ['-', '-', '0', '-', '-', '0', '-', '-', '1', '1'], 
    #          ['1', '-', '-', '-', '-', '0', '-', '-', '1', '-'], 
    #          ['0', '-', '-', '0', '-', '-', '0', '-', '-', '0'], 
    #          ['-', '-', '-', '1', '0', '-', '-', '1', '-', '1'], 
    #          ['-', '0', '-', '-', '-', '-', '1', '1', '-', '1'], 
    #          ['1', '-', '-', '1', '-', '-', '0', '-', '-', '-'], 
    #          ['1', '-', '-', '0', '-', '-', '-', '-', '-', '1'], 
    #          ['1', '-', '-', '-', '-', '-', '1', '-', '-', '0'], 
    #          ['-', '0', '-', '-', '0', '-', '-', '1', '1', '-'], 
    #          ['1', '-', '0', '-', '-', '-', '-', '-', '1', '-'], 
    #          ['-', '1', '1', '-', '-', '-', '-', '-', '0', '-'], 
    #          ['-', '-', '-', '-', '1', '1', '-', '-', '0', '-'], 
    #          ['-', '1', '-', '-', '-', '-', '-', '0', '-', '-'],
    #          ['-', '-', '-', '-', '1', '-', '-', '0', '-', '-']]
    #     self.exclude_set([e]+d0+d1+d, s)


    def CAL_D( self, d1, e, d):
        '''
        add constraints for d = d1 + 1 if e = 0
        add constraints for d = d1 if e = 1
        d,d1 <= 7
        '''
        assert len(d1) == len(d), 'Length of d is wrong'
        s = [['-', '1', '-', '0', '-', '1', '0'], 
             ['-', '-', '-', '0', '0', '0', '0'], 
             ['1', '-', '-', '0', '-', '-', '0'], 
             ['-', '1', '0', '-', '-', '0', '-'], 
             ['-', '0', '0', '-', '-', '1', '-'], 
             ['-', '-', '1', '1', '-', '-', '0'], 
             ['-', '-', '1', '0', '-', '-', '1'], 
             ['0', '0', '-', '-', '1', '-', '-'], 
             ['-', '1', '-', '-', '-', '0', '1'], 
             ['-', '0', '-', '-', '-', '1', '1'], 
             ['-', '-', '-', '-', '1', '1', '-'], 
             ['-', '-', '0', '1', '-', '-', '1'], 
             ['1', '-', '-', '-', '0', '-', '-']]
        self.exclude_set(d1+[e]+d, s)

    def LE_D( self, X , Y):
        '''
        add constraints for X <= Y, 3-bit
        X,Y <= 7
        '''
        assert len(X) == len(Y), 'Length of X, Y are wrong'
        assert len(X) == 3, 'Length of X is wrong'
        s = [['-', '1', '1', '-', '1', '0'], 
             ['-', '-', '1', '0', '0', '0'], 
             ['-', '-', '-', '1', '1', '-'], 
             ['-', '1', '-', '0', '0', '-'], 
             ['1', '-', '-', '0', '-', '-'], 
             ['1', '-', '1', '-', '-', '0'], 
             ['1', '1', '-', '-', '-', '-']]
        self.exclude_set(X + Y, s)


    def DOT_PRODUCT( self, X, A, v ):
        '''
        there is exactly one '1' in A
        add constraints for X*A = v
        '''
        assert len(X) == len(A), 'Length of X is wrong' % X
        for i in range(len(X)):
            self.exclude_set( [X[i], A[i], v], [[0, 1, 1], [1, 1, 0]])

    def IF_EQ( self, out, xorout, v ):
        '''
        v = 1  if and only if  out = xorout
        '''
        assert len(out) == len(xorout), 'Length of Y is wrong' % X
        constr = []
        for i in range(1<<len(xorout)):
            ipad = bin(i)[2:].zfill(len(xorout))
            ii = [eval(ipad[x]) for x in range(len(xorout))]
            if (ii != xorout):
                constr.append(ii+[1])
            else:
                constr.append(ii+[0])
        self.exclude_set( out + [v], constr)
        # for i in range(len(xorout)):
        #     if (xorout[i] == 1):
        #         self.exclude_vector( [out[i], v], [0,1] )
        #     else:
        #         self.exclude_vector( [out[i], v], [1,1] )
        # self.exclude_vector( out + [v], xorout+[0] )

    def EQ( self, X ):
        assert len(X) == 2, 'Length of X is wrong'
        L = [ [0, 1], [1, 0] ]
        self.exclude_set( X, L )

    def GT( self, X , Y):
        '''
        add constraints for X > Y
        '''
        assert len(X) == len(Y), 'Length of X, Y are wrong'
        n = len(X)
        temp = [ self.addVar() for _ in range(n) ]
        for i in range(n):
            self.XOR( [X[i], Y[i], temp[i]] )
            self.exclude_vector( X[:i+1]+Y[:i+1], [0]*(2*i+1)+[1] )
        self.exclude_vector( temp, [0]*n )

    def GE_A( self, X , Y):
        '''
        add constraints for X >= Y
        '''
        assert len(X) == len(Y), 'Length of X, Y are wrong'
        n = len(X)
        for i in range(n):
            self.exclude_vector( X[:i+1]+Y[:i+1], [0]*(2*i+1)+[1] )

    def ASSIGN( self, X, v ):
        if v == 0 or v == '0':
            s = '-%d 0' % X
            self.addClause( s )
        elif v == 1 or v == '1':
            s = '%d 0' % X
            self.addClause( s )

    def XOR3 ( self, X ):
        assert len(X) == 4, 'Length of X is wrong' % X
        L = [ [0, 0, 0, 1], [0, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 0], [0, 1, 1, 1], [1, 0, 1, 1], [1, 1, 0, 1], [1, 1, 1, 0] ]
        self.exclude_set( X, L )

    def SEQSUM( self, X, k ):
        if k > 0:
            n = len( X )
            S = [ [ self.addVar() for i in range( k ) ] for j in range( n - 1 ) ]
            s = '-%d %d 0' % ( X[0], S[0][0] )
            self.addClause( s )

            for j in range(1, k):
                s = '-%d 0' % ( S[0][j] )
                self.addClause( s )

            for i in range( 1, n - 1 ):
                s = '-%d %d 0' % ( X[i], S[i][0] )
                self.addClause( s )
                s = '-%d %d 0' % ( S[i - 1][0], S[i][0] )
                self.addClause( s )

                for j in range(1, k):
                    s = '-%d -%d %d 0' % ( X[i], S[i - 1][j - 1], S[i][j] )
                    self.addClause( s )
                    s = '-%d %d 0' % ( S[i - 1][j], S[i][j] )
                    self.addClause( s )

                s = '-%d -%d 0' % ( X[i], S[i- 1][k - 1] )
                self.addClause( s )
            s = '-%d -%d 0' % ( X[n - 1], S[n - 2][k - 1] )
            self.addClause( s )
        else: # the sum is zero
            for x in X:
                s =  '-%d 0' % x
                self.addClause( s )

    def write_to_file( self, filename ):
        with open( filename, 'w' ) as f:
            f.write( 'p cnf %d %d \n' % ( self._V, len( self._clause ) ) ) 
            for clause in self._clause:
                f.write( '%s \n' % clause ) 

    def run_file( self, cnf, seed, time, solver = 'cadical' ):
        res_dict = {}
        seed = 0
        os.system( '%s -q --seed=%d --time=%d %s > %s.res' % ( solver, seed, time, cnf, cnf ) )
        # os.system( '%s -model %s > %s.res' % ( 'glucose', cnf, cnf ) )
        # os.system( '%s -model -nthreads=8 %s > %s.res' % ( 'glucose-syrup', cnf, cnf ) )
        flag, resdict = self.parse( '%s.res' % cnf )
        res_dict.update( resdict ) 
        return flag, res_dict

    def parse( self, filename ):
        pattern_sat = re.compile( r's SATISFIABLE' ) 
        pattern_unsat = re.compile( r's UNSATISFIABLE' )

        Flag = None
        with open( filename, 'r' ) as f:
            # line = f.readline().replace( '\n', '' )
            # print ( line )
            # m = re.match( pattern_sat, line )
            # u = re.match( pattern_unsat, line )
            # if m:
            #     Flag = 1
            # elif u:
            #     Flag = -1
            # else:
            #     Flag = 0 # error

            res_dict = {}
            for line in f:
                if line[0] == 's':
                    m = re.match( pattern_sat, line )
                    u = re.match( pattern_unsat, line )
                    if m:
                        Flag = 1
                    elif u:
                        Flag = -1
                    else:
                        Flag = 0 # error

                if line[0] == 'v':
                    X = line[1:].split( )
                    V = list ( map( int, X ) )

                    for v in V:
                        if v < 0:
                            res_dict [ -v ] = 0
                        elif v > 0:
                            res_dict [ v ] = 1
        return Flag, res_dict 

    def solve( self, time, seed, filename = 'sat', solver = 'kissat', delete = True ):
        if os.path.isdir( 'SAT/' ) == False:
            os.system( 'mkdir SAT/')
        v = str( random.randint( 0, 0xffffffffffffffff ) )
        cnfname = 'SAT/' + filename + v
        self.write_to_file( '%s.cnf' % cnfname ) 
        self.run_file( '%s.cnf' % cnfname, seed, time, solver )
        flag, resdict = self.parse( '%s.cnf.res' % cnfname )

        if delete:
            os.system( 'rm %s.cnf' % cnfname )
            os.system( 'rm %s.cnf.res' % cnfname )

        return flag, resdict

if __name__ == '__main__':
    V = [ [0, 0, 1], [0, 1, 0], [1, 0, 0], 
          [1, 1, 1], [0, 0, 0], [0, 1, 1], ] 
          #[1, 0, 1] ]

    model = sat()

    X = [ model.addVar() for i in range(3) ]

    model.exclude_set( X, V ) 

    flag, resdict = model.solve( time = 1000, seed = 0, solver = 'kissat', delete = True )

    print( flag )

    for k, v in resdict.items():
        print( k, v )

#if __name__ == '__main__':    
#    sat = sat()
#    sat.OR( [0, 1, 2 ] )
