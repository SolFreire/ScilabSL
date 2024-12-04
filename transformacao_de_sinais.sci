function transformacao_de_sinais_gui()
    // Criando a interface gráfica principal
    fig = figure("Position", [100, 100, 400, 300], "Name", "Transformação de Sinais");

    // Texto explicativo
    uicontrol(fig, "Style", "text", "Position", [50, 220, 300, 40], ...
             "String", "Escolha a transformação:", "HorizontalAlignment", "center");

    // Menu suspenso para selecionar a transformação
    uicontrol(fig, "Style", "popupmenu", "Position", [120, 180, 160, 30], ...
             "String", ["Original"; "Amplificar (x2)"; "Atenuar (/2)"; "Adiantar tempo (-1s)"], ...
             "Tag", "menu_transformacao");

    // Botão para aplicar a transformação
    uicontrol(fig, "Style", "pushbutton", "Position", [150, 130, 100, 40], ...
             "String", "Aplicar", "Callback", "aplicar_transformacao()");

    // Botão para plotar o gráfico
    uicontrol(fig, "Style", "pushbutton", "Position", [150, 80, 100, 40], ...
             "String", "Plotar", "Callback", "plotar_grafico()");
endfunction

function y_amplificado = amplificar(y)
    y_amplificado = 2 * y;
endfunction

function y_atenuado = atenuar(y)
    y_atenuado = y / 2;
endfunction

function [y, t2] = adiantar_tempo(y, t2, delta_t)
    // Adianta o tempo deslocando o vetor de tempo
    t2 = t2 + delta_t;
endfunction

function aplicar_transformacao()
    // Obter a escolha do menu suspenso
    menu_transformacao = findobj("Tag", "menu_transformacao");
    opcao = get(menu_transformacao, "Value"); // Retorna 1 (Original), 2 (Amplificar), etc.

    // Definindo os vetores
    t3 = 0:0.1:2.9;
    t5 = 3 + 0.00001*(0:0.1:1.9);
    t6 = 18 - 3*(5:0.1:6);
    
    x = [t3, t5, t6, 0*t6]; // Combinação dos vetores
    y = [t3, t5, t6, 0*t6]; // Combinação dos vetores
    
    t1 = 0:0.1:(length(x) - 1) * 0.1; // Vetor de tempo associado
    t2 = 0:0.1:(length(y) - 1) * 0.1; // Vetor de tempo associado


    // Aplicando a transformação escolhida
    select opcao
    case 2
        y = amplificar(y);
    case 3
        y = atenuar(y);
    case 4
        [y, t2] = adiantar_tempo(y, t2, -2.0); // Adiantamento no tempo
    else
        y = x; // Sem transformação (original)
    end

    // Salvando os dados no ambiente gráfico
    gcf().userdata = struct("x", x, "y", y, "t1", t1, "t2", t2);
endfunction

function plotar_grafico()
    // Recuperando os dados salvos
    data = gcf().userdata;

    // Verificando se os dados estão disponíveis
    if isempty(data) then
        disp("Por favor, aplique uma transformação primeiro!");
        return;
    end

    x = data.x;
    y = data.y;
    t1 = data.t1;
    t2 = data.t2;

    // Criando o vetor tempo para a plotagem

    // Plotando o gráfico com comparação
    clf(); // Limpa a janela de gráficos
    plot(t1, x, 'g-', t2, y, 'b-');
    legend("x ", "y");
    xlabel("Tempo (s)");
    ylabel("Amplitude");
    title("Comparação: Original e Transformado");
endfunction

// Chamando a função principal
transformacao_de_sinais_gui();
