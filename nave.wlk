import wollok.game.*

object nave {
    // Definimos el poder de ataque y la posición inicial en la parte inferior del tablero
    const property poder = 50
    var property position = game.at(4, 0)  // Ajusta `4` según la anchura del tablero

    // Asignamos la imagen de la nave
    method image() = "nave_juego.gif"

    // Movimiento hacia la derecha, sin salir del límite del tablero
    method moverADerecha() {
        position = game.at((game.width() - 1).min(position.x() + 1), position.y())
    }

    // Movimiento hacia la izquierda, sin salir del límite del tablero
    method moverAIzquierda() {
        position = game.at(0.max(position.x() - 1), position.y())
    }

    // Método de disparo, recibe una lista de aliens como parámetro
    method disparar(aliens) {
        // Filtramos los aliens en la misma columna que la nave
        const aliensEnColumna = aliens.filter({ alien => alien.position().x() == self.position().x() })

        // Si no hay aliens en la columna, no hace nada
        if (!aliensEnColumna.isEmpty()) {
           const alienMasCercano = aliensEnColumna.min({ alien => alien.position().y() })

            if (alienMasCercano != null) {
                // La nave ataca al alien más cercano
                alienMasCercano.recibirDanio(poder)

                // Crear efecto visual y de sonido del disparo (explosión) en la posición del alien
                const explosion = new Explosion(position = game.at(self.position().x(), alienMasCercano.position().y()))
                game.addVisual(explosion)
                game.sound("sonido-disparo.mp3").play()

                // Verificamos si el alien ha sido destruido y agregamos efecto de sonido de la explosión
                if (!alienMasCercano.estaVivo()) {
                    game.sound("sonido-explosion.mp3").play()
                    game.removeVisual(alienMasCercano)  // Removemos el alien del juego
                    aliens.remove(alienMasCercano)      // Eliminamos el alien de la lista de aliens
                }

                // Remover la explosión después de 1 segundo
                game.schedule(1000, { game.removeVisual(explosion) })
            } 
        }
    }
}

// Clase Explosion para crear un efecto visual
class Explosion {
    var property position

    // Asignamos la imagen del disparo
    method image() = "laser.png"
}

object imagenInicial {
    const property position = game.at(0,0)

    // Asignamos la imagen del disparo
    method image() = "pantalla-inicio.jpg"
}
object imagenFinal {
    const property position = game.at(0,0)

    // Asignamos la imagen del disparo
    method image() = "pantalla-final.jpg"
}

object imagenJuego{
    const property position = game.at(0,0)

    method image() = "fondo-juego.jpg" 
}
