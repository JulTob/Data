#  Práctica 1 — Lonja de Santa Pola  

**Modelo Conceptual (ERE) y Relacional**

## $\text{Julio Toboso}$

### 1. Objetivos.
- **Access** 2016/2019/2021/2024. 
  - Modelización ERE y su correspondiente Relacional,
  - Creación de tablas con sus campos así como la definición de los dominios de los campos y establecimiento de las relaciones.


### 2. Enunciado de la práctica.
La lonja de pescado de Santa Pola desea agilizar la gestión de su negocio a tal efecto, nos solicita proveerlos de una solución de bases de datos. Cada día, los barcos llevan la pesca a la lonja, siendo que allí, se subasta la captura. Normalmente los compradores son pescaderías de la zona. Tras múltiples entrevistas con los usuarios y labores de análisis previo, hemos obtenido las siguientes especificaciones iniciales:

### Lotes
- [x] A la llegada de la captura del día, esta se distribuye en lotes, momento en el que se les asigna un código único.
  - [x] Cada lote consta de
    - [x] un número de cajas
    - [x] de una determinada especie (por ejemplo, pescadilla, boquerones, cangrejos, etc.)
    - [x] así como el número de kilos total
    - [x] y la fecha de llegada.
      
    - [x] Además, es necesario conocer el precio por kilo de salida
    - [x] y el precio total de salida del lote.
         

```mermaid
flowchart LR
  classDef atributo stroke:#088,stroke-width:2px;
  classDef pk stroke:#800,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;
  classDef relacion stroke:#840,stroke-width:2px;

  %% Atributos LOTE
  subgraph Lotes
    Lote[LOTE]:::entidad
    cod_lote([cod_lote]):::pk --> Lote
    num_cajas([num_cajas]):::atributo --> Lote
    kilos_total([kilos_total]):::atributo --> Lote
    fecha_llegada([fecha_llegada]):::atributo --> Lote
    precio_salida_kg([precio_salida_kg]):::atributo --> Lote
    precio_salida_total([precio_salida_total]):::atributo --> Lote
    end
```
```sql
CREATE TABLE LOTE (
    cod_lote            CHAR(5) PRIMARY KEY,
    num_cajas           NUMBER(6,0),
    kilos_totales       NUMBER(8,2),
    fecha_llegada       DATE,
    precio_kg_salida    NUMBER(8,2),
    precio_total_salida NUMBER(8,2),
    cod_especie         VARCHAR(5) REFERENCES ESPECIE,
    matricula_barco     CHAR(10) REFERENCES BARCO
    );
```

### Especies
- [x]  De cada especie guardaremos
  - [x]  cierto código no repetible,
  - [x]  un nombre
  - [x]  y un tipo (por ejemplo, moluscos, pescado blanco, etc.).
```mermaid
flowchart LR   
  classDef atributo stroke:#088,stroke-width:2px;
  classDef pk stroke:#800,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Atributos ESPECIE
  subgraph Especies
    Especie[ESPECIE]:::entidad
    cod_especie([cod_especie]):::pk --> Especie
    nombre_especie([nombre]):::atributo --> Especie
    tipo_especie([tipo]):::atributo --> Especie
    end


```
```sql
CREATE TABLE ESPECIE (
    cod_especie   VARCHAR(5) PRIMARY KEY,
    nombre        VARCHAR(30),
    tipo          VARCHAR(20)
    );
```

### Barcos
- [x]  Se almacenará también información sobre los barcos que entregan la pesca en la lonja
  - [x]  Su matrícula,
  - [x]  nombre,
  - [x]  clase,
  - [x]  nombre del capitán
  - [x]  y así como del armador.
```mermaid
flowchart LR   
  classDef atributo stroke:#088,stroke-width:2px;
  classDef pk stroke:#800,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Atributos BARCO
  subgraph Barcos
  Barco[BARCO]:::entidad
  matricula([matricula]):::pk --> Barco
  nombre([nombre]):::atributo --> Barco
  clase([clase]):::atributo --> Barco
  capitan([capitan]):::atributo --> Barco
  armador([armador]):::atributo --> Barco
  end
```

```sql
CREATE TABLE BARCO (
    matricula     CHAR(10) PRIMARY KEY,
    nombre        VARCHAR(30),
    clase         VARCHAR(20),
    capitan       VARCHAR(30),
    armador       VARCHAR(30)
    );
```

