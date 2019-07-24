/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     23/07/2019 7:49:01 p. m.                     */
/*==============================================================*/


alter table BARRIO
   drop constraint FK_BARRIO_SECOMPONE_CIUDAD;

alter table COMENTARIO
   drop constraint FK_COMENTAR_REL_COM_C_PERSONA;

alter table COMPRA
   drop constraint FK_COMPRA_REL_COM_I_INMUEBLE;

alter table INMUEBLE
   drop constraint FK_INMUEBLE_REL_BAR_I_BARRIO;

alter table PROCESOS_DERECHOS_INMUEBLE
   drop constraint FK_PROCESOS_REL_PRO_I_INMUEBLE;

alter table REL_COMI_INM
   drop constraint FK_REL_COMI_REL_COMI__PERSONA;

alter table REL_COMI_INM
   drop constraint FK_REL_COMI_REL_COMI__INMUEBLE;

alter table REQUERIMIENTO
   drop constraint FK_REQUERIM_REL_REQ_C_PERSONA;

alter table SERVICIO_A_PAGAR
   drop constraint FK_SERVICIO_REL_ADM_S_PERSONA;

alter table SERVICIO_A_PAGAR
   drop constraint FK_SERVICIO_REL_SER_I_INMUEBLE;

alter table VALOR_ZONA
   drop constraint FK_VALOR_ZO_REL_VAL_B_BARRIO;

alter table VENTA
   drop constraint FK_VENTA_REL_VEN_I_INMUEBLE;

drop table BARRIO cascade constraints;

drop table CIUDAD cascade constraints;

drop table CLIENTE cascade constraints;

drop table COMENTARIO cascade constraints;

drop table COMPRA cascade constraints;

drop table INMUEBLE cascade constraints;

drop table PERSONA cascade constraints;

drop table PROCESOS_DERECHOS_INMUEBLE cascade constraints;

drop table REL_COMI_INM cascade constraints;

drop table REQUERIMIENTO cascade constraints;

drop table SERVICIO_A_PAGAR cascade constraints;

drop table VALOR_ZONA cascade constraints;

drop table VENTA cascade constraints;

/*==============================================================*/
/* Table: BARRIO                                                */
/*==============================================================*/
create table BARRIO (
   ID_BARRIO            INTEGER               not null
      constraint CKC_ID_BARRIO_BARRIO check (ID_BARRIO >= 1),
   ID_CIUDAD            SMALLINT              not null
      constraint CKC_ID_CIUDAD_BARRIO check (ID_CIUDAD >= 1),
   NOMBRE_BARRIO        CHAR(60)              not null,
   ESTRATO              SMALLINT              not null
      constraint CKC_ESTRATO_BARRIO check (ESTRATO between 1 and 8),
   constraint PK_BARRIO primary key (ID_BARRIO)
);

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table CIUDAD (
   ID_CIUDAD            INTEGER               not null,
   NOMBRE_CIUDAD        CHAR(100)             not null,
   constraint PK_CIUDAD primary key (ID_CIUDAD)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_PERSONA           INTEGER               not null
      constraint CKC_ID_PERSONA_CLIENTE check (ID_PERSONA >= 1),
   NOMBRE               CHAR(50)              not null,
   EMAIL                CHAR(40),
   CALIFICACION_CLIENTE NUMBER(5)            default 0  not null
      constraint CKC_CALIFICACION_CLIE_CLIENTE check (CALIFICACION_CLIENTE between 1 and 5),
   EXPERIENCIA          CHAR(200),
   CONTRASENA           CHAR(50),
   constraint PK_CLIENTE primary key (ID_PERSONA)
);

/*==============================================================*/
/* Table: COMENTARIO                                            */
/*==============================================================*/
create table COMENTARIO (
   ID_COMENTARIO        INTEGER               not null
      constraint CKC_ID_COMENTARIO_COMENTAR check (ID_COMENTARIO >= 1),
   COMENTARIO           CHAR(256)                  not null,
   ID_PERSONA           INTEGER               not null
      constraint CKC_ID_PERSONA_COMENTAR check (ID_PERSONA >= 1),
   constraint PK_COMENTARIO primary key (ID_COMENTARIO)
);

/*==============================================================*/
/* Table: COMPRA                                                */
/*==============================================================*/
create table COMPRA (
   ID_COMPRA            INTEGER               not null
      constraint CKC_ID_COMPRA_COMPRA check (ID_COMPRA >= 1),
   ID_INMUEBLE          INTEGER               not null,
   FECHA_COMPRA         DATE                  not null,
   constraint PK_COMPRA primary key (ID_COMPRA)
);

