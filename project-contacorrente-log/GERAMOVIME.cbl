      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GERAMOVIMENT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQMOV ASSIGN TO 'ARQMOVI.DAT'
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ST-MOV.
       DATA DIVISION.
       FILE SECTION.
       FD  ARQMOV.
       01  REG-MOV.
           03 ID-MOV.
               05 AGENCIA  PIC 9(03).
               05 CONTA    PIC 9(06).
           03 MOVIMENTO    PIC S9(09).
       WORKING-STORAGE SECTION.
       77  ST-MOV          PIC X(02).
       PROCEDURE DIVISION.
       INICIO.
           PERFORM ABRE-ARQ.
           PERFORM PROCESSO.
           PERFORM FINALIZA.
           STOP RUN.

       ABRE-ARQ.
           OPEN OUTPUT ARQMOV
           IF ST-MOV NOT EQUAL TO '00'
               DISPLAY 'ERRO AO ABRIR O ARQUIVO' ST-MOV
               STOP RUN.
       PROCESSO.
           MOVE 001 TO AGENCIA.
           MOVE 002222 TO CONTA.
           MOVE 50000 TO MOVIMENTO.
           WRITE REG-MOV.

           MOVE 001 TO AGENCIA.
           MOVE 002222 TO CONTA.
           MOVE 250000 TO MOVIMENTO.
           WRITE REG-MOV.

           MOVE 001 TO AGENCIA.
           MOVE 031313 TO CONTA.
           MOVE 550000 TO MOVIMENTO.
           WRITE REG-MOV.

           MOVE 012 TO AGENCIA.
           MOVE 044444 TO CONTA.
           MOVE -200000 TO MOVIMENTO.
           WRITE REG-MOV.


       FINALIZA.
           CLOSE ARQMOV.
