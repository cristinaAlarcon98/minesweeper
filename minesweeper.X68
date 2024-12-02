*-----------------------------------------------------------
* Title      :
* Written by : CRIS
* Date       :
* Description:
*-----------------------------------------------------------
    OPT MEX
    ORG    $1000
CUADRADO MACRO
            MOVEM.L	D0-D4,-(A7)               
            MOVE.L \1,D1 *Pasamos el color como parametro
            MOVE.L #80,D0 ;si lo quito no salen cuadrados con n�meros
            TRAP #15
            MOVE.L #81,D0  ;PLUMA Y RELLENO MISMO COLOR
            TRAP #15   ;PLUMA Y RELLENO MISMO COLOR   
            MOVE.W \2,D1 *x1
            MOVE.W \3,D2 *y1
            MOVE.W \4,D3 *x2
            MOVE.W \5,D4 *y2
            MOVE.L #87,D0
            TRAP #15 ;Dibujamos un cuadrado con las proporciones que le indiquemos
     
            MOVEM.L (A7)+,D0-D4
            ENDM    


NUMERO MACRO
        
*        MOVE.L GRIDCOLOR,D1 *Modificamos color
*        MOVE.L #$3150001,D2  * tipografia y tama�o
        MOVEM.L	D0-D4/A1,-(A7)
        MOVE.L #21,D0  *comando x defecto que se le pasa a D0
        MOVE.L \1,D1 *Modificamos color
        MOVE.L \2,D2  * tipografia y tama�o
        TRAP #15

        MOVE.L #95,D0
        MOVE.W \3,D1 *Coordenada X
        MOVE.W \4,D2 *Coordenada y
        ADD.W #5,D2
        MOVE.L \5,A1
        TRAP #15
        SUB.W #5,D2
        MOVEM.L (A7)+,A1/D0-D4
        ENDM



START:

MUSICA 
 MOVE.L #71,D0   *CARGAMOS MUSICA
 MOVE.L #CANCIONJUEGO,A1
 MOVE.B #1,D1
 TRAP #15
 

 MOVE.L #71,D0
 MOVE.L #CANCIONBOMBA,A1
 MOVE.B #2,D1
 TRAP #15
 

 
 MOVE.L #76,D0 *REPRODUCIMOS MUSICA
 MOVE.B #1,D1
 MOVE.L #1,D2 
 TRAP #15

PANTALLAINICIO 
  MOVE.L #11,D0
  MOVE.W #$0000,D1    
  TRAP #15

        *FONDO DORADO
        CUADRADO DORADO,X1INICIO,Y1INICIO,X2INICIO,Y2INICIO 
        * CUADRADO VERDE
 CUADRADO VERDE,X1INICIO2,Y1INICIO2,X2INICIO2,Y2INICIO2
   *PRESS START 
  NUMERO BLANCO,#$1000001,X1INICIO3,Y1INICIO3,#TEXTOINICIO2 
*               MOVEM.L D0-D4,-(A7)    
                 MOVE.L #$0013C9FF,D1 *Pasamos el color como parametro
                 MOVE.L #80,D0 ;si lo quito no salen cuadrados con n�meros
                 TRAP #15
                 MOVE.L #81,D0  ;PLUMA Y RELLENO MISMO COLOR
                TRAP #15  
*                 MOVEM.L (A7)+,D0-D4
                 *BUSCAMINAS
      NUMERO GRANATE,#$1500001,LETRASINICIOX,LETRASINICIOY,#TEXTOINICIO

            *NOMBRES
      NUMERO GRANATE,#$1000001,X1INICIO4,Y1INICIO4,#TEXTOINICIO3
            *I DE INFO
       NUMERO NEGRO,#$1200001,XIDEINFO,YIDEINFO,#TEXTOIDEINFO
      
        
CLIKINFO
            
            MOVE.L #61,D0
            MOVE.L #0,D1
            TRAP #15
           
            BTST #0,D0   *Comprueba si el bit 0 est� a 1 (pulsado) (corresponde con click izqdo)
            BNE HAYCLIKENINFO   *salta si el bit 0 es 1 (hay clik) 
            JMP CLIKINFO      *Si no es clik salta al bucle   
