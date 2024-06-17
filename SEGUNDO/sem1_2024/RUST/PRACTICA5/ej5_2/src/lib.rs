use std::{fs::File, io::{Error, Read, Write}, string};
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
enum Genero {
    Rock,
    Pop,
    Jazz,
    Otro,
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Cancion {
    titulo: String,
    artista: String,
    genero: Genero
}

#[derive(Serialize, Deserialize, PartialEq, Debug)]
struct Playlist {
    nombre: String,
    canciones: Vec<Cancion>,
    path: String,
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
    fn new(nombre: String, path: String) -> Result<Playlist, Error> {
        let playlist = Playlist{
            nombre,
            canciones: Vec::new(),
            path,
        };
        playlist.guardar()?;
        Ok(playlist)
    }

    fn build(path: &String) -> Result<Playlist, Error> {
        let mut file = File::open(path)?;
        let mut buffer = String::new();
        file.read_to_string(&mut buffer)?;
        let playlist: Playlist = serde_json::from_str(&buffer)?;
        Ok(playlist)
    }

    fn agregar_cancion(&mut self,cancion: Cancion) -> Result<(), Error> {
        self.canciones.push(cancion);
        self.guardar()
    }

    fn eliminar_cancion(&mut self,titulo: &String) -> Result<bool, Error>{
        for i in 0..self.canciones.len() {
            if self.canciones[i].titulo==*titulo {
                self.canciones.remove(i);
                self.guardar()?;
                return Ok(true);
            }
        }
        Ok(false)
    }

    fn mover_cancion(&mut self,titulo: &String,posicion: usize) -> Result<bool, Error>{
        if posicion<=self.canciones.len() {
            for i in 0..self.canciones.len() {
                if self.canciones[i].titulo==*titulo {
                    let mover = self.canciones[i].clone();
                    self.canciones.remove(i);
                    self.canciones.insert(posicion-1, mover);
                    self.guardar()?;
                    return Ok(true);
                }
            }
        }
        Ok(false)
    }

    fn buscar_cancion(&self,titulo: &String) -> Option<&Cancion> {
        let mut option = None;
        for i in 0..self.canciones.len() {
            if self.canciones[i].titulo==*titulo {
                option = Some(&self.canciones[i]);
                break;
            }
        }
        option
    }

    fn buscar_por_genero(&self,genero: &Genero) -> Vec<&Cancion> {
        let mut canciones = Vec::new();
        for i in 0..self.canciones.len() {
            if self.canciones[i].genero == *genero {
                canciones.push(&self.canciones[i]);
            }
        }
        canciones
    }

    fn buscar_por_artista(&self,artista: &String) -> Vec<&Cancion> {
        let mut canciones = Vec::new();
        for i in 0..self.canciones.len() {
            if self.canciones[i].artista == *artista {
                canciones.push(&self.canciones[i]);
            }
        }
        canciones
    }
    
    fn modificar_nombre(&mut self,nombre: String) -> Result<(), Error> {
        self.nombre = nombre;
        self.guardar()
    } 

    fn eliminar_canciones(&mut self) -> Result<(), Error> {
        self.canciones.clear();
        self.guardar()
    }

    fn guardar(&self) -> Result<(), Error> {
        let mut file = File::create(&self.path)?;
        let serialized = serde_json::to_string(&self)?;
        file.write_all(serialized.as_bytes())
    }
}

#[cfg(test)]
mod playlist_tests {
    use super::*;

    fn crear_playlist(path: String) -> Playlist {
        let nombre = String::from("Musica");
        let canciones = Vec::new();
        let mut playlist = Playlist{nombre,canciones,path};
        
        let cancion1 = Cancion::new("Cancion1".to_string(),"Artista1".to_string(),Genero::Rock);
        let cancion2 = Cancion::new("Cancion2".to_string(),"Artista1".to_string(),Genero::Pop);
        let cancion3 = Cancion::new("Cancion3".to_string(),"Artista2".to_string(),Genero::Rock);
        let cancion4 = Cancion::new("Cancion4".to_string(),"Artista2".to_string(),Genero::Pop);
        playlist.agregar_cancion(cancion1.clone());
        playlist.agregar_cancion(cancion2.clone());
        playlist.agregar_cancion(cancion3.clone());
        playlist.agregar_cancion(cancion4.clone());
        playlist
    }

    #[test]
    fn test_playlist_new() {
        let path = String::from("archivos/tests/playlist_new.json");
        let playlist1 = Playlist::new("Playlist".to_string(),path.clone()).unwrap();
        let playlist2 = Playlist {
            nombre:"Playlist".to_string(),
            canciones:Vec::new(),
            path:path.clone(),
        };
        assert_eq!(playlist1,playlist2);
        assert_eq!(playlist1,Playlist::build(&path).unwrap());
    }

    #[test]
    fn test_playlist_build() {
        let path = String::from("archivos/tests/playlist_build.json");
        let playlist1 = crear_playlist(path.clone());
        let playlist2 = Playlist::build(&path).unwrap();
        assert_eq!(playlist1,playlist2);
    }

