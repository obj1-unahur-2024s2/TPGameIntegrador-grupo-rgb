object musica{
        //configuracion musica del juego y funciones para reproducir y detener
        const musicaMenuPrincipal = game.sound("musica-pantalla-inicial.mp3")
        const musicaNiveles = game.sound("musica-niveles.mp3")
        
        method reprocudirMusicaMenuPrincipal() {
            musicaMenuPrincipal.shouldLoop(true)
            musicaMenuPrincipal.play()
        }

        method detenerMusicaMenuPrincipal() {
            musicaMenuPrincipal.stop()
        }

        method reprocudirMusicaNiveles() {
            musicaNiveles.shouldLoop(true)
            musicaNiveles.play()
        }

        method detenerMusicaNiveles() {
            musicaNiveles.stop()
        }
}