HAYCLIKENINFO
         
            CLR.L D2
            SWAP D1      *En D1 tenemos 00|YY|00|XX
            MOVE.W D1,D2
            EXT.L D2     *Extiende el signo de Word a Long (para incluir negativos)
            CLR.W D1
            SWAP D1      *Y=D2 X=D1
            EXT.L D1     *Extiende el signo de Word a Long (para incluir negativos) 
            CMP.L #600,D1 *Comparamos si hemos clikado a la derecha
            BCS CLIKSTART
            CMP.L #80,D2 *Comparamos si hemos clikado arriba (a la derecha)
            BHI CLIKSTART 
            JMP INFO
      
CLIKSTART
        CMP.L #225,D1 *Comparamos si hemos clikado a la derecha X1INICIO2 DC.W 225

            BCS CLIKINFO
            CMP.L #400,D1 *Comparamos si hemos clikado arriba (a la derecha)
            BHI CLIKINFO
            CMP.L #290,D2 *Comparamos si hemos clikado a la derecha
            BCS CLIKINFO
            CMP.L #350,D2 *Comparamos si hemos clikado arriba (a la derecha)
            BHI CLIKINFO
               
            JMP START1
      


INFO    
     
         *FONDO DORADO
        CUADRADO DORADO,X1INICIO,Y1INICIO,X2INICIO,Y2INICIO
         *MOSTRAMOS  BACK 
        NUMERO GRANATE,#$100001,#30,#450,#TEXTOBACK
        MOVEM.L	D0-D4,-(A7)
        MOVE.L #21,D0
        MOVE.L #$00000080,D1
        MOVE.L #$1000001,D2
        TRAP #15
        MOVEM.L (A7)+,D0-D4  
        MOVEM.L	D0-D4,-(A7)   
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0    *linea de texto
        MOVE.L #MENSAJEINSTRUCCIONES1,A1 
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES2,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES3,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES4,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES5,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES6,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES7,A1
        TRAP #15
        MOVE.L #14,D0   *enter
        MOVE.L #ENTER,A1
        TRAP #15
        MOVE.L #14,D0
        MOVE.L #MENSAJEINSTRUCCIONES8,A1
        TRAP #15
        
        
CLIKVOLVER

            MOVE.L #61,D0
            MOVE.L #0,D1
            TRAP #15
           
            BTST #0,D0   *Comprueba si el bit 0 est� a 1 (pulsado) (corresponde con click izqdo)
            BNE HAYCLIKENVOLVER   *salta si el bit 0 es 1 (hay clik) 
            JMP CLIKVOLVER


        *Si no es clik salta al bucle   
HAYCLIKENVOLVER
         
            CLR.L D2
            SWAP D1      *En D1 tenemos 00|YY|00|XX
            MOVE.W D1,D2
            EXT.L D2     *Extiende el signo de Word a Long (para incluir negativos)
            CLR.W D1
            SWAP D1      *Y=D2 X=D1
            EXT.L D1     *Extiende el signo de Word a Long (para incluir negativos) 
            CMP.L #80,D1 *Comparamos si hemos clikado a la derecha
            BHI CLIKVOLVER
            CMP.L #400,D2 *Comparamos si hemos clikado arriba (a la derecha)
            BCS CLIKVOLVER
            MOVEM.L (A7)+,D0-D4 *MOVEMOS A LA PILA antes de saltar
            JMP PANTALLAINICIO
      


     
        
BUCLEPRUEBA        
        JMP BUCLEPRUEBA
         
START1

        MOVE.L #76,D0 *PARAMOS MUSICA
        MOVE.B #1,D1
        MOVE.L #2,D2 
        TRAP #15
 
        MOVE.L #0,D0        *LIMPIAMOS
        MOVE.L #0,D1
        MOVE.L #0,D2
        MOVE.L #MATRIZALEATORIA,A0      *APUNTAMOS A LA PRIMERA POSICION
