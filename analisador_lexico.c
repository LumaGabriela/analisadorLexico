#include <stdio.h>
#include <string.h>
#include "lex.yy.h" // O arquivo C gerado pelo Flex (nome pode variar).


int main() {
    char input[] = "int x = 42;"; // Input predefinido na variável 'input'.
    YY_BUFFER_STATE buffer; // Declaração de buffer de entrada do Flex.

    // Cria o buffer de entrada usando o input predefinido.
    buffer = yy_scan_string(input);

    // Chama o analisador léxico para processar o input.
    yylex();

    // Libera o buffer quando não for mais necessário.
    yy_delete_buffer(buffer);

    return 0;
}
