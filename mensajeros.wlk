// Mensajeros  
object jeanGray { 
	method peso() = 65 
	method puedeLlamar() = true 
}

object neo { 
	var tieneCredito = true 
	method tieneCredito() = tieneCredito 
	method tieneCredito(_tieneCredito) { 
		tieneCredito = _tieneCredito 
		}
	method peso() = 0 
	method puedeLlamar() = tieneCredito
}

object saraConnor { 
	var pesoPropio = 70
	var vehiculo = moto 
	method pesoPropio() = pesoPropio 
	method pesoPropio(_pesoPropio) { 
		pesoPropio = _pesoPropio 
	} 
	method vehiculo() = vehiculo 
	method vehiculo(_vehiculo) { 
		vehiculo = _vehiculo 
	}
}

// Vehículos  
object moto { 
	method peso() = 100
} 
object camion { 
var acoplados = 0
	method acoplados() = acoplados 
	method acoplados(_acoplados) { 
		acoplados = _acoplados 
	} method peso() = 500 + (acoplados * 500) 
}

// Paquete  
object paquete { 
	var estaPago = false 
	var destino = laMatrix 
	method estaPago() = estaPago 
	method pagar() { 
		estaPago = true 
	} 
	method destino() = destino 
	method destino(_destino) { 
		destino = _destino 
	} method precio() = destino.precio() 
	method puedeSerEntregadoPor(mensajero){ 
		return estaPago && destino.dejaPasar(mensajero) 
		} 
}
// Destinos  
object puenteDeBrooklyn { 
	method precio() = 150 
	method dejaPasar(mensajero) = mensajero.peso() <- 1000 
	} 

object laMatrix { 
	method precio() = 500 
	method dejaPasar(mensajero) = mensajero.puedeLlamar() 
	}