### Caladeros
- [x]  De los caladeros nos interesa conocer
  - [x]  el nombre (único),
  - [x]  su extensión
  - [x]  Ubicación definida mediante las coordenadas GPS
      - [x]  latitud 
      - [x]  longitud.
```mermaid
flowchart LR   
  classDef atributo stroke:#088,stroke-width:2px;
  classDef derivado stroke-width:3px, stroke-dasharray:3 3;
  classDef pk stroke:#800,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Atributos CALADERO
  subgraph Caladeros
    Caladero[CALADERO]:::entidad
    nombre([nombre]):::pk --> Caladero
    ubicacion((ubicacion)):::atributo --> Caladero
      ubicacion:::derivado
      latitud([latitud]):::atributo --> ubicacion
      longitud([longitud]):::atributo --> ubicacion

    end
```
```sql
CREATE TABLE CALADERO (
    nombre        VARCHAR(40) PRIMARY KEY,
    extension     NUMBER(10,2),
    latitud       NUMBER(8,5),
    longitud      NUMBER(8,5)
    );
```

### Faenaje
- [x]  Faena
    - [x]  qué barcos
    - [x]  en qué caladeros
    - [x]  las especies
    - [x]  los kilos de cada especie
    - [x]  y periodo de tiempo de faena representado por
        - [x]  una fecha de inicio
        - [x]  y otra de fin.
```mermaid
flowchart LR   
  classDef atributo stroke:#088,stroke-width:2px;
  classDef derivado stroke-width:3px, stroke-dasharray:3 3;

  classDef pk stroke:#800,stroke-width:4px;
  classDef fk stroke:#080,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Atributos FAENAJE
  subgraph Faenajes
    Faena[FAENA]:::entidad
    Faena --- kg_especie([kg_especie]):::atributo 
    Faena --- nombre([nombre]):::fk 
    Faena --- matricula([matricula]):::fk 
    Faena --- cod_especie([cod_especie]):::fk
    Faena --- periodo((periodo)):::atributo
    periodo:::derivado
    periodo --- fecha_inicio([fecha_inicio]):::atributo 
    periodo --- fecha_fin([fecha_fin]):::atributo

    end
  nombre ---> Caladero
  matricula ---> Barco
  cod_especie ---> Especie

  Caladero[CALADERO]:::entidad
  Barco[BARCO]:::entidad
  Especie[ESPECIE]:::entidad
```
```sql
CREATE TABLE FAENA (
    matricula_barco CHAR(10)   REFERENCES BARCO,
    nombre_caladero VARCHAR(40) REFERENCES CALADERO,
    cod_especie     VARCHAR(5) REFERENCES ESPECIE,
    kilos           NUMBER(8,2),
    fecha_inicio    DATE,
    fecha_fin       DATE,
    PRIMARY KEY (matricula_barco, nombre_caladero, cod_especie, fecha_inicio)
    );
```

# Compradores
- [x]  Compradores.
  - [x]  Código (no repetible),
  - [x]  su nombre,
  - [x]  dirección,
  - [x]  DNI o CIF,
  - [x]  así como la cuota anual que deben pagar a la lonja.


```mermaid
flowchart LR
  classDef atributo stroke:#088,stroke-width:2px;
  classDef derivado stroke-width:3px, stroke-dasharray:3 3;
  classDef pk stroke:#800,stroke-width:4px;
  classDef fk stroke:#080,stroke-width:4px;
  classDef pkfk stroke:#880,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Atributos COMPRADOR
  subgraph Compradores
    Comprador[COMPRADOR]:::entidad
    cod_comprador([cod_comprador]):::pk --> Comprador
    nombre([nombre]):::atributo --> Comprador
    direccion([direccion]):::atributo --> Comprador
    dni_cif([dni_cif]):::atributo --> Comprador
    cuota_anual([cuota_anual]):::atributo --> Comprador
    end

  Comprador --> es{d} -->|1:0..1| CompradorCredito[CREDITOR]:::entidad

```