ALEATORIO 
          
        MOVE.L  #8,D0
        TRAP    #15
        MOVE.B D1, NUMEROAL *MOVEMOS LA PARTE BAJA DE D1 
        MOVE.L #0,D1
        MOVE.B NUMEROAL,D1 *DEJAMOS SOLO LA PARTE BAJA EN D1
        CMP.B #78,D1       *EVITAMOS SALIRNOS DE LA MATRIZ
        BHI ALEATORIO
        ADD.B #1,D2     *CONTADOR
       
*       MOVE.L #5,D1 *PRUEBA!!! (LUEGO SE UNE CON START)
        ADD.L D1,A0
        CMP.B #34,(A0)
        BEQ EMPIEZAESPACIO
CAMBIARINICIO
        MOVE.B #9,(A0)
        JMP SIGUIENTEMINA
        
EMPIEZAESPACIO
        ADD.L D1,A0
        JMP CAMBIARINICIO
        
        
SIGUIENTEMINA   *COLOCAMOS MINAS A PARTIR DEL NUMERO ALEATORIO     
CONTADOR        ADD.B #1,D2 
                CMP.B #9,D2
                BEQ PONERNUMEROS
        
        MULU.W #3,D1 *MAREAR ALEATORIO
        ADD.L #7,D1
      
        MOVE.L #MATRIZALEATORIA,A0

        ADD.L D1,A0
        
        
        CMP.L #FINMATRIZ,A0 
        BCC FUERADERANGO      *SI SE PASA DE LA ULTIMA POSICION DE LA MATRIZ VAMOS A FUERADERANGO
        CMP.B #9,(A0)
        BEQ YAHAYMINA
        CMP.B #34,(A0)
        BEQ BORDEMATRIZ
        MOVE.B #9,(A0)
        JMP SIGUIENTEMINA
        
FUERADERANGO 
        
        SUB.L #79,D1    *RESTAMOS PARA QUE NO SE PASE
        
        MOVE.L #MATRIZALEATORIA,A0    *A0 APUNTA AL PRINCIPIO DE LA MATRIZ
        ADD.L D1,A0

        CMP.L #FINMATRIZ,A0   *SI SIGUE FUERA DE RANGO REPETIMOS EL BUCLE
        BCC FUERADERANGO
        
        BEQ YAHAYMINA
        CMP.B #34,(A0)
        BEQ BORDEMATRIZ
        MOVE.B #9,(A0)

        
        MOVE.B #9,(A0)         
        JMP CONTADOR
      
YAHAYMINA SUB.B #1,D2
          ADD.L #1,D1
	      JMP SIGUIENTEMINA
	
BORDEMATRIZ SUB.B #1,D2
            ADD.L #1,D1
	        JMP SIGUIENTEMINA
	


	
PONERNUMEROS
            
        MOVE.L #0,D0        
        MOVE.L #0,D1
        MOVE.L #0,D2
        MOVE.L #MATRIZALEATORIA,A0
PONERNUMEROS2        
        CMP.B #9,(A0)
        BNE SIGUIENTENUMERO
        
        CMP.B #9,1(A0)
        BEQ SALTARMINA1
        CMP.B #34,1(A0)
        BEQ SALTARMINA1
        ADD.B #1,1(A0) *DERECHA
SALTARMINA1
        CMP.B #9,7(A0)
        BEQ SALTARMINA2
        CMP.B #34,7(A0)
        BEQ SALTARMINA2      
        ADD.B #1,7(A0) *ABAJO IZQUIERDA
SALTARMINA2
        CMP.B #9,8(A0)
        BEQ SALTARMINA3
        CMP.B #34,8(A0)
        BEQ SALTARMINA3   
        ADD.B #1,8(A0) *ABAJO     
SALTARMINA3
        CMP.B #9,9(A0)
        BEQ SALTARMINA4
        CMP.B #34,9(A0)
        BEQ SALTARMINA4
        ADD.B #1,9(A0) *ABAJO DERECHA
SALTARMINA4
        CMP.B #9,-1(A0)
        BEQ SALTARMINA5
        CMP.B #34,-1(A0)
        BEQ SALTARMINA5
        ADD.B #1,-1(A0) *IZQUIERDA
