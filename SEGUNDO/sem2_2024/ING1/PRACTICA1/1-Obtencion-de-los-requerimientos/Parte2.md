## Parte II Problemas.

#### a) Indicar para cada problema quiénes podrían ser los Stakeholders, los puntos de vista y las fuentes de información.
1. En un sistema de registro de asistencia a través de técnicas biométricas (huella digital) de estudiantes
universitarios para la cátedra de Ingeniería I. Este sistema se alimentará de un listado otorgado por la oficina
de alumnos de la facultad. Además, necesita la autorización del Jefe de Trabajos Prácticos del turno
correspondiente para luego los alumnos poder registrar el presente. También, el profesor a cargo de la
materia podrá consultar y listar el estado de cada alumno perteneciente a su cátedra. El sistema sólo se
utilizará en el ámbito de la facultad de Informática y deberá adecuarse a la reglamentación sobre privacidad
de los datos en el ámbito de la misma.

2. Se desea desarrollar un sistema para gestionar y administrar la atención de pacientes en una clínica privada
especializada en tratamientos alérgicos. Cuando un paciente nuevo es ingresado a la clínica el empleado
registra todos sus datos personales, posteriormente un enfermero registra los controles y realiza las
anotaciones habituales (temperatura, presión, peso, reacciones alérgicas etc.). Luego, el paciente es derivado
con alguno de los doctores de la clínica, quién registra qué tratamientos deberá realizar. El médico también
se encarga de registrar si el paciente debe quedar internado y debe mantener su historia clínica durante el
período que dure el tratamiento. Se sabe que el director de la clínica puede consultar las historias clínicas de
todos los pacientes. El sistema debe adecuarse a las normativas impuestas por el ministerio de salud de la
provincia de Bs As.
#### b) Habiendo resuelto los problemas presentados, ¿por qué considera que los requerimientos de los distintos stakeholders podrían entrar en conflicto?

#### Resolucion:
##### A-1)
Stakeholders:
- Oficina de alumnos
- Secretaria de la facultad / Decano
- JTP
- Alumnos
- Profesores

Puntos de vista:
- Interactuadores:
    - JTP
    - Alumnos
    - Profesores
- Indirecto:
    - Oficina de alumnos
    - Secretaria de la facultad / Decano
- Dominio: 
    - Tecnicas biometricas
    - Reglamentacion sobre privacidad

Fuentes de informacion:
- Documentacion: 
    - Uso de tecnicas biometricas
    - Reglamentacion sobre privacidad
- Stakeholders
- Especificaciones de sistemas similares

##### A-2)
Stakeholders:
- Propietario
- Director
- Pacientes
- Empleado
- Enfermeros
- Doctores

Puntos de vista:
- Interactuadores:
    - Director
    - Empleado
    - Enfermeros
    - Doctores
- Indirecto:
    - Propietario
    - Pacientes
- Dominio: 
    - Medicina
    - Tratamientos de alergia
    - Reglamentacion del ministerio de salud

Fuentes de informacion:
- Documentacion: 
    - Tratamiento de alergias
    - Reglamentacion del ministerio de salud
- Stakeholders
- Especificaciones de sistemas similares

##### B-1)
Podria generarse un conflicto porque los alumnos no desean que se guarden ciertos datos de ellos, o estan en desacuerdo en como se protegen. Otro conflicto seria que el JTP tenga que autorizar a los alumnos manualmente o que la oficina de alumnos deba cargar los datos de los alumnos uno por uno.

##### B-2)
Podria generarse un conflicto entre varios stakeholders sobre los datos que se recopilan. Por ejemplo, los doctores o el director pueden estar interesados en recopilar ciertos datos mas, mientras que el paciente, el empleado y el enfermero pueden estar en contra (el primero por ser sus datos, los siguientes por tener ellos que recopilarlos).
