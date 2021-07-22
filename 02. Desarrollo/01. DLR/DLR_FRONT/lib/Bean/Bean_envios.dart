class envios {
  String ID_FICHA;
  String ID_EMPRESA;
  String FECHA_CREACION;
  String ESTADO;
  String MONTO;
  String COORD_ORIGEN;
  String COORD_DESTINO;
  String KM;
  String EMPRESA;
  String DIR_ORIGEN;
  String ORIGEN_ID_DISTRITO;
  String DIR_DESTINO;
  String DESTINO_ID_DISTRITO;
  String TIPO;
  String PRODUCTO;
  String CLIENTE_NOMBRE;
  String CLIENTE_APELLIDO;
  String CLIENTE_CELULAR;


  envios(
      this.ID_FICHA,
      this.ID_EMPRESA,
      this.FECHA_CREACION,
      this.ESTADO,
      this.MONTO,
      this.COORD_ORIGEN,
      this.COORD_DESTINO,
      this.KM,
      this.EMPRESA,
      this.DIR_ORIGEN,
      this.ORIGEN_ID_DISTRITO,
      this.DIR_DESTINO,
      this.DESTINO_ID_DISTRITO,
      this.TIPO,
      this.PRODUCTO,
      this.CLIENTE_NOMBRE,
      this.CLIENTE_APELLIDO,
      this.CLIENTE_CELULAR,

  );


  envios.fromJson(Map<String, dynamic> json) {
    ID_FICHA = json['ID_FICHA'];
    ID_EMPRESA = json['ID_EMPRESA'];
    FECHA_CREACION = json['FECHA_CREACION'];
    ESTADO = json['ESTADO'];
    MONTO = json['MONTO'];
    COORD_ORIGEN = json['COORD_ORIGEN'];
    COORD_DESTINO = json['COORD_DESTINO'];
    KM = json['KM'];
    EMPRESA = json['EMPRESA'];
    DIR_ORIGEN = json['DIR_ORIGEN'];
    ORIGEN_ID_DISTRITO = json['ORIGEN_ID_DISTRITO'];
    DIR_DESTINO = json['DIR_DESTINO'];
    DESTINO_ID_DISTRITO = json['DESTINO_ID_DISTRITO'];
    TIPO = json['TIPO'];
    PRODUCTO = json['PRODUCTO'];
    CLIENTE_NOMBRE = json['CLIENTE_NOMBRE'];
    CLIENTE_APELLIDO = json['CLIENTE_APELLIDO'];
    CLIENTE_CELULAR = json['CLIENTE_CELULAR'];

  }
}
