// Tela de creditos em overlay sobre toda a tela.
// A sala rm_title eh larga e baixa (940x120), entao usamos a largura:
// equipe na coluna esquerda, assets/bibliotecas na direita.
// Clique em qualquer lugar fecha (ver Step_0).

var _w  = room_width;   // 940
var _h  = room_height;  // 120
var _cx = _w * 0.5;

// Fundo escuro semitransparente cobrindo a tela inteira.
draw_set_alpha(0.85);
draw_set_color(c_black);
draw_rectangle(0, 0, _w, _h, false);
draw_set_alpha(1);

draw_set_font(fnt_small);
draw_set_valign(fa_top);

// Titulo (centralizado no topo)
draw_set_halign(fa_center);
draw_set_color(c_lime);
draw_text(_cx, 1, "CREDITOS");

var _y0 = 22;
var _dy = 16;

// Coluna esquerda: equipe (nome - funcao na mesma linha)
draw_set_halign(fa_left);
var _team = [
    "Pedro Aguiar - Gerente de Projeto",
    "Tiago Oliveira - Desenvolvedor",
    "Victor Domynick - Desenvolvedor",
    "Pedro Igor - Desenvolvedor",
    "Alisson Nunes - Desenvolvedor",
];
for (var _i = 0; _i < array_length(_team); _i++)
{
    draw_set_color(c_white);
    draw_text(70, _y0 + _i * _dy, _team[_i]);
}

// Coluna direita: assets / bibliotecas
var _rx = 560;
draw_set_color(c_yellow);
draw_text(_rx, _y0, "Assets / Bibliotecas");
draw_set_color(c_gray);
draw_text(_rx, _y0 + _dy,     "Victory SFX: Jon K. Fite");
draw_text(_rx, _y0 + _dy * 2, "Feito com GameMaker");

// Rodape (centralizado embaixo)
draw_set_halign(fa_center);
draw_set_color(c_ltgray);
draw_text(_cx, 104, "Clique para voltar");

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
