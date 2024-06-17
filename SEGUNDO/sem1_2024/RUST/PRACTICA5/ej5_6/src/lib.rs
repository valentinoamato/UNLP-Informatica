use std::{fs::File, io::{Error, Read, Write}};

use chrono::{prelude::Local, Datelike};
use rand::random;
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize, Debug, PartialEq,Clone,Copy)]
struct Fecha {
    dia: u8,
    mes: u8,
    anno: u16,
}

impl Fecha {
    fn now() -> Fecha {
        let now = Local::now();
        Fecha {
            dia:now.day() as u8,
            mes:now.month() as u8,
            anno:now.year() as u16,
        }
    }
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct Usuario {
    nombre: String,
    apellido: String,
    email: String,
    dni: u32,
    validado: bool,
    balance: Vec<(String, f32)>, //(nombre cripto, balance)
    fiat: f32,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct Blockchain {
    nombre: String,
    prefijo: String,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct Criptomoneda {
    nombre: String,
    prefijo: String,
    blockchains: Vec<Blockchain>,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone, Copy)]
enum Medio {
    MercadoPago,
    Transferencia,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct CompraVentaCripto {
    fecha: Fecha,
    dni: u32,
    cripto: String,
    cantidad: f32,
    precio: f32,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct IngresoCripto {
    fecha: Fecha,
    dni: u32,
    cripto: String,
    blockchain: String,
    cantidad: f32,
    precio: f32,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct IngresoFiat {
    fecha: Fecha,
    dni: u32,
    cantidad: f32,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct RetiroCripto {
    fecha: Fecha,
    dni: u32,
    cripto: String,
    blockchain: String,
    hash: String,
    cantidad: f32,
    precio: f32,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct RetiroFiat {
    fecha: Fecha,
    dni: u32,
    cantidad: f32,
    medio: Medio,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
enum Transaccion {
    CompraCripto(CompraVentaCripto),
    IngresoCripto(IngresoCripto),
    IngresoFiat(IngresoFiat),
    RetiroCripto(RetiroCripto),
    RetiroFiat(RetiroFiat),
    VentaCripto(CompraVentaCripto),
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Clone)]
struct Plataforma {
    usuarios: Vec<Usuario>,
    criptomonedas: Vec<Criptomoneda>,
    transacciones: Vec<Transaccion>,
    path:String,
}

impl Plataforma {
    fn new(criptomonedas_iniciales: Option<Vec<Criptomoneda>>, path: String) -> Result<Plataforma, Error> {
        let usuarios = Vec::new();
        let transacciones = Vec::new();
        let criptomonedas = if let Some(criptos) = criptomonedas_iniciales {
                criptos
            
        } else {
            Vec::new()
        };
        let plataforma = Plataforma {
            usuarios,
            criptomonedas,
            transacciones,
            path,
        };
        plataforma.guardar()?;
        Ok(plataforma)
    }

    fn build(path: &String) -> Result<Plataforma, Error> {
        let mut file = File::open(path)?;
        let mut buf = String::new();
        file.read_to_string(&mut buf)?;
        Ok(serde_json::from_str(&buf)?)
    }

    fn agregar_criptomoneda(&mut self, criptomoneda: Criptomoneda) -> Result<bool, Error> {
        match self.criptomonedas.iter().find(|cripto| cripto.nombre==criptomoneda.nombre) {
            Some(_) => Ok(false),
            None => {
                self.criptomonedas.push(criptomoneda);
                self.guardar()?;
                Ok(true)
            }
        }
    }

    fn crear_usuario(&mut self, nombre: String, apellido: String, email: String, dni: u32) -> Result<bool, Error> {
        match self.usuarios.iter().find(|u| u.dni==dni) {
            Some(_) => Ok(false),
            None => {
                self.usuarios.push(Usuario {
                    nombre,
                    apellido,
                    email,
                    dni,
                    validado: false,
                    balance: Vec::new(),
                    fiat: 0.0,
                });
                self.guardar()?;
                Ok(true)
            }
        }
    }

    fn validar_usuario(&mut self,dni: u32) -> Result<bool, Error> {
        match self.usuarios.iter_mut().find(|usuario| usuario.dni==dni) {
            Some(u) => {
                u.validado = true;
                self.guardar()?;
                Ok(true)
            }
            None => Ok(false)
        }
    }

    fn existe_criptomoneda(&self, criptomoneda: &String) -> bool {
        self.criptomonedas.iter().find(|cripto| cripto.nombre==*criptomoneda).is_some()
    }

    fn existe_usuario(&self, dni: u32) -> bool {
        self.usuarios.iter().find(|u| u.dni==dni).is_some()
    }

    fn buscar_criptomoneda(&mut self, criptomoneda: &String) -> Option<&mut Criptomoneda> {
        self.criptomonedas.iter_mut().find(|cripto| cripto.nombre==*criptomoneda)
    }

    fn buscar_usuario(&mut self, dni: u32) -> Option<&mut Usuario> {
        self.usuarios.iter_mut().find(|u| u.dni==dni)
    }

    fn cotizacion(&self, _criptomoneda: &String) -> f32 {
        10.0
    }

    //MODULO A
    fn ingresar_fiat(&mut self,dni: u32,cantidad: f32) -> Result<bool, Error> {
        if if let Some(usuario) = self.buscar_usuario(dni) {
            if usuario.validado {
                usuario.fiat+=cantidad;
                true
            } else {
                false
            }
        } else {
            false
        } {
            self.transacciones.push(Transaccion::IngresoFiat(IngresoFiat {
                fecha:Fecha::now(),
                dni,
                cantidad,
            }));
            self.guardar()?;
            Ok(true)
        } else {
            Ok(false)
        }
    }

    //MODULO B
    fn comprar_cripto(&mut self,dni: u32,monto_fiat: f32,criptomoneda: String) -> Result<bool, Error> {
        if !self.existe_criptomoneda(&criptomoneda) {
            return Ok(false);
        }
        let precio = self.cotizacion(&criptomoneda);
        let mut cantidad = 0.0;
        if if let Some(usuario) = self.buscar_usuario(dni) {
            if usuario.validado && usuario.fiat>=monto_fiat {
                cantidad= monto_fiat/precio;
                usuario.fiat-=monto_fiat;
                match usuario.balance.iter_mut().find(|cripto| cripto.0==criptomoneda) {
                    Some(c) => c.1+=cantidad,
                    None => usuario.balance.push((criptomoneda.clone(), cantidad)),
                }
                true
            } else {
                false
            }
        } else {
            false
        } {
            self.transacciones.push(Transaccion::CompraCripto(CompraVentaCripto {
                fecha:Fecha::now(),
                dni,
                cripto:criptomoneda,
                cantidad,
                precio,
            }));
            self.guardar()?;
            Ok(true)
        } else {
            Ok(false)
        }
    }

    //MODULO C
    fn vender_cripto(&mut self,dni: u32,monto_cripto: f32,criptomoneda: String) -> Result<bool, Error> {
        if !self.existe_criptomoneda(&criptomoneda) {
            return Ok(false);
        }
        let mut exito = false;
        let precio = self.cotizacion(&criptomoneda);
        if let Some(usuario) = self.buscar_usuario(dni) {
            if usuario.validado  {
                if let Some((_, cantidad)) = usuario.balance.iter_mut().find(|(nombre,_)| *nombre==criptomoneda) {
                    if *cantidad>=monto_cripto {
                        let fiat = monto_cripto*precio;
                        usuario.fiat+=fiat;
                        *cantidad-=monto_cripto;
                        exito = true;
                    } 
                } 
            }
        } 
        if exito {
            self.transacciones.push(Transaccion::VentaCripto(CompraVentaCripto {
                fecha:Fecha::now(),
                dni,
                cripto:criptomoneda,
                cantidad:monto_cripto,
                precio,
            }));
            self.guardar()?;
        } 
        Ok(exito)
    }

    //MODULO D
    fn retirar_cripto(&mut self,dni: u32,monto_cripto: f32,criptomoneda: String,blockchain: String) -> Result<bool, Error> {
        let mut exito = false;
        if let Some(cripto) = self.buscar_criptomoneda(&criptomoneda) {
            if cripto.blockchains.iter().find(|b| b.nombre==blockchain).is_some() {
                exito = true;
            }
        }
        if exito {
            exito = false;
            let precio = self.cotizacion(&criptomoneda);
            if let Some(usuario) = self.buscar_usuario(dni) {
                if usuario.validado  {
                    if let Some((_, cantidad)) = usuario.balance.iter_mut().find(|(nombre,_)| *nombre==criptomoneda) {
                        if *cantidad>=monto_cripto {
                            *cantidad-=monto_cripto;
                            exito = true;
                        } 
                    } 
                }
            } 
            if exito {
                let n: u16 = random();
                let hash = format!("{}{}",blockchain,n);
                self.transacciones.push(Transaccion::RetiroCripto(RetiroCripto {
                    fecha:Fecha::now(),
                    dni,
                    cripto:criptomoneda,
                    blockchain,
                    hash,
                    cantidad:monto_cripto,
                    precio,
                }));
                self.guardar()?;
            } 
        }
        Ok(exito)
    }

    //MODULO E
    fn ingresar_cripto(&mut self,dni: u32,monto_cripto: f32,criptomoneda: String,blockchain: String) -> Result<bool, Error> {
        let mut exito = false;
        if let Some(cripto) = self.buscar_criptomoneda(&criptomoneda) {
            if cripto.blockchains.iter().find(|b| b.nombre==blockchain).is_some() {
                exito = true;
            }
        }
        if exito {
            exito = false;
            let precio = self.cotizacion(&criptomoneda);
            if let Some(usuario) = self.buscar_usuario(dni) {
                if usuario.validado  {
                    if let Some((_, cantidad)) = usuario.balance.iter_mut().find(|(nombre,_)| *nombre==criptomoneda) {
                        *cantidad+=monto_cripto;
                    } else {
                        usuario.balance.push((criptomoneda.clone(), monto_cripto.clone()));
                    } 
                    exito = true;
                }
            } 
            if exito {
                self.transacciones.push(Transaccion::IngresoCripto(IngresoCripto {
                    fecha:Fecha::now(),
                    dni,
                    cripto:criptomoneda,
                    blockchain,
                    cantidad:monto_cripto,
                    precio,
                }));
                self.guardar()?;
            } 
        }
        Ok(exito)
    }

    //MODULO F
    fn retirar_fiat(&mut self,dni: u32,monto_fiat: f32,medio_de_pago: Medio) -> Result<bool, Error> {
        let mut exito = false;
        if let Some(usuario) = self.buscar_usuario(dni) {
            if usuario.validado && usuario.fiat>=monto_fiat {
                usuario.fiat-=monto_fiat;
                self.transacciones.push(Transaccion::RetiroFiat(RetiroFiat {
                    fecha:Fecha::now(),
                    dni,
                    cantidad:monto_fiat,
                    medio:medio_de_pago,
                }));
                exito = true;
                self.guardar()?;
            }
        }
        Ok(exito)
    }

    fn guardar(&self) -> Result<(),Error> {
        let mut file = File::create(&self.path)?;
        let serialized = serde_json::to_string(&self)?;
        file.write_all(serialized.as_bytes())
    }

}

#[cfg(test)]
mod tests {
    use super::*;

    fn crear_plataforma(path: String) -> Plataforma {
        let blockchain1_bct = Blockchain{
            nombre:"blockchain1".to_string(),
            prefijo:"b1".to_string(),
        };
        let blockchain2_bct = Blockchain{
            nombre:"blockchain2".to_string(),
            prefijo:"b2".to_string(),
        };
        let btc = Criptomoneda{
            nombre:"bitcoin".to_string(),
            prefijo:"BTC".to_string(),
            blockchains:vec![blockchain1_bct,blockchain2_bct],
        };
        let blockchain1_eth = Blockchain{
            nombre:"blockchain1".to_string(),
            prefijo:"b1".to_string(),
        };
        let eth = Criptomoneda{
            nombre:"ethereum".to_string(),
            prefijo:"ETH".to_string(),
            blockchains:vec![blockchain1_eth],
        };
        let mut plataforma = Plataforma::new(Some(vec![btc,eth]),path).unwrap();
        plataforma.crear_usuario("n1".to_string(), "a1".to_string(), "e1".to_string(), 1).unwrap();
        plataforma.crear_usuario("n2".to_string(), "a2".to_string(), "e2".to_string(), 2).unwrap();
        plataforma.crear_usuario("n3".to_string(), "a3".to_string(), "e3".to_string(), 3).unwrap();
        plataforma
    }

    #[test]
    fn test_ingresar_fiat() {//MODULO A
        let path = String::from("archivos/tests/ingresar_fiat.json");
        let mut plataforma = crear_plataforma(path.clone());
        //usuario inexistente
        assert!(!plataforma.ingresar_fiat(0, 10.0).unwrap());
        
        //usuario sin validar
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(!plataforma.ingresar_fiat(1, 10.0).unwrap());

        //usuario validado
        assert!(!plataforma.validar_usuario(0).unwrap()); //validar usuario inexistente
        assert!(plataforma.validar_usuario(1).unwrap()); 
        assert!(plataforma.ingresar_fiat(1, 10.0).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,10.0);
        assert!(plataforma.ingresar_fiat(1, 10.0).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,20.0);

        assert_eq!(plataforma,Plataforma::build(&path).unwrap());

        //plataforma vacia
        assert!(!Plataforma::new(None,path).unwrap().ingresar_fiat(0, 0.0).unwrap());
    }

    #[test]
    fn test_comprar_cripto() {//MODULO B
        let path = String::from("archivos/tests/comprar_cripto.json");
        let mut plataforma = crear_plataforma(path.clone());
        //usuario inexistente
        assert!(!plataforma.comprar_cripto(0, 10.0, "bitcoin".to_string()).unwrap());
        
        //usuario sin validar
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(!plataforma.comprar_cripto(1, 10.0, "bitcoin".to_string()).unwrap());

        //usuario validado sin saldo
        assert!(plataforma.validar_usuario(1).unwrap()); 
        assert!(!plataforma.comprar_cripto(1, 10.0, "bitcoin".to_string()).unwrap());
        assert!(plataforma.usuarios[0].balance.is_empty());

        //usuario validado con saldo
        assert!(plataforma.ingresar_fiat(1, 10.0).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,10.0);
        assert!(plataforma.comprar_cripto(1, 10.0, "bitcoin".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].balance[0].1,1.0);
        assert_eq!(plataforma.usuarios[0].fiat,0.0);

        assert!(!plataforma.comprar_cripto(1, 10.0, "bitcoin".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].balance[0].1,1.0);

        assert!(plataforma.ingresar_fiat(1, 10.0).unwrap());
        assert!(plataforma.comprar_cripto(1, 10.0, "bitcoin".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].balance[0].1,2.0);

        assert_eq!(plataforma,Plataforma::build(&path).unwrap());

        //plataforma vacia
        assert!(!Plataforma::new(None,path).unwrap().comprar_cripto(0, 0.0, "bitcoin".to_string()).unwrap());
    }

    #[test]
    fn test_vender_cripto() {//MODULO C
        let path = String::from("archivos/tests/vender_cripto.json");
        let mut plataforma = crear_plataforma(path.clone());
        //usuario inexistente
        assert!(!plataforma.vender_cripto(0, 10.0, "bitcoin".to_string()).unwrap());
        
        //usuario sin validar
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(!plataforma.vender_cripto(1, 10.0, "bitcoin".to_string()).unwrap());

        //usuario validado sin saldo
        assert!(plataforma.validar_usuario(1).unwrap()); 
        assert!(!plataforma.vender_cripto(1, 10.0, "bitcoin".to_string()).unwrap());
        assert!(plataforma.usuarios[0].balance.is_empty());

        //usuario validado con saldo
        assert!(plataforma.ingresar_fiat(1, 20.0).unwrap());
        assert!(plataforma.comprar_cripto(1, 20.0, "bitcoin".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].balance[0].1,2.0);

        assert!(!plataforma.vender_cripto(1, 10.0, "ethereum".to_string()).unwrap()); //sin saldo
        assert!(!plataforma.vender_cripto(1, 10.0, "bitcoin".to_string()).unwrap());  //sin saldo suficiente
        assert!(!plataforma.vender_cripto(1, 10.0, "xdxdxdx".to_string()).unwrap());  //no exite la cripto
        
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(plataforma.vender_cripto(1, 1.0, "bitcoin".to_string()).unwrap());  
        assert_eq!(plataforma.usuarios[0].fiat,10.0);
        assert_eq!(plataforma.usuarios[0].balance[0].1,1.0);
        
        assert!(plataforma.vender_cripto(1, 1.0, "bitcoin".to_string()).unwrap());  
        assert_eq!(plataforma.usuarios[0].fiat,20.0);
        assert_eq!(plataforma.usuarios[0].balance[0].1,0.0);
        
        assert!(!plataforma.vender_cripto(1, 1.0, "bitcoin".to_string()).unwrap());  
        assert_eq!(plataforma.usuarios[0].fiat,20.0);
        assert_eq!(plataforma.usuarios[0].balance[0].1,0.0);

        assert_eq!(plataforma,Plataforma::build(&path).unwrap());

        //plataforma vacia
        assert!(!Plataforma::new(None,path).unwrap().vender_cripto(0, 0.0, "bitcoin".to_string()).unwrap());
    }


    #[test]
    fn test_retirar_cripto() {//MODULO D
        let path = String::from("archivos/tests/retirar_cripto.json");
        let mut plataforma = crear_plataforma(path.clone());
        //usuario inexistente
        assert!(!plataforma.retirar_cripto(0, 1.0, "bitcoin".to_string(),"b1".to_string()).unwrap());
        
        //usuario sin validar
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(!plataforma.retirar_cripto(0, 1.0, "bitcoin".to_string(),"b1".to_string()).unwrap());

        //usuario validado sin saldo
        assert!(plataforma.validar_usuario(1).unwrap()); 
        assert!(!plataforma.retirar_cripto(0, 1.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());
        assert!(plataforma.usuarios[0].balance.is_empty());

        //usuario validado con saldo
        assert!(plataforma.ingresar_fiat(1, 20.0).unwrap());
        assert!(plataforma.comprar_cripto(1, 20.0, "bitcoin".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].balance[0].1,2.0);

        assert!(!plataforma.retirar_cripto(1, 1.0, "ethereum".to_string(),"blockchain1".to_string()).unwrap()); //sin saldo
        assert!(!plataforma.retirar_cripto(1, 10.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap()); //sin saldo suficiente
        assert!(!plataforma.retirar_cripto(1, 1.0, "bitcoin".to_string(),"no".to_string()).unwrap()); //No existe la blockchain
        assert!(!plataforma.retirar_cripto(1, 1.0, "xdxdxdxd".to_string(),"xd".to_string()).unwrap()); //No existe la cripto ni la blockchain
        
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(plataforma.retirar_cripto(1, 1.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());  
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert_eq!(plataforma.usuarios[0].balance[0].1,1.0);
        
        assert!(plataforma.retirar_cripto(1, 1.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());  
        assert_eq!(plataforma.usuarios[0].fiat,00.0);
        assert_eq!(plataforma.usuarios[0].balance[0].1,0.0);
        
        assert!(!plataforma.retirar_cripto(1, 1.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());  
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert_eq!(plataforma.usuarios[0].balance[0].1,0.0);

        assert_eq!(plataforma,Plataforma::build(&path).unwrap());

        //plataforma vacia
        assert!(!Plataforma::new(None,path).unwrap().retirar_cripto(0, 0.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());
    }

    #[test]
    fn test_ingresar_cripto() {//MODULO E
        let path = String::from("archivos/tests/ingresar_cripto.json");
        let mut plataforma = crear_plataforma(path.clone());
        //usuario inexistente
        assert!(!plataforma.ingresar_cripto(0, 1.0, "bitcoin".to_string(),"b1".to_string()).unwrap());
        
        //usuario sin validar
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(plataforma.usuarios[0].balance.is_empty());
        assert!(!plataforma.ingresar_cripto(0, 1.0, "bitcoin".to_string(),"b1".to_string()).unwrap());

        //usuario validado 
        assert!(plataforma.validar_usuario(1).unwrap()); 
        assert!(!plataforma.ingresar_cripto(1, 1.0, "bitcoin".to_string(),"no".to_string()).unwrap()); //No existe la blockchain
        assert!(!plataforma.ingresar_cripto(1, 1.0, "xdxdxdxd".to_string(),"xd".to_string()).unwrap()); //No existe la cripto ni la blockchain
        
        assert!(plataforma.ingresar_cripto(1, 1.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert_eq!(plataforma.usuarios[0].balance.len(),1);
        assert_eq!(plataforma.usuarios[0].balance[0].1,1.0);

        assert!(plataforma.ingresar_cripto(1, 2.0, "ethereum".to_string(),"blockchain1".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert_eq!(plataforma.usuarios[0].balance.len(),2);
        assert_eq!(plataforma.usuarios[0].balance[0].1,1.0);
        assert_eq!(plataforma.usuarios[0].balance[1].1,2.0);

        assert!(plataforma.ingresar_cripto(1, 2.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert_eq!(plataforma.usuarios[0].balance.len(),2);
        assert_eq!(plataforma.usuarios[0].balance[0].1,3.0);
        assert_eq!(plataforma.usuarios[0].balance[1].1,2.0);

        assert!(plataforma.ingresar_cripto(1, 4.0, "ethereum".to_string(),"blockchain1".to_string()).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert_eq!(plataforma.usuarios[0].balance.len(),2);
        assert_eq!(plataforma.usuarios[0].balance[0].1,3.0);
        assert_eq!(plataforma.usuarios[0].balance[1].1,6.0);
        
        assert_eq!(plataforma,Plataforma::build(&path).unwrap());

        //plataforma vacia
        assert!(!Plataforma::new(None,path).unwrap().ingresar_cripto(0, 0.0, "bitcoin".to_string(),"blockchain1".to_string()).unwrap());
    }

    #[test]
    fn test_retirar_fiat() {//MODULO F
        let path = String::from("archivos/tests/retirar_fiat.json");
        let mut plataforma = crear_plataforma(path.clone());
        //usuario inexistente
        assert!(!plataforma.retirar_fiat(0, 10.0, Medio::MercadoPago).unwrap());
        
        //usuario sin validar
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(!plataforma.retirar_fiat(1, 10.0, Medio::Transferencia).unwrap());

        //usuario validado sin saldo
        assert!(plataforma.validar_usuario(1).unwrap()); 
        assert!(!plataforma.retirar_fiat(1, 10.0, Medio::MercadoPago).unwrap());

        //usuario validado con saldo
        assert!(plataforma.ingresar_fiat(1, 10.0).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,10.0);
        assert!(plataforma.retirar_fiat(1, 10.0, Medio::Transferencia).unwrap());
        assert_eq!(plataforma.usuarios[0].fiat,0.0);
        assert!(!plataforma.retirar_fiat(1, 10.0, Medio::MercadoPago).unwrap());

        assert_eq!(plataforma,Plataforma::build(&path).unwrap());

        //plataforma vacia
        assert!(!Plataforma::new(None,path).unwrap().retirar_fiat(0, 0.0, Medio::Transferencia).unwrap());
    }

    #[test]
    fn test_transacciones() {
        let path = String::from("archivos/tests/transacciones.json");
        let mut plataforma = crear_plataforma(path.clone());
        plataforma.usuarios[0].validado = true;

        //ingresar fiat: MODULO A
        assert!(plataforma.ingresar_fiat(1, 30.0).unwrap()); //transaccion 1
        assert!(!plataforma.ingresar_fiat(0, 30.0).unwrap());//operacion fallida: no genera transaccion
        let transaccion1 = Transaccion::IngresoFiat(IngresoFiat{
            fecha: Fecha::now(),
            dni:1,
            cantidad: 30.0,
        });
        assert_eq!(plataforma.transacciones.len(),1);
        assert_eq!(plataforma.transacciones[0],transaccion1);

        //comprar cripto: MODULO B
        assert!(plataforma.comprar_cripto(1, 30.0, "bitcoin".to_string()).unwrap()); //transaccion 2
        assert!(!plataforma.comprar_cripto(0, 30.0, "bitcoin".to_string()).unwrap());//operacion fallida: no genera transaccion
        let transaccion2 = Transaccion::CompraCripto(CompraVentaCripto{
            fecha: Fecha::now(),
            dni:1,
            cripto: "bitcoin".to_string(),
            cantidad: 3.0,
            precio: 10.0,
        });
        assert_eq!(plataforma.transacciones.len(),2);
        assert_eq!(plataforma.transacciones[1],transaccion2);

        //vender cripto: MODULO C
        assert!(plataforma.vender_cripto(1, 1.0, "bitcoin".to_string()).unwrap()); //transaccion 3
        assert!(!plataforma.vender_cripto(0, 1.0, "bitcoin".to_string()).unwrap());//operacion fallida: no genera transaccion
        let transaccion3 = Transaccion::VentaCripto(CompraVentaCripto{
            fecha: Fecha::now(),
            dni:1,
            cripto: "bitcoin".to_string(),
            cantidad: 1.0,
            precio: 10.0,
        });
        assert_eq!(plataforma.transacciones.len(),3);
        assert_eq!(plataforma.transacciones[2],transaccion3);

        //retirar cripto: MODULO D
        assert!(plataforma.retirar_cripto(1, 1.0, "bitcoin".to_string(), "blockchain1".to_string()).unwrap()); //transaccion 4
        assert!(!plataforma.retirar_cripto(0, 1.0, "bitcoin".to_string(), "blockchain1".to_string()).unwrap());//operacion fallida: no genera transaccion
        let hash = if let Transaccion::RetiroCripto(retiro) = &plataforma.transacciones[3] {
            retiro.hash.clone()
        } else {
            panic!("Error al obtener hash de transaccion");
        };
        let transaccion4 = Transaccion::RetiroCripto(RetiroCripto{
            fecha: Fecha::now(),
            dni:1,
            cripto: "bitcoin".to_string(),
            blockchain: "blockchain1".to_string(),
            hash,
            cantidad: 1.0,
            precio: 10.0,
        });
        assert_eq!(plataforma.transacciones.len(),4);
        assert_eq!(plataforma.transacciones[3],transaccion4);

        //ingresar cripto: MODULO E
        assert!(plataforma.ingresar_cripto(1, 1.0, "bitcoin".to_string(), "blockchain1".to_string()).unwrap()); //transaccion 5
        assert!(!plataforma.ingresar_cripto(0, 1.0, "bitcoin".to_string(), "blockchain1".to_string()).unwrap());//operacion fallida: no genera transaccion
        let transaccion5 = Transaccion::IngresoCripto(IngresoCripto{
            fecha: Fecha::now(),
            dni:1,
            cripto: "bitcoin".to_string(),
            blockchain: "blockchain1".to_string(),
            cantidad: 1.0,
            precio: 10.0,
        });
        assert_eq!(plataforma.transacciones.len(),5);
        assert_eq!(plataforma.transacciones[4],transaccion5);

        //retirar fiat: MODULO F
        assert!(plataforma.retirar_fiat(1, 10.0, Medio::MercadoPago).unwrap()); //transaccion 6
        assert!(!plataforma.retirar_fiat(0, 10.0, Medio::Transferencia).unwrap());//operacion fallida: no genera transaccion
        let transaccion6 = Transaccion::RetiroFiat(RetiroFiat{
            fecha: Fecha::now(),
            dni:1,
            cantidad: 10.0,
            medio: Medio::MercadoPago,
        });
        assert_eq!(plataforma.transacciones.len(),6);
        assert_eq!(plataforma.transacciones[5],transaccion6);

        assert_eq!(plataforma.transacciones,vec![transaccion1,
                                                 transaccion2,
                                                 transaccion3,
                                                 transaccion4,
                                                 transaccion5,
                                                 transaccion6]);

        assert_eq!(plataforma,Plataforma::build(&path).unwrap());
    }
}
