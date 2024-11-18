import wollok.game.*

class Alien {
    // Propiedades del alien
    var property position
    var property vida = 100

    // Asignamos la imagen que representa al alien
    method image() = "alien_blanco.gif"

    // Método para inicializar la posición del alien
    method initialize(posicionInicial) {
        position = posicionInicial
    }

    // Método para mover el alien hacia abajo
    method moverAbajo() {
        // Actualizamos la posición moviéndolo una celda hacia abajo
        position = game.at(position.x(), position.y() - 1)
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


class AlienNormal inherits Alien{
}

class AlienJefe inherits Alien {
    method agregarVida() {
        vida = vida*2
    }
    
    override method image() = "alien.gif" 
}