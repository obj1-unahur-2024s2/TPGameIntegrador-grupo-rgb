import wollok.game.*

class Alien {
    // Propiedades del alien
    var property position
    var property vida = 100
    var property imagenActual = "alien1.png"  // Imagen inicial

    // Asignamos la imagen que representa al alien
    method image() = imagenActual

    // Método para inicializar la posición del alien
    method initialize(posicionInicial) {
        position = posicionInicial
    }

    // Método para mover el alien hacia abajo
    method moverAbajo() {
        // Actualizamos la posición moviéndolo una celda hacia abajo
        position = game.at(position.x(), position.y() - 1)
        
        // Cambiar la imagen del alien alternando entre alien1.png y alien2.png
        if (imagenActual == "alien1.png") {
            imagenActual = "alien2.png"
        } else {
            imagenActual = "alien1.png"
        }
    }

    // Método para recibir daño
    method recibirDanio(cantidad) {
        vida = (vida - cantidad).max(0)  // Reducimos la vida sin que sea menor a 0
    }

    // Método para consultar la vida actual del alien
    method vida() = vida

    // Método para verificar si el alien está vivo
    method estaVivo() = vida > 0
}
