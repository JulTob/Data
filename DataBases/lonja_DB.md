```mermaid
---
title: LONJA - Julio Toboso
---
erDiagram
    direction LR

    %% ======== ENTIDADES PRINCIPALES ======== %%
    ESPECIE {
        string cod_especie PK  
        string nombre       "Nombre común"
        string tipo         "Tipo de especie (molusco, pescado blanco...)"
    }

    CALADERO {
        string nombre PK "Nombre único del caladero"
        float extension   "Área en km²"
        float latitud     "Latitud GPS"
        float longitud    "Longitud GPS"
    }

    BARCO {
        string matricula PK "Identificador del barco"
        string nombre        "Nombre del barco"
        string clase         "Clase o tipo del barco"
        string capitan       "Nombre del capitán"
        string armador       "Nombre del armador"
        string cif_barco UK  "Identificador fiscal del barco"
    }

    COMPRADOR {
        string cod_comprador PK "Código del comprador"
        string nombre          "Nombre o razón social"
        string direccion       "Dirección postal"
        string dni_cif UK      "DNI o CIF"
        float cuota_anual      "Cuota anual a la lonja"
    }

    %% ======== ESPECIALIZACIÓN DE COMPRADORES ======== %%
    COMPRADOR_CONTADO {
        string cod_comprador PK, FK "COMPRADOR" 
    }

    COMPRADOR_CREDITO {
        string cod_comprador PK, FK "COMPRADOR" 
        string num_cuenta          "Cuenta bancaria"
        float importe_acumulado    "Importe acumulado del mes"
        date fecha_vencimiento     "Fecha límite de pago"
    }

    %% ======== LOTES Y SUBASTAS ======== %%
    LOTE {
        string cod_lote PK "Código del lote"
        int num_cajas           "Número de cajas"
        float kilos_total       "Peso total (kg)"
        date fecha_llegada      "Fecha de llegada"
        float precio_salida_kg  "Precio de salida por kg"
        float precio_salida_total "Precio total de salida"
        float precio_compra_kg  "Precio adjudicado por kg"
        float precio_total      "Precio total adjudicado"
        string cod_especie FK    "ESPECIE"  
        string matricula FK "BARCO" "Barco que capturó el lote"
        string cod_comprador FK "COMPRADOR"  
        string num_factura_c FK "FACTURA_COMPRADOR"  
        string num_factura_b FK "FACTURA_BARCO"  
    }

    %% ======== FAENA (RELACIÓN TERNARIA) ======== %%
    FAENA {
        int id_faena PK "Identificador de la faena"
        string matricula FK "BARCO" "Barco que faena"
        string cod_especie FK "ESPECIE" "Especie capturada"
        string nombre_caladero FK "CALADERO" "Lugar de captura"
        float kilos "Cantidad capturada"
        date fecha_inicio "Inicio de la faena"
        date fecha_fin "Fin de la faena"
    }

    %% ======== FACTURAS Y PAGOS ======== %%
    FACTURA_COMPRADOR {
        string num_factura PK "Número de factura"
        date fecha_emision "Fecha de emisión"
        float importe_total "Importe total"
        string estado "Pendiente o pagada"
        string cod_comprador FK "COMPRADOR" "Comprador asociado"
    }

    PAGO_COMPRADOR {
        int id_pago PK "Identificador del pago"
        date fecha "Fecha del pago"
        float importe "Importe del pago"
        string num_factura FK "FACTURA_COMPRADOR" "Factura abonada"
    }

    FACTURA_BARCO {
        string num_factura PK "Número de factura"
        date fecha_emision "Fecha de emisión"
        float importe_total "Importe total"
        string cif_barco "CIF del barco"
        string matricula FK "BARCO" "Barco asociado"
    }

    PAGO_BARCO {
        int id_pago PK "Identificador del pago"
        date fecha "Fecha del pago"
        float importe "Importe del pago"
        string num_factura FK "FACTURA_BARCO" "Factura pagada"
    }

    %% ======== RELACIONES Y CARDINALIDADES ======== %%

    %% --- Compradores --- %%
    COMPRADOR ||--|| COMPRADOR_CONTADO : "es"
    COMPRADOR ||--|| COMPRADOR_CREDITO : "es"
    COMPRADOR ||--o{ LOTE : "adjudica"
    COMPRADOR ||--o{ FACTURA_COMPRADOR : "recibe"
    FACTURA_COMPRADOR ||--o{ PAGO_COMPRADOR : "pagos"

    %% --- Barcos --- %%
    BARCO ||--o{ FAENA : "realiza"
    BARCO ||--o{ LOTE : "captura"
    BARCO ||--o{ FACTURA_BARCO : "emite"
    FACTURA_BARCO ||--o{ PAGO_BARCO : "pagos"

    %% --- Especies y Caladeros --- %%
    ESPECIE ||--o{ LOTE : "clasifica"
    ESPECIE ||--o{ FAENA : "objetivo"
    CALADERO ||--o{ FAENA : "en"

    %% --- Facturas y Lotes --- %%
    FACTURA_COMPRADOR ||--o{ LOTE : "incluye"
    FACTURA_BARCO ||--o{ LOTE : "incluye"

    %% --- Estilo visual --- %%
    style COMPRADOR_CONTADO stroke:#2962FF,stroke-width:2px
    style COMPRADOR_CREDITO stroke:#2962FF,stroke-width:2px
    style FAENA stroke:#FF9800,stroke-width:2px


```
