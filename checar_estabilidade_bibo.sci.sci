// Função para verificar a estabilidade do sistema
function ehEstavel = verificarEstabilidade(denominador)
    // Calcula os polos do sistema
    polos = roots(denominador);
    
    // Verifica se todos os polos têm parte real negativa
    if real(polos) < 0 then
        ehEstavel = %T; // Estável
    else
        ehEstavel = %F; // Instável
    end
endfunction

// Função para transformar a equação diferencial em Laplace
function denominador = transformarParaLaplace(equacao)
    // Define a variável simbólica 's'
    s = poly(0, 's');
    
    // Converte a equação diferencial para o domínio de Laplace
    // Exemplo: "y'' + 3y' + 2y" -> s^2 + 3*s + 2
    denominador = evstr(equacao);
endfunction

// Função chamada quando o botão "Verificar Estabilidade" é pressionado
function verificarEstabilidadeCallback()
    // Obtém a equação diferencial do campo de entrada
    equacao_str = get(handles.equacao_input, "string");
    
    // Transforma a equação diferencial para o domínio de Laplace
    denominador = transformarParaLaplace(equacao_str);
    
    // Verifica a estabilidade
    estavel = verificarEstabilidade(denominador);
    
    // Exibe o resultado
    if estavel then
        resultado_str = "O sistema é estável.";
    else
        resultado_str = "O sistema é instável.";
    end
    set(handles.resultado_text, "string", resultado_str);
endfunction

// Cria a janela gráfica
f = figure("figure_name", "Verificação de Estabilidade no Domínio do Tempo", "position", [100 100 500 300]);

// Cria um texto para o campo da equação diferencial
uicontrol(f, "style", "text", "string", "Equação Diferencial (ex: s^2 + 3*s + 2):", "position", [20 230 250 20]);

// Cria um campo de entrada para a equação diferencial
handles.equacao_input = uicontrol(f, "style", "edit", "string", "s^2 + 3*s + 2", "position", [280 230 200 20]);

// Cria um botão para verificar a estabilidade
uicontrol(f, "style", "pushbutton", "string", "Verificar Estabilidade", "position", [150 150 200 30], "callback", "verificarEstabilidadeCallback");

// Cria um texto para exibir o resultado
handles.resultado_text = uicontrol(f, "style", "text", "string", "", "position", [50 100 400 30], "fontsize", 14);
