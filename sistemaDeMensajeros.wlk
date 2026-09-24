//Empresa de Mensajeria
object empresaMensajera{
const conjuntoDeMensajeros = []
const paquetesAEntregar = []
var facturacion = 0

method contratar(mensajero)  {
	conjuntoDeMensajeros.add(mensajero)
}

method despedir(mensajero){
	conjuntoDeMensajeros.remove(mensajero)
}

method despedirATodos(mensajeros){
	conjuntoDeMensajeros.clear()
}

method esGrande(){
	return	conjuntoDeMensajeros.size() > 2
}

method puedeSerEntregadoPorPrimerEmpleado(paqueteDado){
	return if (conjuntoDeMensajeros.isEmpty()) false 
				else paqueteDado.puedeSerEntregadoPor(conjuntoDeMensajeros.first())
}

method pesoDeUltimoMensajero(){
	return conjuntoDeMensajeros.last().peso()
}

method puedeSerEntregado(paqueteAEntregar) { 
	return conjuntoDeMensajeros.any({ m => paqueteAEntregar.puedeSerEntregadoPor(m)}) 
}

method mensajerosQuePuedenLlevar(paqueteAEntregar) { 
	return conjuntoDeMensajeros.filter({ m => paqueteAEntregar.puedeSerEntregadoPor(m) }) 
}

method tieneSobrepeso() { 
	return if (conjuntoDeMensajeros.isEmpty()) false 
	else (conjuntoDeMensajeros.sum({ m => m.peso() }) / 
			conjuntoDeMensajeros.size()) > 500 
}
method facturacion() = facturacion 
method reiniciarFacturacion() { 
	facturacion = 0 
} 
method paquetesPendientes() = paquetesAEntregar 

method vaciarPendientes() { 
	paquetesAEntregar.clear() 
}

method enviarTodos(conjuntoDePaquetes) { 
	conjuntoDePaquetes.forEach({ p => self.enviar(p) }) 
}

method enviarPendienteMasCaro() { 
	const entregables = paquetesAEntregar.filter({ p => 
	self.puedeSerEntregado(p) }) 
	if (not entregables.isEmpty()) { 
		const masCaro = entregables.max({ p => p.precio() }) 
		paquetesAEntregar.remove(masCaro) 
		self.enviar(masCaro) 
	} 
}
method enviar(paqueteAEntregar) { 
	const posibles = self.mensajerosQuePuedenLlevar(paqueteAEntregar) 
	if (not posibles.isEmpty()) { facturacion += 
	paqueteAEntregar.precio() } 
	else { paquetesAEntregar.add(paqueteAEntregar) } }
}

//Mensajeros
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
	var vehiculo = camion 
	method pesoPropio() = pesoPropio 
	method pesoPropio(_pesoPropio) { 
		pesoPropio = _pesoPropio 
	} 
	method vehiculo() = vehiculo 
	method vehiculo(_vehiculo) { 
		vehiculo = _vehiculo 
	}
	method peso(){
		return pesoPropio + vehiculo.peso()
	}
}
object dexter { 
	method peso() = 77 
	method puedeLlamar() = true 
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
	} 
	method peso() = 500 + (acoplados * 500) 
}

// Paquete  
object paquete { 
	var estaPago = false 
	var destino = laMatrix
	var precio  = 50
	method estaPago() = estaPago 
	method pagar() { 
		estaPago = true 
	} 
	method destino() = destino 
	method destino(_destino) { 
		destino = _destino 
	} 
	method precio() = precio
	method precio(_precio) { 
		precio = _precio 
	} 
	method puedeSerEntregadoPor(mensajero){ 
		return estaPago && destino.dejaPasar(mensajero) 
		} 
}
object paquetito { 
	method estaPago(){
		return true
	} 
	method precio() = 0 
	method puedeSerEntregadoPor(mensajero){ 
		return true
		} 
}

object paquetonViajero{
	const destinos = []
	var montoPagado = 0

	method destinos() = destinos
	
	method agregarDestino(destino){
		destinos.add(destino)
	}

	method limpiarDestinos(){
		destinos.clear();
		montoPagado = 0
	}

	method precio(){
		return destinos.size() * 100
	}

	method pagar(montoAPagar){
		montoPagado += montoAPagar 
	}

	method estaPago(){
		return montoPagado >= self.precio() 
	}

	method puedeSerEntregadoPor(mensajero){
		return self.estaPago() && destinos.all({ d => d.dejaPasar(mensajero) })
	}
}

object paqueteExtra { 
	var estaPago = false 
	method estaPago() = estaPago 
	method pagar() { 
		estaPago = true 
	} 
	method precio() = 200 
	method puedeSerEntregadoPor(mensajero) { 
		return estaPago && mensajero.puedeLlamar() && 
		mensajero.peso() < 80
	}
}
// Destinos  
object puenteDeBrooklyn { 
	method precio() = 150 
	method dejaPasar(mensajero) = mensajero.peso() <= 1000 
	} 

object laMatrix { 
	method precio() = 500 
	method dejaPasar(mensajero) = mensajero.puedeLlamar() 
	}
