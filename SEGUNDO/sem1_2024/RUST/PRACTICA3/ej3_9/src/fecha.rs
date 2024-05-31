#[derive(PartialEq, Debug, Clone)]
pub struct Fecha {
    dia: u32,
    mes: u32,
    anno: u32,
}

impl Fecha {
    pub fn new(dia: u32, mes: u32, anno: u32) -> Fecha {
        Fecha{
            dia,
            mes,
            anno,
        }
    }

    pub fn es_bisiesto(&self) -> bool {
        self.anno % 4 == 0
    }

    pub fn dias(&self) -> [u32; 12] { 
        if self.es_bisiesto() {
            [31,29,31,30,31,30,31,31,30,31,30,31]
        } else {
            [31,28,31,30,31,30,31,31,30,31,30,31]
        }
    }

    pub fn es_fecha_valida(&self) -> bool {
        (self.dia<=self.dias()[(self.mes-1) as usize]) && self.mes<=12
    }

    pub fn sumas_dias(&mut self,dias: u32) {
        let mut left = dias;
        while left>365 {
            self.anno+=1;
            left-=365;
        }

        let mut dias_por_mes = self.dias(); 

        while left>dias_por_mes[(self.mes-1) as usize] {
            left-=dias_por_mes[(self.mes-1) as usize];
            self.mes+=1;
            if self.mes == 13 {
                self.mes = 1;
                self.anno+=1;
                dias_por_mes = self.dias();
            }
        }

        while left>0 {
            self.dia+=1;
            left-=1;
            if self.dia>dias_por_mes[(self.mes-1) as usize] {
                self.dia = 1;
                self.mes+=1;
                if self.mes == 13 {
                    self.mes = 1;
                    self.anno += 1;
                    dias_por_mes = self.dias();
                } 
            }
        }
    }

    pub fn restar_dias(&mut self,dias: u32) {
        let mut left = dias;
        while left>365 {
            self.anno-=1;
            left-=365;
        }

        let mut dias_por_mes = self.dias(); 

        while left>dias_por_mes[(self.mes-1) as usize] {
            left-=dias_por_mes[(self.mes-1) as usize];
            self.mes-=1;
            if self.mes == 0 {
                self.mes = 12;
                self.anno-=1;
                dias_por_mes = self.dias();
            }
        }

        while left>0 {
            self.dia-=1;
            left-=1;
            if self.dia == 0 {
                self.mes-=1;
                self.dia = dias_por_mes[(self.mes-1) as usize];
                if self.mes == 0 {
                    self.mes = 12;
                    self.anno -= 1;
                    dias_por_mes = self.dias();
                } 
            }
        }
    }

    pub fn es_mayor(&self,fecha: Fecha) -> bool {
        let mut mayor = false;
        if self.anno>fecha.anno {
            mayor = true;
        } else if self.anno == fecha.anno {
            if self.mes>fecha.mes {
                mayor = true;
            } else if self.mes == fecha.mes {
                if self.dia>fecha.dia {
                    mayor = true;
                }
            }
        }
        mayor
    }
}

#[cfg(test)]
mod fecha_tests {
    use super::Fecha;

    #[test]
    fn Fecha() {
        let dia = 26;
        let mes = 4;
        let anno = 2024;
        let mut fecha1 = Fecha::new(26,4,2024);
        let fecha2 = Fecha{dia,mes,anno};
        assert_eq!(fecha1,fecha2);
        assert!(fecha1.es_fecha_valida());
        assert!(fecha1.es_bisiesto());
        fecha1.sumas_dias(1000);
        assert_eq!(fecha1,Fecha{dia:21,mes:1,anno:2027});
        fecha1.restar_dias(1000);
        assert_eq!(fecha1,fecha2);
        assert!(!fecha1.es_mayor(fecha2));

    }


}