- [x] Existen compradores que tienen crédito, realizando los pagos al final de cada mes;
  - [x]  Se guarda un número de cuenta bancaria,
  - [x]  el último importe acumulado hasta el momento
  - [x]  y la fecha de vencimiento del pago (sólo nos interesa la mensualidad en curso).
  - [x]  Por otro lado, existen los compradores que realizan los pagos al contado sobre los que no se necesita guardar información adicional.
  - [x]  Un comprador no puede ser de ambos tipos a la vez.

```mermaid
flowchart LR
  classDef atributo stroke:#088,stroke-width:2px;
  classDef derivado stroke-width:3px, stroke-dasharray:3 3;
  classDef pk stroke:#800,stroke-width:4px;
  classDef fk stroke:#080,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;
  classDef pkfk stroke:#880,stroke-width:4px;

  %% Atributos CREDITOR
  subgraph Creditores
    Creditor[CREDITOR]:::entidad
    Creditor --- cod_comprador([cod_comprador]):::pkfk 
    Creditor --- iban([iban]):::atributo
    Creditor --- importe_acumulado([importe_acumulado]):::atributo
    Creditor --- fecha_vencimiento([fecha_vencimiento]):::atributo
    
    end

  cod_comprador--> Comprador
  Comprador:::entidad

```
Diseño:
- Tabla COMPRADOR: todos los compradores, sin distinguir.
- Tabla COMPRADOR_CREDITO: solo los que tienen crédito.
  - cod_comprador = PK y FK a COMPRADOR.
  - Si un comprador está en esta tabla ⇒ es de crédito.
  - Si no está ⇒ es de contado.

Eso se llama especialización por predicado.

Sin tabla para contado. No es necesaria. Ambos grupos son excluyentes. Si está en  _creditor_, no es _contador_.

```sql
CREATE TABLE COMPRADOR (
    cod_comprador CHAR(5) PRIMARY KEY,
    nombre        VARCHAR(40),
    direccion     VARCHAR(60),
    dni_cif       VARCHAR(15) UNIQUE,
    cuota_anual   NUMBER(8,2)
    );

CREATE TABLE CREDITOR (
    cod_comprador     CHAR(5) PRIMARY KEY
                      REFERENCES COMPRADOR,
    iban              CHAR(24),
    importe_acumulado NUMBER(10,2),
    fecha_vencimiento DATE
    );
```

Suponemos que todo comprador que no aparece en COMPRADOR_CREDITO opera al contado.
Por tanto: 
- Cada cod_comprador puede aparecer a lo sumo una vez en COMPRADOR_CREDITO (PK).
- Si aparece: es crédito.
- No hay forma de que también sea de otro tipo, porque no hay otra subtabla.
- Disjunto garantizado.
- No hay basura ni nulos forzados.
- Contado = los que no están en COMPRADOR_CREDITO
  -   Totalidad cubierta, sin necesidad de un atributo tipo

Un IBAN es un número de cuenta, pero contiene caracteres no numéricos (ES, FR, US...). Considero mejor guardarla como un CHAR de 24 caracteres. Se requerirá verificación. 















### Adjudicación
Finalmente, cada lote será adquirido por el comprador que realice la mejor puja. 

- [ ] Adjudicacion 
  - [x] el precio de compra por kilo
  - [x] el precio total de adjudicación del lote.
  - [x] Cada lote será adquirido por __un__ comprador.
  - [x] Un comprador puede adquirir varios lotes

```mermaid
flowchart LR
  classDef entidad stroke:#404,stroke-width:4px;
  classDef relacion stroke:#840,stroke-width:2px;
  classDef atributo stroke:#088,stroke-width:2px;

  Lote[LOTE]:::entidad
  Comprador[COMPRADOR]:::entidad
  Adjudicacion{ADJUDICACIÓN}:::relacion

  precio_kg([precio_compra_kg]):::atributo --> Adjudicacion
  precio_total([precio_total]):::atributo --> Adjudicacion

  Lote ---|"(1,1)"| Adjudicacion
  Adjudicacion ---|"(0,N)"| Comprador

```
```sql
CREATE TABLE ADQUISICION (
    cod_lote           CHAR(5) PRIMARY KEY
                       REFERENCES LOTE,
    cod_comprador      CHAR(5) NOT NULL
                       REFERENCES COMPRADOR,
    precio_kg_compra   NUMBER(8,2),
    precio_total_compra NUMBER(8,2)
);
```
`cod_lote` es PK porque cada lote solo puede venderse una vez. Cada Lote tiene una Adjudicación exacta.