SALTARMINA5
        CMP.B #9,-7(A0)
        BEQ SALTARMINA6
        CMP.B #34,-7(A0)
        BEQ SALTARMINA6
        ADD.B #1,-7(A0) *ARRIBA DERECA
SALTARMINA6
        CMP.B #9,-8(A0)
        BEQ SALTARMINA7
        CMP.B #34,-8(A0)
        BEQ SALTARMINA7        
        ADD.B #1,-8(A0) *ARRIBA
SALTARMINA7
        CMP.B #9,-9(A0)
        BEQ SALTARMINA8
        CMP.B #34,-9(A0)
        BEQ SALTARMINA8
        ADD.B #1,-9(A0) *ARRIBA IZQUIERDA
SALTARMINA8
        
SIGUIENTENUMERO
    ADD.L #1,A0
    CMP.L #FINMATRIZ,A0 
    BEQ TABLAS
    JMP PONERNUMEROS2     

FINAL
          

TABLAS *(PROGRAMA 2)

    MOVE.L #0,D6 
    MOVE.L #MATRIZALEATORIA,A3
SIGUIENTTENUM   
    CMP.B #9,(A3)
    BEQ ESMINA
    ADD.L #1,A3
    CMP.L #FINMATRIZ,A3
    BEQ CONTARMINAS
    JMP SIGUIENTTENUM
ESMINA ADD.B #1,D6
    ADD.L #1,A3
    JMP SIGUIENTTENUM
CONTARMINAS 
    CMP.B #8,D6
    BNE PANTALLAINICIO
    CUADRADO NEGRO,X1INICIO,Y1INICIO,X2INICIO,Y2INICIO *BORRAMOS LA PANTALLA DE INICIO
   
TABLAS2 

            MOVE.L #0,D0 *FILAS
            MOVE.L #0,D3 *COLUMNAS
            CUADRADO GRANATE,X1B,Y1B,X2B,Y2B 

REINCOOR         *Reiniciamos las coordenadas del dibujo de la tabla

    MOVE.W #220,X1 
    MOVE.W #50,Y1
    MOVE.W #245,X2
    MOVE.W #75,Y2
  
MATRIZ1
           CLR.L D0
           CLR.L D1
           CLR.L D2
           CLR.L D3
           CLR.L D4
           CLR.L D5
           CLR.L D6
           CLR.L D7
   
START2      
             

            MOVE.L #MATRIZMOSTRAR,A3 *APUNTAMOS AL PRINCIPIO DE LA MATRIZ
            MOVE.B D2,D0
            MULU.W #7,D0
            ADD.B D3,D0
            MOVE.B (A3,D0),D1
            CMP.B #10,D1
            BEQ MOSTRARCUADRADO
            CMP.B #0,D1
            BEQ MOSTRARCUADRADOPULSADO
            CMP.B #1,D1
            BEQ MOSTRAR1
            CMP.B #2,D1
            BEQ MOSTRAR2
            CMP.B #3,D1
            BEQ MOSTRAR3
            CMP.B #4,D1
            BEQ MOSTRAR4
            CMP.B #5,D1
            BEQ MOSTRAR5
            CMP.B #6,D1
            BEQ MOSTRAR6
            CMP.B #7,D1
            BEQ MOSTRAR7
            CMP.B #8,D1
            BEQ MOSTRAR8
            CMP.B #9,D1
            BEQ MOSTRARBOMBA
            CMP.B #20,D1            
            BEQ MOSTRARBANDERATABLA
           
*            BNE CLIK
                    
MOSTRARCUADRADO CUADRADO DORADO,X1,Y1,X2,Y2    
                JMP AVANZARLAPIZC  
                
MOSTRARCUADRADOPULSADO CUADRADO GRANATE,X1,Y1,X2,Y2
                       MOVEM.L D0-D4,-(A7)    
                       MOVE.L #$0013C9FF,D1 *Pasamos el color como parametro
                       MOVE.L #80,D0 ;si lo quito no salen cuadrados con n�meros
                       TRAP #15
                       MOVE.L #81,D0  ;PLUMA Y RELLENO MISMO COLOR
                       TRAP #15  
                       MOVEM.L (A7)+,D0-D4
                
                       JMP AVANZARLAPIZC  
                
