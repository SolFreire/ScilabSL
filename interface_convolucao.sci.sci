function [] = interface_convolution()
    
    if ~isdef('plot2d') then
        disp('Carregando módulos gráficos...');
    end
    
    figure("figure_name", "Interface de Convolução de Sinais", "position", [100 100 950 600]);
    
    
    title_interface = uicontrol("style", "text", ...
                              "string", "CONVOLUÇÃO DE SINAIS", ...
                              "position", [350 570 250 25], ...
                              "fontsize", 16, ...
                              "horizontalalignment", "center", ...
                              "tag", "title_interface");
    
    
    label_signal1 = uicontrol("style", "text", ...
                            "string", "Sinal x[n]:", ...
                            "position", [40 540 80 20], ...
                            "tag", "label_signal1");
    
    edit_signal1 = uicontrol("style", "edit", ...
                           "string", "1 2 3", ...
                           "position", [130 540 320 20], ...
                           "tag", "edit_signal1");
    
    label_n0_signal1 = uicontrol("style", "text", ...
                               "string", "Início (n0):", ...
                               "position", [460 540 70 20], ...
                               "tag", "label_n0_signal1");
    
    edit_n0_signal1 = uicontrol("style", "edit", ...
                              "string", "0", ...
                              "position", [535 540 50 20], ...
                              "tag", "edit_n0_signal1");
    
    
    label_signal2 = uicontrol("style", "text", ...
                            "string", "Sinal h[n]:", ...
                            "position", [40 510 80 20], ...
                            "tag", "label_signal2");
    
    edit_signal2 = uicontrol("style", "edit", ...
                           "string", "0.5 0.5", ...
                           "position", [130 510 320 20], ...
                           "tag", "edit_signal2");
    
    label_n0_signal2 = uicontrol("style", "text", ...
                               "string", "Início (n0):", ...
                               "position", [460 510 70 20], ...
                               "tag", "label_n0_signal2");
    
    edit_n0_signal2 = uicontrol("style", "edit", ...
                              "string", "0", ...
                              "position", [535 510 50 20], ...
                              "tag", "edit_n0_signal2");
    
    
    button_calculate = uicontrol("style", "pushbutton", ...
                               "string", "Calcular Convolução", ...
                               "position", [600 525 180 30], ...
                               "callback", "calculate_and_plot", ...
                               "tag", "button_calculate");
    
   
    help_text = uicontrol("style", "text", ...
                        "string", "Digite os valores dos sinais separados por espaços. O início (n0) indica o índice do primeiro elemento.", ...
                        "position", [40 480 870 20], ...
                        "fontsize", 10, ...
                        "horizontalalignment", "left", ...
                        "tag", "help_text");
    
    
    separator = uicontrol("style", "frame", ...
                        "position", [20 470 910 2], ...
                        "background", [0.7 0.7 0.7], ...
                        "tag", "separator");
    
    
    subplot(311);
    a = gca();
    a.tag = "plot_signal1";
    title("Sinal x[n]", "fontsize", 3);
    
    subplot(312);
    a = gca();
    a.tag = "plot_signal2";
    title("Sinal h[n]", "fontsize", 3);
    
    subplot(313);
    a = gca();
    a.tag = "plot_convolution_result";
    title("Resultado da Convolução y[n] = x[n] * h[n]", "fontsize", 3);
    
    
    hs = gcf().children;
    for i = 1:3
        hs(i).position = [0.1, 0.1+(i-1)*0.26, 0.8, 0.24];
    end
endfunction


function plot_discrete(x, y, color)
    
    plot2d(x, y, style=-9, rect=[min(x)-1, min(y)-0.5, max(x)+1, max(y)+0.5]);
    
    
    plot2d(x, y, style=-9);
endfunction

function [] = calculate_and_plot()
    
    x_str = get(findobj("tag", "edit_signal1"), "string");
    h_str = get(findobj("tag", "edit_signal2"), "string");
    
    
    x = evstr("[" + x_str + "]");
    h = evstr("[" + h_str + "]");
    
   
    n0_x_str = get(findobj("tag", "edit_n0_signal1"), "string");
    n0_h_str = get(findobj("tag", "edit_n0_signal2"), "string");
    
    n0_x = evstr(n0_x_str);
    n0_h = evstr(n0_h_str);
    
    
    nx = n0_x:(n0_x + length(x) - 1);
    nh = n0_h:(n0_h + length(h) - 1);
    
    
    y = conv(x, h);
    
    
    n0_y = n0_x + n0_h;
    ny = n0_y:(n0_y + length(y) - 1);
    
    
    subplot(311);
    plot_discrete(nx, x, "blue");
    title("Sinal x[n]", "fontsize", 3);
    xlabel("n", "fontsize", 2);
    ylabel("x[n]", "fontsize", 2);
    a = gca();
    a.data_bounds = [min(nx)-1, max(nx)+1, min(x)-0.5, max(x)+0.5];
    
    
    subplot(312);
    plot_discrete(nh, h, "green");
    title("Sinal h[n]", "fontsize", 3);
    xlabel("n", "fontsize", 2);
    ylabel("h[n]", "fontsize", 2);
    a = gca();
    a.data_bounds = [min(nh)-1, max(nh)+1, min(h)-0.5, max(h)+0.5];
    
    
    subplot(313);
    plot_discrete(ny, y, "red");
    title("Resultado da Convolução y[n] = x[n] * h[n]", "fontsize", 3);
    xlabel("n", "fontsize", 2);
    ylabel("y[n]", "fontsize", 2);
    a = gca();
    a.data_bounds = [min(ny)-1, max(ny)+1, min(y)-0.5, max(y)+0.5];
endfunction

interface_convolution();