`cod_comprador` es NOT NULL porque cada lote debe adjudicarse a alguien. Si no se adjudica, no se añade a la tabla. 


Si se modelara la subasta completa, esta tabla sería resultado de esa relación. Dentro de la dinámica de 'minimizar a lo necesario', no creo que sea rentable a largo plazo guardar todas las pujas en una base de datos a la larga, ya que su relevancia se esfuma en el momento de la adjudicación. 

Esta decisión debería ser secundada por el cliente. Si les interesa hacer este registro, con el coste asociado en memoria y trabajo, se puede implementar una tabla que tendría parametros adecuados (cod_lote, cod_comprador, puja) para seleccionar una puja ganadora. 










## FACTURAS


- [ ] Facturas de Pagos que efectúan los compradores por la adquisición de los lotes.
  - [ ] Cada factura corresponde a un comprador.
  - [ ] Una factura puede incluir uno o varios lotes.
  - [ ] Número de factura
  - [ ] Fecha de emisión
  - [ ] Importe total.
  - [ ] Estado (pendiente o pagada).
  - [ ] Cada lote debe estar en exactamente una factura.
  - [ ] Un comprador puede tener muchas facturas.
```mermaid
flowchart LR
  classDef entidad stroke:#404,stroke-width:4px;
  classDef relacion stroke:#840,stroke-width:2px;
  classDef atributo stroke:#088,stroke-width:2px;

  Comprador[COMPRADOR]:::entidad
  Factura[FACTURA_COMPRADOR]:::entidad
  Lote[LOTE]:::entidad
  Incluye{INCLUYE}:::relacion

  num_fact([num_factura]):::atributo --> Factura
  fecha_emision([fecha_emision]):::atributo --> Factura
  importe_total([importe_total]):::atributo --> Factura
  estado([pagada]):::atributo --> Factura

  Factura ---|"(1,N)"| Incluye
  Incluye ---|"(1,1)"| Lote

  Comprador ---|"(1,N)"| Factura

```

```sql
CREATE TABLE FACTURA_COMPRADOR (
    num_factura      	CHAR(10) PRIMARY KEY,
    cod_comprador    	CHAR(5) NOT NULL REFERENCES COMPRADOR,
    fecha_emision    	DATE NOT NULL,
    importe_total    	NUMBER(10,2),
    pagada           	NUMBER(1,0) DEFAULT 0
			-- 0 = pendiente, 1 = pagada
);

CREATE TABLE INCLUYE (
    num_factura   CHAR(10) REFERENCES FACTURA_COMPRADOR,
    cod_lote      CHAR(5)  REFERENCES LOTE,
    PRIMARY KEY (num_factura, cod_lote)
);

```
- INCLUYE es la relación N:M.
- PRIMARY KEY (num_factura, cod_lote) impide repetir un lote en la misma factura.

Estado Pagada: 
- 0 = pendiente
- 1 = pagada
- `DEFAULT 0` asegura que todas las facturas nuevas comiencen como pendientes.
- Este campo actúa como booleano (0 = pendiente, 1 = pagada).
  
Cada comprador puede emitir varias facturas; cada factura agrupa varios lotes.

Cada lote pertenece a una única factura (por post-adjudicación).

```mermaid
flowchart LR
  classDef entidad stroke:#404,stroke-width:4px;
  classDef relacion stroke:#840,stroke-width:2px;
  classDef atributo stroke:#088,stroke-width:2px;

  Factura[FACTURA_COMPRADOR]:::entidad
  Pago[PAGO_COMPRADOR]:::entidad
  Rel{PAGA}:::relacion

  id_pago((id_pago)):::atributo --> Pago
  fecha((fecha)):::atributo --> Pago
  importe((importe)):::atributo --> Pago

   Pago ---|"(1,1)"| Rel
  Rel ---|"(1,N)"| Factura

```

```sql
CREATE TABLE PAGO_COMPRADOR (
    cod_pago      CHAR(5) PRIMARY KEY,
    num_factura   CHAR(10) REFERENCES FACTURA_COMPRADOR,
    fecha         DATE,
    importe       NUMBER(10,2)
);
```

Una factura pertenece a un único comprador, pero puede incluir varios lotes adquiridos.