MOSTRAR1        NUMERO BLANCO,#1100000,X1,Y1,#VALOR1    
                JMP AVANZARLAPIZC    

MOSTRAR2        NUMERO BLANCO,#1100000,X1,Y1,#VALOR2     
                JMP AVANZARLAPIZC 

MOSTRAR3        NUMERO BLANCO,#1100000,X1,Y1,#VALOR3     
                JMP AVANZARLAPIZC 

MOSTRAR4        NUMERO BLANCO,#1100000,X1,Y1,#VALOR4    
                JMP AVANZARLAPIZC 

MOSTRAR5        NUMERO BLANCO,#1100000,X1,Y1,#VALOR5     
                JMP AVANZARLAPIZC 

MOSTRAR6        NUMERO BLANCO,#1100000, X1,Y1,#VALOR6     
                JMP AVANZARLAPIZC 

MOSTRAR7        NUMERO BLANCO,#1100000,X1,Y1,#VALOR7   
                JMP AVANZARLAPIZC 

MOSTRAR8        NUMERO BLANCO,#1100000,X1,Y1,#VALOR8     
                JMP AVANZARLAPIZC 

MOSTRARBOMBA    NUMERO BLANCO,#1100000,X1,Y1,#BOMBA                  

                JMP PANTALLAPERDER *IR A FIN O IR A MOSTRAR LA MATRIZ ENTERA 
                
MOSTRARBANDERATABLA  CUADRADO VERDE,X1,Y1,X2,Y2
                 MOVEM.L	D0-D4,-(A7)    
                 MOVE.L #$0013C9FF,D1 *Pasamos el color como parametro
                 MOVE.L #80,D0 ;si lo quito no salen cuadrados con n�meros
                 TRAP #15
                 MOVE.L #81,D0  ;PLUMA Y RELLENO MISMO COLOR
                 TRAP #15  
                 MOVEM.L (A7)+,D0-D4
                 

                JMP AVANZARLAPIZC
             
AVANZARLAPIZC *(COLUMNA)*CUADRADOS
 
            MOVE.W X1,D1
            ADD.W #30,D1
            MOVE.W D1,X1
 
            MOVE.W X2,D1
            ADD.W #30,D1
            MOVE.W D1,X2
 
         
AVANZOMATRIZ1C *(COLUMNAS)   
             ADD.B #1,D3 *AVANZA COLUMNA
             CMP.B #7,D3 *VEMOS SI ESTAMOS AL FINAL DE LA FILA
             BNE START2


AVANZARLAPIZF 
   
            MOVE.W #220,X1
            MOVE.W #245,X2
            MOVE.W #30,D1
            ADD.W  D1,Y1
            ADD.W  D1,Y2
   
   
                   
AVANZOMATRIZ1F      
            
            MOVE.B #0,D3
            ADD.B #1,D2
            CMP #10,D2 *COMPROBAMOS SI HEMOS TERMINADO
            BEQ CLIK
            JMP START2      
 


CLIK
            MOVE.L #61,D0
            MOVE.L #0,D1
            TRAP #15
           
            BTST #0,D0   *Comprueba si el bit 0 est� a 1 (pulsado) (corresponde con click izqdo)
            BNE HAYCLIK   *salta si el bit 0 es 1 (hay clik) 
           
CLIKDERE    BTST #1,D0  *Comprueba el bit 0 (corresponde con click derecho)
            BNE HAYCLIK
            JMP CLIK     * (no hay clik)

            
            
HAYCLIK
              
            
         
            CLR.L D2
            SWAP D1      *En D1 tenemos 00|YY|00|XX
            MOVE.W D1,D2
            EXT.L D2     *Extiende el signo de Word a Long (para incluir negativos)
            CLR.W D1
            SWAP D1      *Y=D2 X=D1
            EXT.L D1     *Extiende el signo de Word a Long (para incluir negativos) 
            
