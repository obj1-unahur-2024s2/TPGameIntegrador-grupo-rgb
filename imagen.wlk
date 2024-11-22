class Imagen{
    const property position = game.at(0,0)

    method image() 
}

class ImagenInicial inherits Imagen {

    // Asignamos la imagen del disparo
    override method image() = "pantalla-inicio.jpg"
}
class ImagenFinal inherits Imagen{

    // Asignamos la imagen del disparo
    override method image() = "pantalla-final.jpg"
}

class ImagenJuego inherits Imagen{

    override method image() = "fondo-juego.jpg" 
}

class ImagenPerder inherits Imagen{
  override method image() = "pantalla-gameover.jpg" 
}
