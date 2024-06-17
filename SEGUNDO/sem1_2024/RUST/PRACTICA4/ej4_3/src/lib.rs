#[derive(Clone,PartialEq, Debug)]
enum MetodoPago {
    Efectivo,
    MercadoPago(u128), //CVU
    Credito(u128),     //PAN
    Transferencia(u128),//CBU
    Cripto(String),    //Direccion
}

#[derive(Clone, Copy,PartialEq, Debug)]
enum TipoSuscripcion {
    Basic,
    Clasic,
    Super,
}

#[derive(PartialEq, Debug, Clone)]
struct Suscripcion {
    inicio: (u8, u8, u16), //dia mes anno
    duracion: u8,
    tipo: TipoSuscripcion,
}

impl Suscripcion {
    fn new(inicio: (u8,u8,u16), duracion: u8, tipo: TipoSuscripcion) -> Suscripcion {
        Suscripcion {
            inicio,
            duracion,
            tipo,
        }
    }
}

#[derive(PartialEq, Debug, Clone)]
struct Usuario {
    nombre: String, //Username unico
    metodo: MetodoPago,
    suscripcion: Suscripcion,
}

impl Usuario {
    fn new(nombre: String, metodo: MetodoPago, suscripcion: Suscripcion) -> Usuario {
        Usuario {
            nombre,
            metodo,
            suscripcion,
        }
    }
}

#[derive(Debug)]
struct Registro {
    metodo_de_pago: [(MetodoPago, u32);5],
    tipo_de_suscripcion: [(TipoSuscripcion, u32);3],
}

impl Registro {
    fn new() -> Registro {
        Registro {
            metodo_de_pago: [
                (MetodoPago::Credito(0),0),
                (MetodoPago::Cripto(String::from("")),0),
                (MetodoPago::Efectivo,0),
                (MetodoPago::MercadoPago(0),0),
                (MetodoPago::Transferencia(0),0),
            ],
            tipo_de_suscripcion: [
                (TipoSuscripcion::Basic,0),
                (TipoSuscripcion::Clasic,0),
                (TipoSuscripcion::Super,0),
            ],
        }
    }
}

struct Plataforma {
    usuarios: Vec<Usuario>,
    costos: (f32,f32,f32), //Basic, Clasic, Super
    registro: Registro, //Punto G/H
}

impl Plataforma {
    fn new(costos: (f32,f32,f32)) -> Plataforma {
        Plataforma {
            usuarios: Vec::new(),
            costos,
            registro: Registro::new(),
        }
    }

    fn agregar(&mut self, usuario: Usuario) -> bool {
        match self.usuarios.iter().find(|u| u.nombre==usuario.nombre) {
            Some(_) => false,
            None => {
                match usuario.metodo {
                    MetodoPago::Credito(_) => self.registro.metodo_de_pago[0].1+=1,
                    MetodoPago::Cripto(_) => self.registro.metodo_de_pago[1].1+=1,
                    MetodoPago::Efectivo => self.registro.metodo_de_pago[2].1+=1,
                    MetodoPago::MercadoPago(_) => self.registro.metodo_de_pago[3].1+=1,
                    MetodoPago::Transferencia(_) => self.registro.metodo_de_pago[4].1+=1,
                }
                match usuario.suscripcion.tipo {
                    TipoSuscripcion::Basic => self.registro.tipo_de_suscripcion[0].1+=1,
                    TipoSuscripcion::Clasic => self.registro.tipo_de_suscripcion[1].1+=1,
                    TipoSuscripcion::Super => self.registro.tipo_de_suscripcion[2].1+=1,
                }
                self.usuarios.push(usuario);
                true
            },
        }
    }

    fn upgrade(&mut self, usuario: &Usuario) -> bool {
        match self.usuarios.iter_mut().find(|u| u.nombre==usuario.nombre) {
            Some(u) => {
                match u.suscripcion.tipo {
                    TipoSuscripcion::Basic => u.suscripcion.tipo = TipoSuscripcion::Clasic,
                    TipoSuscripcion::Clasic => u.suscripcion.tipo = TipoSuscripcion::Super,
                    TipoSuscripcion::Super => (),
                }
                true
            },
            None => false,
        }
    }

