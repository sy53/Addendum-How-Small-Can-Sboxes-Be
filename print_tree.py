import networkx as nx
import matplotlib.pyplot as plt

def draw_circuit_graph( VAR, EDGE, GATE, cordinate_X, cordinate_Y ):
    # 创建图
    G = nx.DiGraph()

    # 添加节点，和属性
    for i in range( len(GATE) ):
        if ( i < len(VAR) ):
            G.add_node( i, out = VAR[i])
        else:
            G.add_node( i, out = 'y%d' % (i-len(VAR)) )

    # 添加边
    G.add_edges_from( EDGE )    

    # 为节点重命名
    G = nx.relabel_nodes( G, GATE )

    # # 打印节点的属性
    for node in G.nodes:
        print(node, G.nodes[node])

    pos = {node: (cordinate_X[node], cordinate_Y[node]) for node in G.nodes}
    size = [2500]*len(VAR) + [4000]*(len(GATE)-len(VAR))
    # colors = ['skyblue']*len(VAR) + ['red']*(len(GATE)-len(VAR))
    colors = ['turquoise']*len(VAR) + ['dodgerblue']*(len(GATE)-len(VAR))
    offset_pos = {}
    for node, (x, y) in pos.items():
        if node[0] == 'y':
            offset_pos[node] = (x, y+0.1)
        else:
            offset_pos[node] = (x, y)

    # 可视化图
    plt.figure(figsize=(10, 10))
    nx.draw(G, pos, with_labels=False, node_size=size, node_color=colors, alpha=0.7,arrows=True)
    nx.draw_networkx_labels(G, offset_pos, font_size=10, font_color='black')
    plt.title("Sbox Circuit")
    plt.savefig('logic_gate_tree.png', format='png', bbox_inches='tight')


