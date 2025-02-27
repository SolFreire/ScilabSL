function checar_estabilidade_bibo()
    // Criar a interface gráfica
    fig = figure("Position", [100, 100, 400, 200], "Name", "Verificação de Estabilidade");
    
    // Campo de entrada para h(t)
    uicontrol("Style", "text", "Position", [20, 150, 100, 20], "String", "h(t):");
    h_input = uicontrol("Style", "edit", "Position", [120, 150, 250, 20], "String", "exp(-t)");
    
    // Campo de saída do resultado
    result_label = uicontrol("Style", "text", "Position", [20, 50, 350, 30], "String", "Resultado: ");
    
    // Criar um botão e passar `h_input` e `result_label` corretamente para a função
    uicontrol("Style", "pushbutton", "Position", [150, 100, 100, 30], "String", "Calcular", ...
              "Callback", 'calcular_estabilidade(get(h_input,"string"), result_label)');
endfunction

function calcular_estabilidade(h_input, result_label)
    // Definir a função de resposta ao impulso h(t)
    deff("y = h(t)", "y=" + h_input);
    
    // Calcular a integral de 0 a infinito
    I = integrate(h_input, t, 0, 1000);
    
    // Verificar estabilidade
    if I < %inf then
        result_text = "O sistema é estável";
    else
        result_text = "O sistema é instável";
    end
    
    // Atualizar a interface gráfica
    set(result_label, "String", "Resultado: " + result_text);
endfunction

// Executar a interface
checar_estabilidade_bibo();
global h_input