    #[test]
    fn test_playlist_agregar_cancion() {
        let path = String::from("archivos/tests/playlist_agregar_cancion.json");
        let mut playlist = crear_playlist(path.clone());
        assert_eq!(playlist.canciones.len(),4);
        let cancion = Cancion::new("T1".to_string(), "A1".to_string(), Genero::Otro);
        playlist.agregar_cancion(cancion.clone()).unwrap();
        assert_eq!(playlist.canciones.len(),5);
        assert_eq!(playlist.canciones[4],cancion);
        assert_eq!(playlist,Playlist::build(&path).unwrap());
    }

    #[test]
    fn test_playlist_eliminar_cancion() {
        let path = String::from("archivos/tests/playlist_eliminar_cancion.json");
        let mut playlist = crear_playlist(path.clone());
        assert_eq!(playlist.canciones.len(),4);
        let cancion = playlist.canciones[0].clone();
        assert!(!playlist.eliminar_cancion(&"NO_EXISTE".to_string()).unwrap());
        playlist.eliminar_cancion(&cancion.titulo.clone()).unwrap();
        assert_eq!(playlist.canciones.len(),3);
        assert_ne!(playlist.canciones[0],cancion);
        assert_eq!(playlist, Playlist::build(&path).unwrap());
    }
    
    #[test]
    fn test_playlist_mover_cancion() {
        let path = String::from("archivos/tests/playlist_mover_cancion.json");
        let mut playlist = crear_playlist(path.clone());
        assert_eq!(playlist.canciones.len(),4);
        let cancion1 = playlist.canciones[0].clone();
        let cancion4 = playlist.canciones[3].clone();
        assert!(!playlist.mover_cancion(&"NO_EXISTE".to_string(), 3).unwrap());
        playlist.mover_cancion(&cancion4.titulo.clone(),1).unwrap();
        assert_eq!(playlist.canciones.len(),4);
        assert_eq!(playlist.canciones[1],cancion1);
        assert_eq!(playlist.canciones[0],cancion4);
        assert_eq!(playlist,Playlist::build(&path).unwrap());
    }

    #[test]
    fn test_playlist_buscar_cancion() {
        let path = String::from("archivos/tests/playlist_buscar_cancion.json");
        let playlist = crear_playlist(path);
        let cancion = playlist.canciones[0].clone();
        assert!(playlist.buscar_cancion(&"NO_EXISTE".to_string()).is_none());
        if let Some(can) = playlist.buscar_cancion(&cancion.titulo) {
            assert_eq!(*can,cancion);
        }
    }

    #[test]
    fn test_playlist_buscar_por_genero() {
        let path = String::from("archivos/tests/playlist_buscar_por_genero.json");
        let playlist = crear_playlist(path);
        let cancion1 = playlist.canciones[0].clone();
        let cancion3 = playlist.canciones[2].clone();
        assert_eq!(playlist.buscar_por_genero(&Genero::Otro),Vec::<&Cancion>::new());
        let vec = vec![&cancion1,&cancion3];
        for (i,c) in playlist.buscar_por_genero(&Genero::Rock).iter().enumerate() {
            assert_eq!(**c,*vec[i]);
        }       
    }

    #[test]
    fn test_playlist_buscar_por_artista() {
        let path = String::from("archivos/tests/playlist_buscar_por_artista.json");
        let playlist = crear_playlist(path);
        let cancion1 = playlist.canciones[0].clone();
        let cancion2 = playlist.canciones[1].clone();
        assert_eq!(playlist.buscar_por_artista(&"NO_EXISTE".to_string()),Vec::<&Cancion>::new());
        let vec = vec![&cancion1,&cancion2];
        for (i,c) in playlist.buscar_por_artista(&"Artista1".to_string()).iter().enumerate() {
            assert_eq!(**c,*vec[i]);
        }       
    }

    #[test]
    fn test_playlist_modificar_nombre() {
        let path = String::from("archivos/tests/playlist_modificar_nombre.json");
        let mut playlist = crear_playlist(path.clone());
        assert_eq!(playlist.nombre,"Musica".to_string());
        playlist.modificar_nombre("Nuevo Nombre".to_string()).unwrap();
        assert_eq!(playlist.nombre,"Nuevo Nombre".to_string());
        assert_eq!(playlist,Playlist::build(&path).unwrap());
    }

    #[test]
    fn test_playlist_eliminar_canciones() {
        let path = String::from("archivos/tests/playlist_eliminar_caciones.json");
        let mut playlist = crear_playlist(path.clone());
        assert_eq!(playlist.canciones.len(),4);
        playlist.eliminar_canciones();
        assert_eq!(playlist.canciones.len(),0);
        assert_eq!(playlist,Playlist::build(&path).unwrap());
    }

    #[test]
    fn test_playlist_guardar() {
        let path = String::from("archivos/tests/playlist_guardar.json");
        let nombre = "Playlist".to_string();
        let playlist1 = Playlist {
            nombre: nombre.clone(),
            canciones:Vec::new(),
            path:path.clone(),
        };
        playlist1.guardar().unwrap();
        let playlist2 = Playlist::build(&path).unwrap();
        assert_eq!(playlist1,playlist2);
    }

    #[test]
    fn test_cancion_new() {
        let titulo = "titulo".to_string(); 
        let artista = "artista".to_string();
        let genero = Genero::Jazz; 
        let cancion1 = Cancion {
            titulo: titulo.clone(),
            artista: artista.clone(),
            genero: genero.clone(),
        };
        let cancion2 = Cancion::new(titulo, artista, genero);
        assert_eq!(cancion1,cancion2);
    }
}