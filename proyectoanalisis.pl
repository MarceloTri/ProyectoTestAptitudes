/* Copyright @Trinidad Oscar 28/09/2021 */

:-use_module(library(pce)). /* libreria para trabajar modo gráfico */
:-use_module(library(pce_style_item)). /* activa los estilos de la libreria */
:- dynamic color/2.


/*interfaz principal*/
comenzar:- new(D,dialog('SISTEMA EXPERTO DE PERFIL ACADEMICO',size(560,400))), /* crea la ventana principal */

new(Label1,label(text,'............UNIVERSIDAD GRAN ASUNCION - UNIGRAN.............')), /* label contenido texto información inicial*/

  send(Label1,colour,black),
new(Label2,label(text,'........................... SISTEMAS EXPERTOS..............................')),
  send(Label2,colour,black),
new(Label3,label(text,' ')),
  send(Label3,colour,blue),
new(Label4,label(text,'Sistema Experto de perfil academico para la elección')),
  send(Label4,colour,blue),
new(Label5,label(text,'de Carrera Universitaria, enfocado principalmente en areas')),
  send(Label5,colour,blue),
new(Label6,label(text,'de la "Tecnologia".')),
  send(Label6,colour,blue),
new(Label7,label(text,'')),
  send(Label7,colour,blue),
new(Label8,label(text,'Diseñado por : Oscar Trinidad ')),
  send(Label8,colour,black),
new(Label9,label(text,'Estudiante de Ingeniería en Informatica')),
  send(Label9,colour,black),
  new(Label12,label(text,'')),
  send(Label12,colour,blue),

 /*llamada a los label declarados anteriorente*/

 send(D,append(Label1)),
 send(D,append(Label2)),
 send(D,append(Label3)),
 send(D,append(Label4)),
 send(D,append(Label5)),
 send(D,append(Label6)),
 send(D,append(Label7)),
 send(D,append(Label8)),
 send(D,append(Label9)),
 send(D,append(Label12)),

 /* declaracion de botones ventana principal */

 new(Boton1,button('COMENZAR',and(message(@prolog,main),
 and(message(D,open),message(D,free))))),
 send(Boton1,colour,blue),
 new(Bcancelar,button('CANCELAR',and(message(D,destroy),message(D,free)))),

 send(Bcancelar,colour,blue),
 send(D,append(Boton1)),
 send(D,append(Bcancelar)),
 send(D,open_centered).

:-comenzar.

/*llamada al metodo principal*/


main:-
  new(D2, dialog('ANALISIS DE PERFIL ACADEMICO-ELIGIENDO TU CARRERA',size(500,400))),
  new(Label10, label(nombre,'')),send(Label10,colour,red),


  new(@texto,label(text,'Una vez finalizado el TEST podras ver los resultados:')),
  new(@respl,label(text,'')),
  new(Salir,button('Salir',and(message(D2,destroy),message(D2,free)))),

/*creación del boton para dar inicio al TEST.*/

  new(@boton,button('INICIAR TEST',message(@prolog,botones))),

  send(D2, append(Label10)),
  new(@btncarrera,button('¿diagnostica?')),
  send(D2, display,Label10,point(10,20)),
  send(D2, display,@boton,point(100,80)),
  send(D2, display,@texto,point(50,40)),
  send(D2, display,Salir,point(125,200)),
  send(D2, display,@respl,point(70,90)),
  send(D2,open_centered).


/* Aqui se especifican las hipotesis de las vocaciones, se esta haciendo
uso del corte (!.) para que una vez validada una hipotesis se detenga y
de el resultado.*/

hipotesis(analista_de_software):-analista_de_software,!.
hipotesis(disenador_de_software):-diseñador_de_software,!.
hipotesis(desarrollador_web):-desarrollador_web,!.
hipotesis(desconocido). /* no existe */

/* detalle de las profesiones, se declaran todas las preguntas para las
vocaiones.*/

/*Analista de Software*/
analista_de_software:-vocacion_analista_de_software,
  consultar('¿Vas por delante y eres capaz de ver lo que va a ocurrir?'),
  consultar('¿Busca soluciones generales y no particulares?'),
  consultar('¿Crea documentacion que ayuda a comprender el sistema?'),
  consultar('¿Es capaz de escuchar y comprender el problema para resolverlo?'),
  consultar('¿Es practico para resolver problemas?').

/*Diseñador de Software*/
diseñador_de_software:-vocacion_diseñador_de_software,
  consultar('¿Analiza las necesidades de los usuarios?'),
  consultar('¿Entiende las capacidades y lenguajes de las computadoras para diseñar software eficaz?'),
  consultar('¿Trabaja sobre muchas partes del sistema simultaneamente prestando atencion a los detalles?'),
  consultar('¿Es capaz de resolver problemas que surgen en el proceso de diseño?').


/*Desarrollador Web*/
desarrollador_web:-vocacion_desarrollador_web,
  consultar('¿Tiene conocimieto de programacion en Html?'),
  consultar('¿Es capaz de administrar servidores?'),
  consultar('¿Tiene capacidad para resolver problemas?'),
  consultar('¿Tiene conocimiento de programacion del lado del cliente y servidor?').


/*ELIGIENDO LA VOCACIÓN*/

desconocido:-se_desconoce_vocacion.


/*reglas para tomar la ruta*/

vocacion_analista_de_software:-consultar('¿Vas por delante y eres capaz de ver lo que va a ocurrir?'),!.
vocacion_diseñador_de_software:-consultar('¿Analiza las necesidades de los usuarios?'),!.
vocacion_desarrollador_web:-consultar('¿Tiene conocimieto de programacion en Html?'),!.

/* creación del dialogo de preguntas. */


:-dynamic si/1,no/1.

preguntar(Problema):-new(Di,dialog('PERFIL ACADEMICO')),
  new(L9,label(texto,'responde las siguientes preguntas')),
  new(L10,label(text,Problema)),

/* botones de verificación*/


  new(B1,button(si,and(message(Di,return,si)))),
  new(B2,button(no,and(message(Di,return,no)))),
  send(Di,gap,size(25,25)),

/* agregar label y botones de cuadro de dialogos*/

  send(Di,append(L9)),
  send(Di,append(L10)),
  send(Di,append(B1)),
  send(Di,append(B2)),

  send(Di,default_button,si),
  send(Di,open_centered), get(Di,confirm,Answer),
  write(Answer), send(Di,destroy),

/*llamdo a la sentencia para determinar respuestas*/

 (   (Answer==si)->assert(si(Problema));
 assert(no(Problema)),fail).


consultar(S):-(si(S)->true; (no(S)->fail; preguntar(S))).
deshacer:-retract(si(_)),fail.
deshacer:-retract(no(_)),fail.
deshacer.


botones:-borrado,
  send(@boton,free),
  send(@btncarrera,free),

/* Vocacion de acuerdo a respuestas dadas*/

hipotesis(Vocacion),
  send(@texto, selection('De acuerdo a sus respuestas su Perfil Academico es:')),
  send(@respl,selection(Vocacion)),
  new(@boton, button('Iniciar su evaluacion',message(@prolog, botones))),
  send(Menu, display,@boton,point(40,600)),
  send(Menu, display,@btncarrera,point(20,50)),
  send(Menu, append, new(Ayuda, popup(Ayuda))),
  deshacer.

borrado:-send(@respl,selection('')).



