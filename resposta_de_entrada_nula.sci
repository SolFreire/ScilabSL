// Função para calcular a resposta de entrada nula
function resposta_de_entrada_nula()
    // Obtendo os valores dos campos de entrada
    a = evstr(get(findobj("Tag", "input_a"), "String"));
    b = evstr(get(findobj("Tag", "input_b"), "String"));
    c = evstr(get(findobj("Tag", "input_c"), "String"));
    y0 = evstr(get(findobj("Tag", "input_y0"), "String"));
    yd0 = evstr(get(findobj("Tag", "input_yd0"), "String"));

    // Calculando as raízes da equação característica
    delta = b^2 - 4*a*c;
    /*
    if delta < 0 then
        raiz1 = (-b + %i * sqrt(abs(delta))) / (2*a);
        raiz2 = (-b - %i * sqrt(abs(delta))) / (2*a);
        messagebox(msprintf("Raízes complexas:\nRaiz 1 = %.2f + %.2fi\nRaiz 2 = %.2f - %.2fi", ...
                            real(raiz1), imag(raiz1), real(raiz2), imag(raiz2)));
    end
    */
    raiz1 = (-b + sqrt(delta)) / (2*a);
    raiz2 = (-b - sqrt(delta)) / (2*a);

    // Exibir resultado
    if raiz1 ~= raiz2 then
        // Matriz do sistema
        matriz = [1, 1; raiz1, raiz2];
        vetorIn = [y0; yd0];

        // Calculando coeficientes C1 e C2
        coeficientes = matriz \ vetorIn;
        C1 = coeficientes(1);
        C2 = coeficientes(2);
        messagebox(msprintf("%.1f * e^(%.2f t) + (%.2f * e^(%.1f t))", C1, raiz1, C2, raiz2), "Resultado");

    else
        //Matriz do sistema
        matriz = [1,0; raiz1,1];
        vetorIn = [y0; yd0];
        
        //// Calculando coeficientes C1 e C2
        coeficientes = matriz \ vetorIn;
        C1 = coeficientes(1);
        C2 = coeficientes(2);
        messagebox(msprintf("(%.1f + (%.1f * t)) * e^(%.1f t)", C1, C2, raiz1), "Resultado");
    end
    
endfunction

// Criar janela principal
f = figure();
set(f, "Resize", "off");
f.figure_name = "Resposta de Entrada Nula";
f.position = [10, 10, 500, 300];

// Título
uicontrol(f, "Style", "text", "Position", [175, 250, 160, 30], ...
    "String", "Resposta de Entrada Nula", "FontSize", 12, "FontWeight", "bold");

// Campo de Entrada de A
uicontrol(f, "Style", "edit", "Position", [165, 200, 40, 20], ...
    "String", "A", "Tag", "input_a");
uicontrol(f, "Style", "text", "Position", [210, 200, 25, 20], "String", "λ²");

// Campo de Entrada de B
uicontrol(f, "Style", "edit", "Position", [245, 200, 40, 20], ...
    "String", "B", "Tag", "input_b");
uicontrol(f, "Style", "text", "Position", [290, 200, 25, 20], "String", "λ");

// Campo de Entrada de C
uicontrol(f, "Style", "edit", "Position", [320, 200, 40, 20], ...
    "String", "C", "Tag", "input_c");

// Campo de Entrada y(0)
uicontrol(f, "Style", "text", "Position", [170, 150, 50, 20], "String", "y(0):");
uicontrol(f, "Style", "edit", "Position", [220, 150, 40, 20], ...
    "String", "", "Tag", "input_y0");

// Campo de Entrada y'(0)
uicontrol(f, "Style", "text", "Position", [270, 150, 50, 20], "String", "y''(0):");
uicontrol(f, "Style", "edit", "Position", [320, 150, 40, 20], ...
    "String", "", "Tag", "input_yd0");

// Botão para Calcular
uicontrol(f, "Style", "pushbutton", "Position", [200, 100, 100, 30], ...
    "String", "Calcular", "FontSize", 11, ...
    "Callback", "resposta_de_entrada_nula()");
