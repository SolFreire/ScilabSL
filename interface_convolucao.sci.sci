function interface_convolucao()
    // Criando a interface gráfica
    fig = figure("position", [100, 100, 500, 400], "figure_name", "Convolução de Funções");
    
    uicontrol(fig, "style", "text", "position", [50, 350, 400, 30], "string", "Insira as funções como expressões (ex: sin(t), exp(-t))");
    
    uicontrol(fig, "style", "text", "position", [50, 300, 100, 30], "string", "Função 1:");
    edit1 = uicontrol(fig, "style", "edit", "position", [150, 300, 300, 30]);
    
    uicontrol(fig, "style", "text", "position", [50, 250, 100, 30], "string", "Função 2:");
    edit2 = uicontrol(fig, "style", "edit", "position", [150, 250, 300, 30]);
    
    btn = uicontrol(fig, "style", "pushbutton", "position", [200, 200, 100, 40], "string", "Calcular", "callback", "calcular_convolucao()");
    
    global resultado;
    resultado = uicontrol(fig, "style", "text", "position", [50, 150, 400, 30], "string", "Resultado: ");
endfunction

function calcular_convolucao()
    global edit1 edit2 resultado;
    
    t = linspace(0, 10, 1000); // Intervalo de tempo para avaliar as funções
    
    f1_expr = get(edit1, "string");
    f2_expr = get(edit2, "string");
    
    // Avaliação das funções
    execstr("f1_vals = " + f1_expr + ";");
    execstr("f2_vals = " + f2_expr + ";");
    
    if size(f1_vals, "*") <> size(t, "*") | size(f2_vals, "*") <> size(t, "*") then
        set(resultado, "string", "Erro: Expressões devem depender de t!");
        return;
    end
    
    y = conv(f1_vals, f2_vals) * (t(2) - t(1)); // Aproximação da convolução contínua
    
    set(resultado, "string", "Resultado calculado! Veja a variável y no workspace.");
    disp("Resultado da convolução armazenado na variável y.");
endfunction

// Executar a interface
interface_convolucao();