Cada lote adjudicado debe aparecer en exactamente una factura.

- [ ] pagos que realiza la lonja a los barcos que entregan la
pesca diaria
- [ ] En las facturas emitidas por los barcos,
- [ ] la lonja almacena además de los datos mencionados de la factura,
- [ ] el CIF del barco
- [ ] y los códigos de lote facturados.

- [ ] Los lotes se subastan.
- [ ] Queremos saber  **qué barco capturó cada lote**,
- [ ] Los barcos pueden capturar las especies que componen los lotes
- [ ] Los barcos pueden faenar en diferentes caladeros.

### 3.1. Modelo ERE.
A partir de la información descrita en al anterior apartado realizar el diseño del esquema conceptual (ERE) utilizando Microsoft Word o similar para documentarlo. Dicho documento, además de contar con el grafo ERE ajustado a los elementos impartidos en clase, ha de contar con un apartado que indique, razonadamente, todos los supuestos semánticos que se han realizado, y que surgen de la ausencia de información relativa en ellos en el propio enunciado.
En definitiva, se trata de incluir, además de los supuestos semánticos que se consideren oportunos para justificar todas las decisiones de diseño y la semántica perdida si la hubiese, los siguientes elementos:
- Entidades.
- Interrelaciones (Relaciones).
- Tipo de Interrelaciones (Tipo de Relación).
- Participación de las entidades en las Interrelaciones.
- Participaciones máximas y mínimas de las entidades en las Interrelaciones.
- Respecto a las relaciones, existe una relación ternaria que el alumno debe identificar.
De igual manera se debe identificar la cardinalidad de cada rama, así como las
participaciones máximas y mínimas.
- Atributos según tipología.
- Generalización – Especialización.
- … en definitiva todos los elementos explicados para los esquemas ERE necesarios para
reflejar el enunciado los más fielmente posible.

### 3.2. Modelo Relacional.
Basándose en el esquema conceptual (Modelo ERE) desarrollado en el anterior apartado
se deberá crear el Modelo Relacional, el cual reflejará lo más fielmente posible una solución al
problema que se nos plantea. Éste se ha de documentar utilizando la herramienta Microsoft Visio
usando la plantilla para Bases de Datos relacionales con notaciones IDEF1X haciendo constar,
los siguientes elementos:
- Tablas con sus atributos o campos y sus dominios.
- Claves Primarias y Alternativas.
- Claves Ajenas indicando su dependencia.
- Los posibles o no nulos.
- Valores por defecto.
- Cardinalidades.
- Acción para la preservación de la Integridad Referencial.
- … en definitiva, todos los elementos explicados para los esquemas relacionales que sean necesarios para plasmar el enunciado.
- 
Solo se podrán usar los siguientes tipos de datos:
- VARCHAR,
- CHAR,
- NUMBER
- y DATE.

Recordad que es importante que el tipo de dato, y en general el dominio de cada atributo, esté desarrollado conforme al concepto que representa.

La forma de transformar una relación ternaria del tipo Muchos, Muchos, Muchos (N:N:N) es, una vez creadas las tablas correspondientes a las entidades partícipes, crear una nueva tabla que representará dicha relación ternaria y que debe incluir como claves foráneas las claves principales de cada una de las tres entidades partícipes. El conjunto formado por estas claves foráneas será la clave principal de la nueva tabla. En dicha nueva tabla se debe incluir también los atributos de la relación siguiendo los mismos criterios que se siguen en los atributos de una relación binaria de tipo N:N.

### 3.3. Creación de la base de datos.
En consonancia con lo desarrollado en el anterior apartado, construid el definitivo esquema de base de datos relacional en Access.

### 4. Formato y fecha de entrega
Esta práctica se entregará de forma individual. El plazo máximo para la entrega de esta práctica es el 05/11/2025 a las 23:55 horas a través del portal de entrega de tareas de la asignatura
del acceso identificado de la UMH.

Se entregará un fichero comprimido en formato .zip o .rar cuyo contenido ha de ser:

a) Un documento de Word o pdf con la siguiente información:

1. DNI, Nombre y Apellidos del Alumno.
2. Diseño Conceptual incluyendo los supuestos semánticos y la semántica
perdida.
   1. El fichero Microsoft Visio con el diseño del modelo relacional.
   2. Las base de datos de Access que se construya a partir del modelo relacional.
   