SABERCASILLAX  CMP.L #215,D1 *Comparamos si hemos clikado en el marco izquierdo
               BCS CLIK 
               CMP.L #430,D1 *Comparamos si hemos clikado en el marco derecho
               BHI CLIK 
               SUB.L #215,D1 
               DIVU #30,D1
               SWAP D1     *dejamos la posici�n en d1 (numero entero)
               CLR.W D1
               SWAP D1
              
SABERCASILLAY  CMP.L #45,D2 *Comparamos si hemos clikado en el marco de arriba
               BCS CLIK 
               CMP.L #350,D2 *Comparamos si hemos clikado en el marco de abajao
               BHI CLIK 
               SUB.L #40,D2 
               DIVU #30,D2
               SWAP D2    *dejamos la posici�n en d1 (numero entero)
               CLR.W D2
               SWAP D2
              
SABERBOTON     CMP.B #1,D0
               BEQ MOSTRARNUM
               CMP #2,D0          *SI HAY CLICK DERECHO SALTO
               BEQ MOSTRARBANDERA
             

MOSTRARNUM
            
            
            
            MOVEM.L	D0-D4,-(A7)
SOLTAR2     MOVE.L #61,D0           *Detecta si el clik derecho est� soltado
            MOVE.L #0,D1
            TRAP #15
            CMP.L #0,D0
            BNE SOLTAR2
            MOVEM.L (A7)+,D0-D4
             
             
            MOVE.L D2,D3   
            MULU #8,D2
            ADD.L D2,D1
            MOVE.L #MATRIZALEATORIA,A0
            ADD.L D1,A0
            MOVE.B (A0),D2 
            
            MOVEM.L D0-D7,-(A7)
            MOVE.L #MATRIZMOSTRAR,A0
            SUB.L D3,D1
            ADD.L D1,A0
            *MIRAR SI ES BANDERA, Y SI LO ES REINICIO COORDENADAS
            CMP.B #20,(A0)
            BEQ REINCOOR
            MOVE.B D2,(A0)             
            CMP.B #0,D2    *PARTE DE DESBLOQUEAR CASILLAS ADYACENTES
            BEQ CASILLASADYACENTES       
            
 JMP REINCOOR           

CASILLASADYACENTES   ***********************************************************************************************************************************************************
PONERNUMEROSADY
            
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.L D1,D6
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        MOVE.L #1,D4            *VALOR DERECHA
        MOVE.B (A0,D4),VALORADYACENTE
        CMP.B #34,VALORADYACENTE   *comparamos si hay un muro
        BEQ PONERNUMEROSADY2
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY2
        ADD.L #1,A0       *VALOR DERECHA
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY2
        
                
PONERNUMEROSADY2
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        SUB.L #1,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY3
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY3
        SUB.L #1,A0             *valor izquierda
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY3
        
        
PONERNUMEROSADY3
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        
        SUB.L #1,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY4
        ADD.L #1,A0

        ADD.L #7,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY4
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        SUB.L #1,A0  *diferencia entre las dos matrices por la fila que tiene la aleatoria de mas
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY4
        ADD.L #7,A0                 *arriba izquierda
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY4
            
PONERNUMEROSADY4
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        ADD.L #8,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY5
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        SUB.L #1,A0  *diferencia entre las dos matrices por la fila que tiene la aleatoria de mas
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY5
        ADD.L #8,A0                 *arriba
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY5
                
                
PONERNUMEROSADY5
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        
        ADD.L #1,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY6
        SUB.L #1,A0
        
        ADD.L #9,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY6
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        SUB.L #1,A0  *diferencia entre las dos matrices por la fila que tiene la aleatoria de mas
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY6
        ADD.L #9,A0                       *arriba derecha
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY6
            
            
PONERNUMEROSADY6
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        
        SUB.L #1,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY7
        ADD.L #1,A0
        
        SUB.L #9,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY7
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        ADD.L #1,A0  *diferencia entre las dos matrices por la fila que tiene la aleatoria de mas
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY7
        SUB.L #9,A0                *abajo izquierda
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY7
        
        
PONERNUMEROSADY7
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        SUB.L #8,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ PONERNUMEROSADY8
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        ADD.L #1,A0  *diferencia entre llas dos matrices por la fila que tiene la aleatoria de mas
        CMP.B #20,(A0)
        BEQ PONERNUMEROSADY8
        SUB.L #8,A0                 *abajo
        MOVE.B VALORADYACENTE,(A0)
        JMP PONERNUMEROSADY8
            