    fn downgrade(&mut self, usuario: &Usuario) -> bool {
        match self.usuarios.iter().position(|u| u.nombre==usuario.nombre) {
            Some(i) => {
                match self.usuarios[i].suscripcion.tipo {
                    TipoSuscripcion::Basic => {self.usuarios.remove(i);}, //No puedo usar cancelar (already borrowed self as mut)
                    TipoSuscripcion::Clasic => self.usuarios[i].suscripcion.tipo = TipoSuscripcion::Basic,
                    TipoSuscripcion::Super => self.usuarios[i].suscripcion.tipo = TipoSuscripcion::Clasic,
                };
                true
            },
            None => false,
        }
    }

    fn cancelar(&mut self, usuario: &Usuario) -> bool {
        match self.usuarios.iter().position(|u| u.nombre==usuario.nombre) {
            Some(i) => {
                self.usuarios.remove(i);
                true
            },
            None => false,
        }
    }

    fn metodo_mas_usado_actual(&self) -> Option<MetodoPago> {
        if self.usuarios.is_empty() {
            return None;
        }
        let mut cantidades: Vec<u32> = vec![0,0,0,0,0];
        let mut max = 0;
        self.usuarios.iter().for_each(|usuario| {
            match usuario.metodo {
                MetodoPago::Credito(_) => cantidades[0]+=1,
                MetodoPago::Cripto(_) => cantidades[1]+=1,
                MetodoPago::Efectivo => cantidades[2]+=1,
                MetodoPago::MercadoPago(_) => cantidades[3]+=1,
                MetodoPago::Transferencia(_) => cantidades[4]+=1,
            }
        });
        cantidades.iter().enumerate().for_each(|(i,cantidad)| {
            if *cantidad>cantidades[max] {
                max = i;
            }
        });
        match max {
            0 => Some(MetodoPago::Credito(0)),
            1 => Some(MetodoPago::Cripto(String::from(""))),
            2 => Some(MetodoPago::Efectivo),
            3 => Some(MetodoPago::MercadoPago(0)),
            4 => Some(MetodoPago::Transferencia(0)),
            _ => panic!("Unexpected value.")
        }
    }

    fn suscripcion_mas_contratada_actual(&self) -> Option<TipoSuscripcion> {
        if self.usuarios.is_empty() {
            return None;
        }
        let mut cantidades: Vec<u32> = vec![0,0,0];
        let mut max = 0;
        self.usuarios.iter().for_each(|usuario| {
            match usuario.suscripcion.tipo {
                TipoSuscripcion::Basic => cantidades[0]+=1,
                TipoSuscripcion::Clasic => cantidades[1]+=1,
                TipoSuscripcion::Super => cantidades[2]+=1,
            }
        });
        cantidades.iter().enumerate().for_each(|(i,cantidad)| {
            if *cantidad>cantidades[max] {
                max = i;
            }
        });
        match max {
            0 => Some(TipoSuscripcion::Basic),
            1 => Some(TipoSuscripcion::Clasic),
            2 => Some(TipoSuscripcion::Super),
            _ => panic!("Unexpected value.")
        }
    }

    fn metodo_mas_usado(&self) -> Option<MetodoPago> {
        if let Some((metodo, cant)) = self.registro.metodo_de_pago.iter().max_by(|x, y| x.1.cmp(&y.1)) {
            if *cant>0 {
                return Some(metodo.clone());
            }
        } 
        None
    }