/*==============================================================*/
/* Table: INMUEBLE                                              */
/*==============================================================*/
create table INMUEBLE (
   ID_INMUEBLE          INTEGER               not null
      constraint CKC_ID_INMUEBLE_INMUEBLE check (ID_INMUEBLE >= 1),
   TIPO_INMUEBLE        CHAR(1)               not null
      constraint CKC_TIPO_INMUEBLE_INMUEBLE check (TIPO_INMUEBLE in ('1','2','3','4')),
   VALOR_INMUEBLE       FLOAT                 not null
      constraint CKC_VALOR_INMUEBLE_INMUEBLE check (VALOR_INMUEBLE >= 0),
   ZONA_INMUEBLE        CHAR(10)              not null,
   DIMENSION_INMUEBLE   FLOAT                 not null,
   CALLE                CHAR(5),
   TRANSVERSAL          CHAR(20),
   DIAGONAL             CHAR(20),
   CARRERA              CHAR(5),
   NUMERO_CASA          CHAR(256),
   DESCRIPCION_INMUEBLE CHAR(256)             not null,
   ESTADO_INMUEBLE      CHAR(1)               not null
      constraint CKC_ESTADO_INMUEBLE_INMUEBLE check (ESTADO_INMUEBLE in ('1','2','3','4')),
   ID_BARRIO            INTEGER               not null
      constraint CKC_ID_BARRIO_INMUEBLE check (ID_BARRIO >= 1),
   NUMERO_PISOS         INTEGER             
      constraint CKC_NUMERO_PISOS_INMUEBLE check (NUMERO_PISOS is null or (NUMERO_PISOS >= 1)),
   NOMBRE_CONJUNTO      CHAR(100),
   NUMERO_APTO          INTEGER,
   LICENCIA             CHAR(100),
   RENSTRICCIONES_CONSTRUCCION CHAR(256),
   MATRICULA_INMOBILIARIA CHAR(256),
   VIA                  CHAR(256),
   KILOMERO             SMALLINT,
   constraint PK_INMUEBLE primary key (ID_INMUEBLE)
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA (
   ID_PERSONA           INTEGER               not null
      constraint CKC_ID_PERSONA_PERSONA check (ID_PERSONA >= 1),
   TIPO_PERSONA         CHAR(1)               not null
      constraint CKC_TIPO_PERSONA_PERSONA check (TIPO_PERSONA in ('1','2','3')),
   NOMBRE               CHAR(50)              not null,
   EMAIL                CHAR(40)              not null,
   VR_COMISION          FLOAT(8)            
      constraint CKC_VR_COMISION_PERSONA check (VR_COMISION is null or (VR_COMISION >= 0)),
   CALIFICACION_CLIENTE NUMBER(5)           
      constraint CKC_CALIFICACION_CLIE_PERSONA check (CALIFICACION_CLIENTE is null or (CALIFICACION_CLIENTE between 1 and 5)),
   EXPERIENCIA          CHAR(100),
   CONTRASENA           CHAR(200),
   PRIVILEGIOS          CHAR(256),
   CONTRASENA_ADMIN     CHAR(50),
   constraint PK_PERSONA primary key (ID_PERSONA)
);

/*==============================================================*/
/* Table: PROCESOS_DERECHOS_INMUEBLE                            */
/*==============================================================*/
create table PROCESOS_DERECHOS_INMUEBLE (
   ID_DERECHOS          INTEGER               not null
      constraint CKC_ID_DERECHOS_PROCESOS check (ID_DERECHOS >= 1),
   ID_INMUEBLE          INTEGER               not null,
   FECHA_ADQUISICION    DATE                  not null,
   constraint PK_PROCESOS_DERECHOS_INMUEBLE primary key (ID_DERECHOS)
);

/*==============================================================*/
/* Table: REL_COMI_INM                                          */
/*==============================================================*/
create table REL_COMI_INM (
   ID_PERSONA           INTEGER               not null
      constraint CKC_ID_PERSONA_REL_COMI check (ID_PERSONA >= 1),
   ID_INMUEBLE          INTEGER               not null
      constraint CKC_ID_INMUEBLE_REL_COMI check (ID_INMUEBLE >= 1),
   constraint PK_REL_COMI_INM primary key (ID_PERSONA, ID_INMUEBLE)
);

/*==============================================================*/
/* Table: REQUERIMIENTO                                         */
/*==============================================================*/
create table REQUERIMIENTO (
   ID_REQUERIMIENTO     INTEGER               not null
      constraint CKC_ID_REQUERIMIENTO_REQUERIM check (ID_REQUERIMIENTO >= 1),
   R_DIMENSION_INMUEBLE FLOAT                 not null,
   R_VALOR_MAX_INMUEBLE INTEGER               not null
      constraint CKC_R_VALOR_MAX_INMUE_REQUERIM check (R_VALOR_MAX_INMUEBLE >= 0),
   R_ZONA_INMUEBLE      CHAR(100)             not null,
   R_NUMERO_HABITACIONES SMALLINT            
      constraint CKC_R_NUMERO_HABITACI_REQUERIM check (R_NUMERO_HABITACIONES is null or (R_NUMERO_HABITACIONES >= 1)),
   R_TIPO_INMUEBLE      CHAR(1)             
      constraint CKC_R_TIPO_INMUEBLE_REQUERIM check (R_TIPO_INMUEBLE is null or (R_TIPO_INMUEBLE in ('1','2','3','4'))),
   R_NUMERO_PISOS       SMALLINT            
      constraint CKC_R_NUMERO_PISOS_REQUERIM check (R_NUMERO_PISOS is null or (R_NUMERO_PISOS >= 1)),
   ID_PERSONA           INTEGER               not null,
   constraint PK_REQUERIMIENTO primary key (ID_REQUERIMIENTO)
);

/*==============================================================*/
/* Table: SERVICIO_A_PAGAR                                      */
/*==============================================================*/
create table SERVICIO_A_PAGAR (
   ID_FACTURA           INTEGER               not null
      constraint CKC_ID_FACTURA_SERVICIO check (ID_FACTURA >= 1),
   ID_INMUEBLE          INTEGER               not null
      constraint CKC_ID_INMUEBLE_SERVICIO check (ID_INMUEBLE >= 1),
   ID_PERSONA           INTEGER             
      constraint CKC_ID_PERSONA_SERVICIO check (ID_PERSONA is null or (ID_PERSONA >= 1)),
   FECHA_A_PAGAR        DATE                  not null,
   FECHA_VENCIMIENTO    DATE                  not null,
   TIPO_RECIBO          CHAR(1)               not null
      constraint CKC_TIPO_RECIBO_SERVICIO check (TIPO_RECIBO in ('1','2','3')),
   VALOR_A_PAGAR        INTEGER               not null
      constraint CKC_VALOR_A_PAGAR_SERVICIO check (VALOR_A_PAGAR >= 0),
   constraint PK_SERVICIO_A_PAGAR primary key (ID_FACTURA)
);

/*==============================================================*/
/* Table: VALOR_ZONA                                            */
/*==============================================================*/
create table VALOR_ZONA (
   ID_ZONA              INTEGER               not null
      constraint CKC_ID_ZONA_VALOR_ZO check (ID_ZONA >= 1),
   ID_BARRIO            INTEGER               not null
      constraint CKC_ID_BARRIO_VALOR_ZO check (ID_BARRIO >= 1),
   VALOR_METRO_CUADRADO INTEGER               not null
      constraint CKC_VALOR_METRO_CUADR_VALOR_ZO check (VALOR_METRO_CUADRADO >= 0),
   constraint PK_VALOR_ZONA primary key (ID_ZONA)
);

/*==============================================================*/
/* Table: VENTA                                                 */
/*==============================================================*/
create table VENTA (
   ID_VENTA             INTEGER               not null
      constraint CKC_ID_VENTA_VENTA check (ID_VENTA >= 1),
   ID_INMUEBLE          INTEGER               not null,
   FECHA_VENTA          DATE                  not null,
   constraint PK_VENTA primary key (ID_VENTA)
);

alter table BARRIO
   add constraint FK_BARRIO_SECOMPONE_CIUDAD foreign key (ID_CIUDAD)
      references CIUDAD (ID_CIUDAD);

alter table COMENTARIO
   add constraint FK_COMENTAR_REL_COM_C_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA);