PONERNUMEROSADY8
        MOVEM.L (A7)+,D0-D5
        MOVEM.L	D0-D5,-(A7)
        MOVE.B #0,VALORADYACENTE
        MOVE.L D6,D1
        
        MOVE.L #MATRIZALEATORIA,A0
        ADD.L D1,A0
        
        ADD.L #1,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ REINCOOR
        SUB.L #1,A0
        
        SUB.L #7,A0
        MOVE.B (A0),VALORADYACENTE
        CMP.B #34,VALORADYACENTE
        BEQ REINCOOR
        MOVE.L #MATRIZMOSTRAR,A0
        SUB.L D3,D1
        ADD.L D1,A0
        ADD.L #1,A0  *diferencia entre llas dos matrices por la fila que tiene la aleatoria de mas
        CMP.B #20,(A0)
        BEQ REINCOOR
        SUB.L #7,A0                 *abajo derecha
        MOVE.B VALORADYACENTE,(A0)
        JMP REINCOOR
        
        
        
        
        

MOSTRARBANDERA
            MOVEM.L	D0-D4,-(A7)
SOLTAR      MOVE.L #61,D0               *Detecta si el clik derecho est� soltado
            MOVE.L #0,D1
            TRAP #15
            CMP.L #0,D0
            BNE SOLTAR
            MOVEM.L (A7)+,D0-D4
             
            MOVE.L D2,D3   
            MULU #8,D2
            ADD.L D2,D1
            MOVE.L #MATRIZALEATORIA,A0
            ADD.L D1,A0
            MOVE.B (A0),D2
           
            
            MOVE.L #MATRIZMOSTRAR,A0
            SUB.L D3,D1
            ADD.L D1,A0
            CMP.B #10,(A0) *comprobamos si hay hueco vacio
            BNE COMPROBARSIESBANDERA *si no es hueco vamos a comprobar si es una bandera
            MOVE.B #20, (A0) *ponemos bandera
            ADD.B #1,CONTADORDEBANDERAS
CONTADORBOMBAMARCADA
            CMP.B #9,D2 *Comparamos si hay bomba en el sitio donde hemos puesto la bandera
            BNE REINCOOR *si no hay bomba vamos al principio
            ADD.B #1, BOMBASMARCADAS *SI HAY UNA BOMBA en esa posici�n sumamos uno al contador
            CMP.B #8, BOMBASMARCADAS
            *SALTAR� A PANTALLA GANADORA
            
            BEQ COMPROBARNBANDERAS
            JMP REINCOOR 

COMPROBARNBANDERAS
            CMP.B #8,CONTADORDEBANDERAS
            BEQ PANTALLAGANAR
            JMP REINCOOR
           
 
       
COMPROBARSIESBANDERA 
            CMP.B #20, (A0)  *Si est� la bandera ponemos la casilla dorada otra vez, y si no hay nada reiniciamos coordenadas
            BNE REINCOOR 
            MOVE.B #10,(A0)
            SUB.B #1,CONTADORDEBANDERAS
            CMP.B #9,D2
            BNE REINCOOR
            SUB.B #1, BOMBASMARCADAS
            JMP REINCOOR 
  



PANTALLAGANAR
        MOVE.L #23,D0
        MOVE.L #80,D1
        TRAP #15


         CUADRADO DORADO,X1INICIO,Y1INICIO,X2INICIO,Y2INICIO 
         NUMERO VERDE,#$1500001,LETRASINICIOX,LETRASINICIOY,#TEXTOGANAR
         JMP FIN
PANTALLAPERDER
         MOVE.L #76,D0 *REPRODUCIMOS MUSICA
         MOVE.B #2,D1
         MOVE.L #0,D2 
         TRAP #15
         
        MOVE.L #23,D0 *RETARDO
        MOVE.L #80,D1
        TRAP #15

        CUADRADO NEGRO,X1INICIO,Y1INICIO,X2INICIO,Y2INICIO 
        NUMERO BLANCO,#$1500001,LETRASINICIOX,LETRASINICIOY,#TEXTOPERDER

