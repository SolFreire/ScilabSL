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

function x_amplificado = amplificar(x)
    x_amplificado = 2 * x;
endfunction

function x_atenuado = atenuar(x)
    x_atenuado = x / 2;
endfunction

function [x, t] = adiantar_tempo(x, t, delta_t)
    // Adianta o tempo deslocando o vetor de tempo
    t = t + delta_t;
endfunction

function aplicar_transformacao()
    // Obter a escolha do menu suspenso
    menu_transformacao = findobj("Tag", "menu_transformacao");
    opcao = get(menu_transformacao, "Value"); // Retorna 1 (Original), 2 (Amplificar), etc.

    // Definindo os vetores
    t3 = 0:0.1:2.9;
    t5 = 3 + 0*(0:0.1:1.9);
    t6 = 18 - 3*(5:0.1:6);
    x = [t3, t5, t6, 0*t6]; // Combinação dos vetores
    t = 0:0.1:(length(x) - 1) * 0.1; // Vetor de tempo associado

    // Aplicando a transformação escolhida
    select opcao
    case 2
        x_transformado = amplificar(x);
    case 3
        x_transformado = atenuar(x);
    case 4
        [x_transformado, t] = adiantar_tempo(x, t, -1.0); // Adiantamento no tempo
    else
        x_transformado = x; // Sem transformação (original)
    end

    // Salvando os dados no ambiente gráfico
    gcf().userdata = struct("x", x, "x_transformado", x_transformado, "t", t);
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
    x_transformado = data.x_transformado;
    t = data.t;

    // Criando o vetor tempo para a plotagem
    t_total = t;
    x2_transformado = x_transformado(1:2:$);
    t2_total = t_total(1:2:$);

    // Plotando o gráfico com comparação
    clf(); // Limpa a janela de gráficos
    plot(t_total, x, 'g-', t_total, x_transformado, 'b-', t2_total, x2_transformado, 'r--');
    legend("x original", "x transformado", "x2 transformado");
    xlabel("Tempo (s)");
    ylabel("Amplitude");
    title("Comparação: Original e Transformado");
endfunction

// Chamando a função principal
transformacao_de_sinais_gui();
