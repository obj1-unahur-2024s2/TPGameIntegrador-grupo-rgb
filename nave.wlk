import wollok.game.*

object nave {
    // Definimos el poder de ataque y la posición inicial en la parte inferior del tablero
    const property poder = 50
    var property position = game.at(4, 0)  // Ajusta `4` según la anchura del tablero
    var property contadorDisparos = 0

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
        /*// Filtramos los aliens en la misma columna que la nave
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
        }*/

        const disparo = new Disparo(position = self.position())

        contadorDisparos+=1

        disparo.initialize(contadorDisparos,aliens)
        game.sound("sonido-disparo.mp3").play()
    }
}

// Clase Explosion para crear un efecto visual
class Explosion {
    var property position

    // Asignamos la imagen del disparo
    method image() = "laser.png"
}

class Disparo{
    var property position

    method image() = "laser.png"

    method initialize(numero,aliens) {
        game.addVisual(self)
        game.onTick(200, "disparo-" + numero, {

            if(self.hayAlienAqui(aliens)){
                const alienEnPosicion = aliens.find({alien => alien.position() == self.position()})
                alienEnPosicion.recibirDanio(nave.poder())

                // Crear efecto visual y de sonido del disparo (explosión) en la posición del alien
                const explosion = new Explosion(position = game.at(self.position().x(), alienEnPosicion.position().y()))
                game.addVisual(explosion)

                if(!alienEnPosicion.estaVivo()){
                    game.sound("sonido-explosion.mp3").play()
                    game.removeVisual(alienEnPosicion)  // Removemos el alien del juego
                    aliens.remove(alienEnPosicion)      // Eliminamos el alien de la lista de aliens
                }

                // Remover la explosión después de 1 segundo
                game.schedule(1000, { game.removeVisual(explosion) })

                self.eliminarse(numero)
                
            }else{
                self.avanzar(numero)
            }
        })
    }

    method avanzar(numero) {
        if(position.y()+1 == game.height()){
            game.removeTickEvent("disparo-"+numero)
            game.removeVisual(self)     
        }else{
            position = game.at(position.x(), position.y() + 1)
        }
    } 

    method hayAlienAqui(aliens){
        return aliens.any({alien => alien.position() == self.position()})
    }

    method eliminarse(numero) {
        game.removeTickEvent("disparo-"+numero)
        game.removeVisual(self)
    }

}