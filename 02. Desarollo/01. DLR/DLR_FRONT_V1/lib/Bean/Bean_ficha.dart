class ficha {
  String nombre;
  String apellido;
  String documento;
  String celular;
  String direccion;
  String distrito;
  String producto;
  String descripcion;
  String SizeProduct;
  String delicado;
  String tipoenvio;
  String idempresa;
  String estado;
  String coord_origen;
  String coord_destino;
  String totalDistance;
  String totalDuration;
  ficha(
    this.nombre,
    this.apellido,
    this.documento,
    this.celular,
    this.direccion,
    this.distrito,
    this.producto,
    this.descripcion,
    this.SizeProduct,
    this.delicado,
    this.tipoenvio,
    this.idempresa,
    this.estado,
    this.coord_origen,
    this.coord_destino,
    this.totalDistance,
    this.totalDuration,
  );
  ficha.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    apellido = json['apellido'];
    documento = json['documento'];
    celular = json['celular'];
    direccion = json['direccion'];
    distrito = json['distrito'];
    producto = json['producto'];
    delicado = json['delicado'];
    delicado = json['size'];
    descripcion = json['descripcion'];
    tipoenvio = json['tipoenvio'];
    idempresa = json['idempresa'];
    estado = json['estado'];
    coord_origen = json['coord_origen'];
    coord_destino = json['coord_destino'];
    coord_origen = json['totalDistance'];
    coord_destino = json['totalDuration'];
  }
}