# Diagrama



```mermaid
flowchart LR   
  classDef atributo stroke:#088,stroke-width:2px;
  classDef pk stroke:#800,stroke-width:4px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Atributos FACTURA_COMPRADOR
  subgraph Facturas
  num_fact_c([num_factura PK]):::atributo --> FacturaC
  fecha_emision_c([fecha_emision]):::atributo --> FacturaC
  importe_total_c([importe_total]):::atributo --> FacturaC
  estado_c([estado]):::atributo --> FacturaC
  end
```
```mermaid
flowchart LR   

  classDef relacion stroke:#840,stroke-width:2px;
  classDef atributo stroke:#088,stroke-width:2px;
  classDef entidad stroke:#404,stroke-width:4px;

  %% Entidades
  Lote[LOTE]:::entidad
  Especie[ESPECIE]:::entidad
  Barco[BARCO]:::entidad
  Comprador[COMPRADOR]:::entidad
  FacturaC[FACTURA_COMPRADOR]:::entidad

  %% Relaciones
  DeEspecie{DE_ESPECIE}:::relacion
  CapturadoPor{CAPTURADO_POR}:::relacion
  Adjudicacion{ADJUDICACIÓN}:::relacion
  EmiteC{EMITIDA_A}:::relacion
  IncluyeLC{INCLUYE_LOTES}:::relacion




  %% Atributos de la RELACIÓN ADJUDICACIÓN
  precio_compra_kg([precio_compra_kg]):::atributo --> Adjudicacion
  precio_total([precio_total]):::atributo --> Adjudicacion

  %% Conexiones y cardinalidades
  Lote ---|"(1,1)"| DeEspecie
  DeEspecie ---|"(0,N)"| Especie

  Lote ---|"(1,1)"| CapturadoPor
  CapturadoPor ---|"(1,N)"| Barco

  Lote ---|"(1,1)"| Adjudicacion
  Adjudicacion ---|"(0,N)"| Comprador

  FacturaC ---|"(1,1)"| EmiteC
  EmiteC ---|"(1,N)"| Comprador

  FacturaC ---|"(1,N)"| IncluyeLC
  IncluyeLC ---|"(1,1)"| Lote

```
# Relacional
```mermaid
---
title: LONJA - Julio Toboso
---
erDiagram
    direction LR

    %%===--- ENTIDADES PRINCIPALES ---===%%

    COMPRADOR {
        CHAR    cod_comprador PK
        VARCHAR nombre
        VARCHAR direccion
        VARCHAR dni_cif
        NUMBER  cuota_anual
    }

    COMPRADOR_CREDITO {
        CHAR    cod_comprador PK  "FK a COMPRADOR"
        VARCHAR num_cuenta
        NUMBER  importe_acumulado
        DATE    fecha_vencimiento
    }

    COMPRADOR ||--o| COMPRADOR_CREDITO : "tiene_credito"


    ESPECIE {
        ID     cod_especie  PK      "ShortText(5)"
        STRING nombre       UK      "ShortText(30) Único"
        STRING tipo                 "ShortText(20)"
        }

    CALADERO {
        STRING    nombre     PK   "ShortText(40)"
        FLOAT     extension       ""
        GEO       latitud         "DOUBLE"
        GEO       longitud        "DOUBLE"
        }

    BARCO {
        ID     matricula PK  "ShortText(10)"
        STRING nombre    UK  "ShortText(30)"
        STRING clase         "ShortText(20)"
        STRING capitan       "ShortText(30)"
        STRING armador   UK  "ShortText(30)"
        CIF    cif_barco UK  "ShortText(15) Único"
        }



    %% ======== LOTES Y SUBASTAS ======== %%
    LOTE {
        ID          cod_lote      PK    ""
        INT         num_cajas           ""
        FLOAT       kilos_total         ""
        DATE        fecha_llegada       ""
        CURRENCY    precio_salida_kg    ""
        CURRENCY    precio_salida_total "Derivado"
        CURRENCY    precio_compra_kg    ""
        CURRENCY    precio_total        "Derivado"
        ID          cod_especie   FK    "ESPECIE"  
        ID          matricula     FK    "BARCO" 
        ID          cod_comprador FK    "COMPRADOR"  
        ID          num_factura_c FK    "FACTURA_COMPRADOR - STRING"  
        ID          num_factura_b FK    "FACTURA_BARCO - STRING"  
        }

    %% ======== FAENA (RELACIÓN TERNARIA) ======== %%
    FAENA {
        ID         id_faena            PK     "AUTONUM"
        ID         matricula           PK, FK     "BARCO"  
        ID         cod_especie         PK, FK     "ESPECIE"  
        STRING     nombre_caladero     PK, FK     "CALADERO"  
        FLOAT      kilos                      ""
        DATE       fecha_inicio               ""
        DATE       fecha_fin                  "fecha_fin >= fecha_inicio"
        }

    %% ======== FACTURAS Y PAGOS ======== %%
    FACTURA_COMPRADOR {
        STRING     num_factura     PK    "ShortText(20)"
        DATE       fecha_emision         ""
        MONEY      importe_total         ""
        BOOL       estado                "Pendiente(0) o pagada(1)"
        ID         cod_comprador   FK    "COMPRADOR" 
        }

    PAGO_COMPRADOR {
        ID          id_pago     PK     "AUTONUM"
        DATE        fecha              ""
        CURRENCY    importe            ""
        STRING      num_factura FK     "FACTURA_COMPRADOR" 
        }

    FACTURA_BARCO {
        STRING   num_factura   PK   "ShortText(20)"
        DATE     fecha_emision      ""
        CURRENCY importe_total      ""
        CIF      cif_barco     FK   ""
        ID       matricula     FK   "BARCO"  
        }

    PAGO_BARCO {
        INT        id_pago PK      "AUTONUM"
        DATE       fecha           ""
        CURRENCY   importe         ""
        STRING     num_factura FK  "FACTURA_BARCO" 
    }

    %% ======== RELACIONES Y CARDINALIDADES ======== %%

    %% --- Compradores --- %%
    COMPRADOR ||--o{ LOTE : "adjudica"
    COMPRADOR ||--o{ FACTURA_COMPRADOR : "recibe"
    FACTURA_COMPRADOR ||--o{ PAGO_COMPRADOR : "pagos"

    %% --- Barcos --- %%
    BARCO   ||--o{ FAENA : "realiza"
    BARCO   ||--o{ LOTE : "captura"
    BARCO   ||--o{ FACTURA_BARCO : "emite"
    FACTURA_BARCO ||--o{ PAGO_BARCO : "pagos"

    %% --- Especies y Caladeros --- %%
    ESPECIE   ||--o{ LOTE : "clasifica"
    ESPECIE   ||--o{ FAENA : "objetivo"
    CALADERO  ||--o{ FAENA : "en"

    %% --- Facturas y Lotes --- %%
    FACTURA_COMPRADOR ||--o{ LOTE : "incluye"
    FACTURA_BARCO     ||--o{ LOTE : "incluye"

    %% --- Estilo visual --- %%
    style COMPRADOR_CONTADO stroke:#2962FF,stroke-width:2px
    style COMPRADOR_CREDITO stroke:#2962FF,stroke-width:2px
    style COMPRADOR stroke:#2962FF,stroke-width:4px
    style FAENA stroke:#FF9800,stroke-width:2px


```
# Notas:
- Los tipos ID son aliases para lo que seguramente debería ser un STRING, pero que representa un código único que bien podría ser un INT o POSITIVE.
- GEO es un alias para el tipo que se utilice para coordenadas.

# Implementación 
```sql
CREATE TABLE ADQUISICION (
    cod_lote           CHAR(5) REFERENCES LOTE,
    cod_comprador      CHAR(5) REFERENCES COMPRADOR,
    precio_kg_compra   NUMBER(8,2),
    precio_total_compra NUMBER(8,2),
    PRIMARY KEY (cod_lote, cod_comprador)
);

CREATE TABLE PAGO_BARCO (
    cod_pago        CHAR(5) PRIMARY KEY,
    matricula_barco CHAR(10) REFERENCES BARCO,
    importe         NUMBER(8,2),
    fecha           DATE
);

CREATE TABLE PAGO_COMPRADOR (
    cod_pago      CHAR(5) PRIMARY KEY,
    cod_comprador CHAR(5) REFERENCES COMPRADOR,
    importe       NUMBER(8,2),
    fecha         DATE
);


```
