function transformacao_de_sinais()
    // Definindo os vetores
    t3 = 0:0.1:2.9;
    t5 = 3 + 0*(0:0.1:1.9);
    t6 = 18 - 3*(5:0.1:6);
    x = [t3, t5, t6, 0*t6]; // Combinação dos vetores

    // Definindo o vetor x2 como cada segundo elemento de x
    x2 = x(1:2:$);

    // Criando o vetor tempo para a plotagem
    t_total = 0:0.1:(length(x)-1)*0.1;
    t2_total = 0:0.2:(length(x2)-1)*0.2;

    // Plotando o gráfico
    clf(); // Limpa a janela de gráficos
    plot(t_total, x, 'b-', t2_total, x2, 'r--');
    legend("x", "x2");
    xlabel("Tempo (s)");
    ylabel("Amplitude");
    title("Gráfico das Funções x e x2");
endfunction

// Chamando a função
transformacao_de_sinais();