alter table COMPRA
   add constraint FK_COMPRA_REL_COM_I_INMUEBLE foreign key (ID_INMUEBLE)
      references INMUEBLE (ID_INMUEBLE);

alter table INMUEBLE
   add constraint FK_INMUEBLE_REL_BAR_I_BARRIO foreign key (ID_BARRIO)
      references BARRIO (ID_BARRIO);

alter table PROCESOS_DERECHOS_INMUEBLE
   add constraint FK_PROCESOS_REL_PRO_I_INMUEBLE foreign key (ID_INMUEBLE)
      references INMUEBLE (ID_INMUEBLE);

alter table REL_COMI_INM
   add constraint FK_REL_COMI_REL_COMI__PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA);

alter table REL_COMI_INM
   add constraint FK_REL_COMI_REL_COMI__INMUEBLE foreign key (ID_INMUEBLE)
      references INMUEBLE (ID_INMUEBLE);

alter table REQUERIMIENTO
   add constraint FK_REQUERIM_REL_REQ_C_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA);

alter table SERVICIO_A_PAGAR
   add constraint FK_SERVICIO_REL_ADM_S_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA);

alter table SERVICIO_A_PAGAR
   add constraint FK_SERVICIO_REL_SER_I_INMUEBLE foreign key (ID_INMUEBLE)
      references INMUEBLE (ID_INMUEBLE);

alter table VALOR_ZONA
   add constraint FK_VALOR_ZO_REL_VAL_B_BARRIO foreign key (ID_BARRIO)
      references BARRIO (ID_BARRIO);

alter table VENTA
   add constraint FK_VENTA_REL_VEN_I_INMUEBLE foreign key (ID_INMUEBLE)
      references INMUEBLE (ID_INMUEBLE);

