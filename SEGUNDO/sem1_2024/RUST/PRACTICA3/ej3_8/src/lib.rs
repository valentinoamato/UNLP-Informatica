#[derive(PartialEq, Debug, Clone)]
enum Genero {
    Rock,
    Pop,
    Jazz,
    Otro,
}

#[derive(PartialEq, Debug, Clone)]
struct Cancion {
    titulo: String,
    artista: String,
    genero: Genero
}

#[derive(PartialEq, Debug)]
struct Playlist {
    nombre: String,
    canciones: Vec<Cancion>
}

impl Cancion {
    fn new(titulo: String,artista: String,genero: Genero) -> Cancion {
        Cancion{
            titulo,
            artista,
            genero
        }
    }
}

impl Playlist {
    fn new(nombre: String) -> Playlist {
        Playlist{
            nombre,
            canciones: Vec::new()
        }
    }

    fn agregar_cancion(&mut self,cancion: Cancion) {
        self.canciones.push(cancion);
    }

    fn eliminar_cancion(&mut self,titulo: String) {
        for i in 0..self.canciones.len() {
            if self.canciones[i].titulo==titulo {
                self.canciones.remove(i);
                break;
            }
        }
    }

    fn mover_cancion(&mut self,titulo: String,posicion: usize) {
        if posicion<=self.canciones.len() {
            for i in 0..self.canciones.len() {
                if self.canciones[i].titulo==titulo {
                    let mover = self.canciones[i].clone();
                    self.canciones.remove(i);
                    self.canciones.insert(posicion-1, mover);
                    break;
                }
            }
        }
    }

    fn buscar_cancion(&self,titulo: String) -> Option<Cancion> {
        let mut option = None;
        for i in 0..self.canciones.len() {
            if self.canciones[i].titulo==titulo {
                option = Some(self.canciones[i].clone());
                break;
            }
        }
        option
    }

    fn buscar_por_genero(&self,genero: Genero) -> Vec<Cancion> {
        let mut canciones = Vec::new();
        for i in 0..self.canciones.len() {
            if self.canciones[i].genero == genero {
                canciones.push(self.canciones[i].clone());
            }
        }
        canciones
    }

    fn buscar_por_artista(&self,artista: String) -> Vec<Cancion> {
        let mut canciones = Vec::new();
        for i in 0..self.canciones.len() {
            if self.canciones[i].artista == artista {
                canciones.push(self.canciones[i].clone());
            }
        }
        canciones
    }
    
    fn modificar_nombre(&mut self,nombre: String) {
        self.nombre = nombre;
    } 

    fn eliminar_canciones(&mut self) {
        self.canciones.clear();
    }
}

#[cfg(test)]
mod playlist_tests {
    use super::*;

    #[test]
    fn test_playlist() {
        let nombre = String::from("Musica");
        let canciones = Vec::new();
        let mut playlist = Playlist{nombre,canciones};
        assert_eq!(Playlist::new("Musica".to_string()),playlist);
        
        let cancion1 = Cancion::new("Cancion1".to_string(),"Artista1".to_string(),Genero::Rock);
        let cancion2 = Cancion::new("Cancion2".to_string(),"Artista1".to_string(),Genero::Pop);
        let cancion3 = Cancion::new("Cancion3".to_string(),"Artista2".to_string(),Genero::Rock);
        let cancion4 = Cancion::new("Cancion4".to_string(),"Artista2".to_string(),Genero::Pop);
        playlist.agregar_cancion(cancion1.clone());
        playlist.agregar_cancion(cancion4.clone());
        playlist.agregar_cancion(cancion2.clone());
        playlist.agregar_cancion(cancion3.clone());
        playlist.mover_cancion("Cancion4".to_string(), 4);

        let cancion = playlist.buscar_cancion("Cancion2".to_string());
        assert!(cancion.is_some());
        if let Some(a) = cancion {
            assert_eq!(a,cancion2);
        }
        assert_eq!(playlist.buscar_por_genero(Genero::Rock),vec![cancion1.clone(),cancion3.clone()]);
        assert_eq!(playlist.buscar_por_artista("Artista1".to_string()),vec![cancion1,cancion2]);
        playlist.eliminar_cancion("Cancion1".to_string());
        playlist.eliminar_cancion("Cancion2".to_string());
        assert_eq!(playlist.canciones,vec![cancion3,cancion4]);
        playlist.modificar_nombre("Hola".to_string());
        assert_eq!(playlist.nombre,"Hola".to_string());
        playlist.eliminar_canciones();
        assert_eq!(playlist.canciones,Vec::new());
    }


}