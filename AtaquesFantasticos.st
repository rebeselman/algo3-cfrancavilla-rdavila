!classDefinition: #CombatienteHumanoArthas category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatienteHumanoArthas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteHumanoArthas class' category: 'AtaquesFantasticosPaso2'!
CombatienteHumanoArthas class
	instanceVariableNames: 'enemigos puntosDeVida dañoAInfligir dañoAAbsorber estrategia agilidadIntrinseca'!

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'cf 9/19/2022 14:03:08'!
atacar
	| enemigoElegido |
	enemigos isEmpty ifTrue: [ ^ self ].
	enemigoElegido := estrategia value: enemigos.
	self atacarA: enemigoElegido.! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'cf 9/19/2022 14:03:33'!
atacarA: unCombatiente
	self estaFueraDeCombate ifTrue: [ ^ self ].
	unCombatiente recibirDaño: dañoAInfligir.! !

!CombatienteHumanoArthas class methodsFor: 'combate'!
