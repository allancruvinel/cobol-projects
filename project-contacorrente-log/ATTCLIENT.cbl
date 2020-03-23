      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ATTCLIENT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQCLI ASSIGN TO "ARQCLIE.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ST-CLI.

           SELECT ARQMOV ASSIGN TO "ARQMOVI.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ST-MOV.

           SELECT ARQLOG ASSIGN TO "ARQLOG.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ST-LOG.
       DATA DIVISION.
       FILE SECTION.
       FD  ARQCLI.
       01  RED-CLI.
           03 ID-CLI.
               05 AGENCIA  PIC 9(03).
               05 CONTA    PIC 9(06).
           03 NOME-CLI     PIC X(20).
           03 SALDO        PIC S9(09).

       FD  ARQMOV.
       01  REG-MOV.
           03 ID-MOV.
               05 AGENCIA-MOV  PIC 9(03).
               05 CONTA-MOV    PIC 9(06).
           03 MOVIMENTO    PIC S9(09).

       FD  ARQLOG.
       01  REG-LOG.
           03 ID-LOG.
               05 AGENCIA-LOG  PIC 9(03).
               05 CONTA-LOG    PIC 9(06).
           03 DESCRICAO-LOG    PIC X(20).
           03 VALOR-LOG        PIC S9(09).
       WORKING-STORAGE SECTION.
       1   WS-FILES.
           03  ST-CLI          PIC X(02).
           03  ST-MOV          PIC X(02).
           03  ST-LOG          PIC X(02).
           03  FIM-CLI         PIC 9(1).
           03  FIM-MOV         PIC 9(1).
           03  ACHOU           PIC 9(1).
       PROCEDURE DIVISION.
       INICIO.
           MOVE ZEROS TO WS-FILES.
           PERFORM ABRE-ARQ.
           PERFORM PROCESSO.
           PERFORM FINALIZA.
           STOP RUN.

       ABRE-ARQ.
           OPEN I-O ARQCLI
           IF ST-CLI NOT EQUAL TO '00'
               DISPLAY 'NAO PODE ABRIR O ARQUIVO' ST-CLI
               STOP RUN.

           OPEN INPUT ARQMOV
           IF ST-CLI NOT EQUAL TO '00'
               DISPLAY 'NAO PODE ABRIR O ARQUIVO' ST-MOV
               STOP RUN.

           OPEN OUTPUT ARQLOG
           IF ST-CLI NOT EQUAL TO '00'
               DISPLAY 'NAO PODE ABRIR O ARQUIVO' ST-LOG
               STOP RUN.
       PROCESSO.
           READ ARQCLI AT END MOVE 1 TO FIM-CLI.
           READ ARQMOV AT END MOVE 1 TO FIM-MOV.
           PERFORM LERMOV UNTIL FIM-MOV EQUAL 1.

           LERMOV.

               PERFORM LERCLI UNTIL FIM-CLI = 1.

      *        abaixo apos procurar no arquivo cliente inteiro retorna esse if se nao encontrar o registro

               IF ACHOU = 0
                   MOVE CONTA-MOV TO CONTA-LOG
                   MOVE AGENCIA-MOV TO AGENCIA-LOG
                   MOVE " NÃO ENCONTRADA" TO DESCRICAO-LOG
                   MOVE MOVIMENTO TO VALOR-LOG
                   WRITE REG-LOG
      *            esse if cria no arquivo log se o registro nao for encontrado
               ELSE
                   MOVE ZERO TO ACHOU
               END-IF

               READ ARQMOV AT END MOVE 1 TO FIM-MOV.

      *        abaixo \/fecha e abre o arquivo para voltar a ler do inicio

               CLOSE ARQCLI.
               OPEN I-O ARQCLI.
               MOVE ZERO TO FIM-CLI.
               READ ARQCLI AT END MOVE 1 TO FIM-CLI.


               LERCLI.

                   IF CONTA=CONTA-MOV

                          COMPUTE SALDO = SALDO+MOVIMENTO
                          REWRITE RED-CLI
                          MOVE SALDO TO VALOR-LOG
                          MOVE " CONTA ATUALIZADA" TO DESCRICAO-LOG
                          MOVE AGENCIA TO AGENCIA-LOG
                          MOVE CONTA TO CONTA-LOG
                          WRITE REG-LOG
                          MOVE 1 TO ACHOU
                   END-IF

                       READ ARQCLI AT END MOVE 1 TO FIM-CLI.





       FINALIZA.
           CLOSE ARQCLI.
           CLOSE ARQMOV.
           CLOSE ARQLOG.
