!classDefinition: #Cliente category: 'Probando_clases'!
Object subclass: #Cliente
	instanceVariableNames: 'name DateOfBirth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Probando_clases'!


!Cliente methodsFor: 'as yet unclassified' stamp: 'rd 9/25/2022 16:12:00'!
initializeNamed: aName bornOn: aDateOfBirth
	name := aName.
	DateOfBirth := aDateOfBirth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cliente class' category: 'Probando_clases'!
Cliente class
	instanceVariableNames: ''!

!Cliente class methodsFor: 'metodos de clase cliente' stamp: 'rd 9/25/2022 15:43:25'!
named: aName bornOn: aDateOfBirth 
	^self new initializeNamed: aName bornOn: aDateOfBirth.! !
