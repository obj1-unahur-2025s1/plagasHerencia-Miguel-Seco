class Hogar{
  var nivelDeMugre
  var confort
  method nivelDeMugre() = nivelDeMugre
  method confort()= confort
  method esBueno() = nivelDeMugre / 2 <= confort
  method ataqueDePlaga(unaPlaga){
    nivelDeMugre = nivelDeMugre + unaPlaga.nivelDeDaño() 
  }
}

class Huerta{
  var capacidadDeProduccion
  method capacidadDeProduccion() = capacidadDeProduccion
  method esBueno()= capacidadDeProduccion > nivel.nivelMinimo()
  method ataqueDePlaga(unaPlaga){
    if (unaPlaga.transmitenEnfermedades()){capacidadDeProduccion = 0.max(capacidadDeProduccion - (unaPlaga.nivelDeDaño() / 10) + 10)} else capacidadDeProduccion = 0.max(capacidadDeProduccion - unaPlaga.nivelDeDaño() / 10)
    
  }
}

 
object nivel {
  var property nivelMinimo = 1
}

class Mascota{
  var nivelDeSalud
  method nivelDeSalud() = nivelDeSalud
  method esBueno() = nivelDeSalud > 250
  method ataqueDePlaga(unaPlaga){
    if( unaPlaga.transmitenEnfermedades()) nivelDeSalud = 0.max(nivelDeSalud - unaPlaga.nivelDeDaño())
  }
}

class Barrio{
  const property elementos = []

  method agregarElemento(unElemento){
    elementos.add(unElemento)
  }
  method esCopado() = self.elementosBuenos() > self.elementosNoBuenos()
  method elementosBuenos() = elementos.count({e => e.esBueno()})
  method elementosNoBuenos() = elementos.count({e => not e.esBueno()})
}

class Plagas{
  var poblacion
  method nivelDeDaño()
  method transmitenEnfermedades() = poblacion >= 10
  method efectoDelAtaque(){
    poblacion = poblacion + self.porcentajePoblacion()
  }
  method porcentajePoblacion() = poblacion * 0.1

  method atacarElemento(unElemento){
    unElemento.ataqueDePlaga(self)
    self.efectoDelAtaque()
  }
}

class PlagaDeCucarachas inherits Plagas{

  var pesoPromedio
  override method nivelDeDaño() = poblacion / 2
  override method transmitenEnfermedades() = super() && pesoPromedio >= 10
  override method efectoDelAtaque(){
    super()
    pesoPromedio = pesoPromedio + 2
  }

}

class PlagaDePulgas inherits Plagas{

  override method nivelDeDaño() = poblacion * 2

}
class PlagaDeGarrapatas inherits PlagaDePulgas{
 
  override method porcentajePoblacion() = poblacion * 0.2
 
}
class PlagaDeMosquitos inherits Plagas{

override method nivelDeDaño() = poblacion 
override method transmitenEnfermedades() = super() and poblacion % 3 == 0

}