FIN
        SIMHALT             
 ORG $3000
* Put variables and constants here
AQUA   DC.L  $00FFFF00 *aquua
GRANATE  DC.L  $00000080 *GRANATE
DORADO  DC.L  $0013C9FF *DORADO
BLANCO DC.L	$00FFFFFF	BLANCO
VERDE DC.L  $00008000 *VERDE 
NEGRO DC.L $FFFFFFFF

CONTADORDEBANDERAS DC.W 0


MENSAJEINSTRUCCIONES1 DC.B 'INSTRUCCIONES: ',0
MENSAJEINSTRUCCIONES2 DC.B 'El juego consiste en localizar las 8 bombas que hay en el mapa.',0
MENSAJEINSTRUCCIONES3 DC.B 'Utiliza clik izquierdo para desbloquear una casilla. ',0
MENSAJEINSTRUCCIONES4 DC.B 'La casilla desbloqueada muestra con un valor el n�mero de bombas',0
MENSAJEINSTRUCCIONES5 DC.B 'adyacentes,y si la casilla desbloqueada es una bomba habr�s perdido.',0
MENSAJEINSTRUCCIONES6 DC.B 'Puedes utilizar clik derecho para marcar una bomba. ',0
MENSAJEINSTRUCCIONES7 DC.B 'El juego finalizar� cuando todas las bombas est�n marcadas ',0
MENSAJEINSTRUCCIONES8 DC.B 'por banderas o cuando se desbloquee una bomba.',0

TEXTOBACK DC.B 'VOLVER',0

CANCIONJUEGO DC.L 'CANCIONJUEGO.wav ',0
CANCIONBOMBA DC.L 'CANCIONBOMBA.wav',0


X1 DC.W 220
Y1 DC.W 50
X2 DC.W 245
Y2 DC.W 75
X1B DC.W 210
Y1B DC.W 40
X2B DC.W 435
Y2B DC.W 355

X1INICIO DC.W 0
X2INICIO DC.W 700
Y1INICIO DC.W 0
Y2INICIO DC.W 500 

X1INICIO2 DC.W 225
X2INICIO2 DC.W 400
Y1INICIO2 DC.W 290
Y2INICIO2 DC.W 350

TEXTOINICIO DC.W 'BUSCAMINAS',0
LETRASINICIOX DC.W 100
LETRASINICIOY DC.W 50


X1INICIO3 DC.W 265 
Y1INICIO3 DC.W 305
TEXTOINICIO2 DC.W 'PRESS START',0

X1INICIO4 DC.W 20
Y1INICIO4 DC.W 450
TEXTOINICIO3 DC.W 'Cristina Alarc�n y Javier Granero',0

XIDEINFO DC.W 600
YIDEINFO DC.W 15
TEXTOIDEINFO DC.W 'i'

TEXTOGANAR DC.W '�HAS GANADO!',0
TEXTOPERDER DC.W 'HAS PERDIDO...',0

ENTER DC.B LF, CR,0
LF EQU $0A
CR EQU $0D

VALORADYACENTE DC.W 0

VALOR1 DC.W ' 1',0
VALOR2 DC.W ' 2',0
VALOR3 DC.W ' 3',0
VALOR4 DC.W ' 4',0
VALOR5 DC.W ' 5',0
VALOR6 DC.W ' 6',0
VALOR7 DC.W ' 7',0
VALOR8 DC.W ' 8',0
BOMBA DC.W ' X',0
COPYRIGHT DC.L ' *',0 
BOMBASMARCADAS DC.B 0

NUMEROAL DC.W 0
    ORG $3500
MATRIZMOSTRAR   *(MATRIZCEROS)
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10
    DC.B 10,10,10,10,10,10,10 
    DC.B 10,10,10,10,10,10,10
FINMATRIZ1
    
 ORG $4000

MATRIZALEATORIA DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
                DC.B 0,0,0,0,0,0,0,34
FINMATRIZ

   
    END    START       






































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
