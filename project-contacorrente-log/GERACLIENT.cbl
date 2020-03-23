      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GERACLIENT.
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQCLI ASSIGN TO "ARQCLIE.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ST-CLI.
       DATA DIVISION.
       FILE SECTION.
       FD  ARQCLI.
       01  RED-CLI.
           03 ID-CLI.
               05 AGENCIA  PIC 9(03).
               05 CONTA    PIC 9(06).
           03 NOME-CLI     PIC X(20).
           03 SALDO        PIC S9(09).
       WORKING-STORAGE SECTION.
       77  ST-CLI          PIC X(02).
       PROCEDURE DIVISION.
       INICIO.
           PERFORM ABRE-ARQ.
           PERFORM PROCESSO.
           PERFORM FINALIZA.
           STOP RUN.

       ABRE-ARQ.
           OPEN OUTPUT ARQCLI.
           IF ST-CLI NOT EQUAL '00'
               DISPLAY 'ERRO DE ABERTURA CLIENTE' ST-CLI
               STOP RUN.
       PROCESSO.
           MOVE 001 TO AGENCIA.
           MOVE 002222 TO CONTA.
           MOVE 'Manuel de Almeida' TO NOME-CLI.
           MOVE 1000000 TO SALDO.
           WRITE RED-CLI.

           MOVE 001 TO AGENCIA.
           MOVE 011111 TO CONTA.
           MOVE 'Joao da Silva' TO NOME-CLI.
           MOVE 2000000 TO SALDO.
           WRITE RED-CLI.

           MOVE 001 TO AGENCIA.
           MOVE 033333 TO CONTA.
           MOVE 'Alfredo das Neves' TO NOME-CLI.
           MOVE 3500000 TO SALDO.
           WRITE RED-CLI.

           MOVE 012 TO AGENCIA.
           MOVE 044444 TO CONTA.
           MOVE 'Maria Aparecida' TO NOME-CLI.
           MOVE 4200000 TO SALDO.
           WRITE RED-CLI.

       FINALIZA.
           CLOSE ARQCLI.
