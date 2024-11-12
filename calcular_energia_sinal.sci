function calcular_energia_sinal()
    
    h_exp = findobj("Tag", "expr_input");
    expr = get(h_exp, "String");

    // Ajusta a expressão para multiplicação e potenciação elemento a elemento
    expr = strsubst(expr, "*", ".*");
    expr = strsubst(expr, "^", ".^");

    // Define o vetor de tempo n
    n = 0:100;
    m = 1;

    // Cria a função anônima com deff
    try
        deff("y = sinal(n)", "y = " + expr);  // Define a função com o nome 'sinal'
        sinal_n = sinal(n);  // Avalia a função no vetor de tempo
    catch
        messagebox("Erro na expressão do sinal! Verifique a sintaxe.", "Erro");
        return;
    end
    
    // Cálculo da energia do sinal
    energia = sum(sinal_n .^ 2);
    
    // Exibindo a energia no campo de texto
    h_energia = findobj("Tag", "energia_output");
    set(h_energia, "String", string(energia));

  
    
/*Funcao Degrau
function  sinal_n = u(n)
    if n >= 0 then
        
         y = 1;
         
    else
        
         y=0;
         
    end
endfunction
    
*/
    hg = figure();
    hg.figure_name = "Sistemas Lineares";
    xaltura = 450;   xlargura = 600;
    hg.position = [15 7 xlargura xaltura];
    hg.info_message = 'Professor Dr. Francisco Aquino.'
    // Plotando o gráfico do sinal
    clf;
    subplot(2, 1, 1);
    plot(n, sinal_n, "-o", "LineWidth", 2, "MarkerSize", 3);
    title("Sinal no Tempo");
    xlabel("n");
    ylabel("Amplitude");
    xgrid;
    
    // Exibindo o valor da energia no segundo gráfico
    subplot(2, 1, 2);
    bar(m, energia, 0.05);
    title("Energia do Sinal");
    xlabel("");
    ylabel("Energia");
    xgrid; 

// simulacao - transmitindo o sinal:
buttonf = uicontrol(hg, "Position", [xlargura-80 xaltura-22 75 20], ...
    "Style", "pushbutton", "FontWeight", "bold", "FontSize", 12, ...
    "String", "Fechar !", "Foregroundcolor",[0.9 0.1 0.1], "callback", "close();");


endfunction

close;
clc();
    
// Interface Gráfica
f = figure();
f.figure_name = "Cálculo de Energia de Sinal";
f.position = [10, 10, 500, 250];

// Título
uicontrol(f, "Style", "text", "Position", [150, 200, 200, 30], ...
    "String", "Cálculo de Energia de Sinal", "FontSize", 12, ...
    "FontWeight", "bold");

// Campo de Entrada para Expressão do Sinal
uicontrol(f, "Style", "text", "Position", [30, 150, 150, 20], ...
    "String", "Expressão do Sinal (n):");
expr_input = uicontrol(f, "Style", "edit", "Position", [200, 150, 200, 20], ...
    "String", "sin(n) * exp(-0.1*n)", "Tag", "expr_input");

// Campo para Mostrar a Energia Calculada
uicontrol(f, "Style", "text", "Position", [30, 100, 150, 20], ...
    "String", "Energia do Sinal:");
energia_output = uicontrol(f, "Style", "text", "Position", [200, 100, 200, 20], ...
    "String", "", "Tag", "energia_output", "BackgroundColor", [1, 1, 1]);

// Botão para Calcular a Energia
uicontrol(f, "Position", [200, 50, 100, 30], ...
    "Style", "pushbutton", "FontWeight", "bold", "FontSize", 12, ... 
    "String", "Calcular!", "Foregroundcolor",[0.1 0.1 1], "callback", "calcular_energia_sinal();");

// Configuração do Gráfico
gcf().figure_size = [500, 400];