    fn suscripcion_mas_contratada(&self) -> Option<TipoSuscripcion> {
        if let Some((tipo, cant)) = self.registro.tipo_de_suscripcion.iter().max_by(|x, y| x.1.cmp(&y.1)) {
            if *cant>0 {
                return Some(tipo.clone());
            }
        } 
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn crear_plataforma() -> Plataforma {
        let mut plataforma = Plataforma::new((10.0, 20.0, 30.0));
        plataforma.agregar(Usuario::new("USER0".to_string(), MetodoPago::Credito(123), Suscripcion::new((1,1,2001), 1, TipoSuscripcion::Basic)));
        plataforma.agregar(Usuario::new("USER1".to_string(), MetodoPago::Efectivo, Suscripcion::new((2,2,2002), 2, TipoSuscripcion::Basic)));
        plataforma.agregar(Usuario::new("USER2".to_string(), MetodoPago::Cripto("0x1b".to_string()), Suscripcion::new((3,3,2003), 3, TipoSuscripcion::Clasic)));
        plataforma.agregar(Usuario::new("USER3".to_string(), MetodoPago::Credito(456), Suscripcion::new((4,4,2004), 4, TipoSuscripcion::Clasic)));
        plataforma.agregar(Usuario::new("USER4".to_string(), MetodoPago::Efectivo, Suscripcion::new((5,5,2005), 5, TipoSuscripcion::Clasic)));
        plataforma.agregar(Usuario::new("USER5".to_string(), MetodoPago::Efectivo, Suscripcion::new((1,1,2001), 1, TipoSuscripcion::Clasic)));
        plataforma.agregar(Usuario::new("USER6".to_string(), MetodoPago::Efectivo, Suscripcion::new((2,2,2002), 2, TipoSuscripcion::Clasic)));
        plataforma.agregar(Usuario::new("USER7".to_string(), MetodoPago::Transferencia(789), Suscripcion::new((3,3,2003), 3, TipoSuscripcion::Super)));
        plataforma.agregar(Usuario::new("USER8".to_string(), MetodoPago::MercadoPago(101112), Suscripcion::new((4,4,2004), 4, TipoSuscripcion::Super)));
        plataforma.agregar(Usuario::new("USER9".to_string(), MetodoPago::Efectivo, Suscripcion::new((5,5,2005), 5, TipoSuscripcion::Super)));
        plataforma
    }

    fn crear_plataforma_vacia() -> Plataforma {
        Plataforma::new((1.0,2.0,3.0))
    }

    #[test]
    fn test_agregar() {
        let mut plataforma = crear_plataforma();
        assert!(!plataforma.agregar(Usuario::new("USER0".to_string(), MetodoPago::Efectivo, Suscripcion::new((1,1,1), 1, TipoSuscripcion::Basic))));

        let usuario = Usuario::new("USER10".to_string(), MetodoPago::Efectivo, Suscripcion::new((1,1,1), 1, TipoSuscripcion::Basic));
        assert!(plataforma.agregar(usuario.clone()));
        assert_eq!(plataforma.usuarios[10],usuario);

        //Plataforma vacia
        let mut plataforma = crear_plataforma_vacia();
        assert!(plataforma.agregar(usuario.clone()));
        assert_eq!(plataforma.usuarios[0],usuario);
    }

    #[test]
    fn test_upgrade() {
        let mut plataforma = crear_plataforma();
        let usuario = plataforma.usuarios[0].clone();
        assert_eq!(plataforma.usuarios[0].suscripcion.tipo, TipoSuscripcion::Basic);
        plataforma.upgrade(&usuario);
        assert_eq!(plataforma.usuarios[0].suscripcion.tipo, TipoSuscripcion::Clasic);
        plataforma.upgrade(&usuario);
        assert_eq!(plataforma.usuarios[0].suscripcion.tipo, TipoSuscripcion::Super);
        plataforma.upgrade(&usuario);
        assert_eq!(plataforma.usuarios[0].suscripcion.tipo, TipoSuscripcion::Super);
        //Plataforma vacia
        assert!(!crear_plataforma_vacia().downgrade(&usuario));
    }

    #[test]
    fn test_downgrade() {
        let mut plataforma = crear_plataforma();
        let usuario = plataforma.usuarios[7].clone();
        assert_eq!(plataforma.usuarios[7].suscripcion.tipo, TipoSuscripcion::Super);
        plataforma.downgrade(&usuario);
        assert_eq!(plataforma.usuarios[7].suscripcion.tipo, TipoSuscripcion::Clasic);
        plataforma.downgrade(&usuario);
        assert_eq!(plataforma.usuarios[7].suscripcion.tipo, TipoSuscripcion::Basic);
        //Elimina al usuario
        plataforma.downgrade(&usuario);
        assert_eq!(plataforma.usuarios[7].nombre,"USER8".to_string());
        //Plataforma vacia
        assert!(!crear_plataforma_vacia().downgrade(&usuario));
    }

    #[test]
    fn test_cancelar() {
        let mut plataforma = crear_plataforma();
        let usuario = Usuario::new("USER0".to_string(), MetodoPago::Efectivo, Suscripcion::new((1,1,1), 1, TipoSuscripcion::Basic));

        assert_eq!(plataforma.usuarios[0].nombre,"USER0".to_string());
        plataforma.cancelar(&usuario);
        assert!(!plataforma.cancelar(&usuario));
        assert_eq!(plataforma.usuarios[0].nombre,"USER1".to_string());        
        
        // //Plataforma vacia
        assert!(!crear_plataforma_vacia().cancelar(&usuario));

    }

    #[test]
    fn test_metodo_mas_usado_actual() {
        let mut plataforma = crear_plataforma();

        assert_eq!(plataforma.metodo_mas_usado_actual(),Some(MetodoPago::Efectivo));
        plataforma.usuarios[1].metodo = MetodoPago::Credito(123);
        plataforma.usuarios[4].metodo = MetodoPago::Credito(123);
        assert_eq!(plataforma.metodo_mas_usado_actual(),Some(MetodoPago::Credito(0)));

        // //Plataforma vacia
        assert_eq!(crear_plataforma_vacia().metodo_mas_usado_actual(),None);
    }

    #[test]
    fn test_suscripcion_mas_contratada_actual() {
        let mut plataforma = crear_plataforma();

        assert_eq!(plataforma.suscripcion_mas_contratada_actual(),Some(TipoSuscripcion::Clasic));
        plataforma.usuarios[2].suscripcion.tipo = TipoSuscripcion::Super;
        plataforma.usuarios[3].suscripcion.tipo = TipoSuscripcion::Super;
        assert_eq!(plataforma.suscripcion_mas_contratada_actual(),Some(TipoSuscripcion::Super));

        // //Plataforma vacia
        assert_eq!(crear_plataforma_vacia().suscripcion_mas_contratada_actual(),None);
    }

    #[test]
    fn test_metodo_mas_usado() {
        let mut plataforma = crear_plataforma();

        assert_eq!(plataforma.metodo_mas_usado(),Some(MetodoPago::Efectivo));
        plataforma.usuarios[1].metodo = MetodoPago::Credito(123);
        plataforma.usuarios[4].metodo = MetodoPago::Credito(123);
        assert_eq!(plataforma.metodo_mas_usado(),Some(MetodoPago::Efectivo));
        let mut usuario = Usuario::new("USER20".to_string(), MetodoPago::Credito(0), Suscripcion::new((1,1,1), 1, TipoSuscripcion::Basic));
        plataforma.agregar(usuario.clone());
        usuario.nombre = "USER21".to_string();
        plataforma.agregar(usuario.clone());
        usuario.nombre = "USER22".to_string();
        plataforma.agregar(usuario.clone());
        usuario.nombre = "USER23".to_string();
        plataforma.agregar(usuario);
        assert_eq!(plataforma.metodo_mas_usado(),Some(MetodoPago::Credito(0)));
        // //Plataforma vacia
        assert_eq!(crear_plataforma_vacia().metodo_mas_usado(),None);
    }

    #[test]
    fn test_suscripcion_mas_contratada() {
        let mut plataforma = crear_plataforma();

        assert_eq!(plataforma.suscripcion_mas_contratada(),Some(TipoSuscripcion::Clasic));
        plataforma.usuarios[2].suscripcion.tipo = TipoSuscripcion::Basic;
        plataforma.usuarios[3].suscripcion.tipo = TipoSuscripcion::Basic;
        assert_eq!(plataforma.suscripcion_mas_contratada(),Some(TipoSuscripcion::Clasic));
        let mut usuario = Usuario::new("USER20".to_string(), MetodoPago::Credito(0), Suscripcion::new((1,1,1), 1, TipoSuscripcion::Basic));
        plataforma.agregar(usuario.clone());
        usuario.nombre = "USER21".to_string();
        plataforma.agregar(usuario.clone());
        usuario.nombre = "USER22".to_string();
        plataforma.agregar(usuario.clone());
        usuario.nombre = "USER23".to_string();
        plataforma.agregar(usuario);
        assert_eq!(plataforma.suscripcion_mas_contratada(),Some(TipoSuscripcion::Basic));
        // //Plataforma vacia
        assert_eq!(crear_plataforma_vacia().suscripcion_mas_contratada(),None);
    }
}