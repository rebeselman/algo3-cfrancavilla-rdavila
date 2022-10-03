!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:22:59'!
* aMultiplier 
	^aMultiplier multiplyInteger: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:40:52'!
+ anAdder 
	^anAdder addMyselfToAnInteger: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:58:17'!
- aSubtrahend 
	^aSubtrahend subtractMyselfFromAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:41:08'!
/ aDivisor
	^ aDivisor divideAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:47:14'!
addMyselfToAFraccion: anAugend
	| resultFraccionNumerator resultFraccionDenominator |
	resultFraccionNumerator :=  (self * anAugend denominator) + anAugend numerator.
        resultFraccionDenominator := anAugend denominator.
        ^Fraccion with: (resultFraccionNumerator) over: (resultFraccionDenominator)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:37:09'!
addMyselfToAnInteger: anAugend.
	^self class with: anAugend integerValue + value.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/3/2022 09:06:39'!
calculateFibonacci
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:54:43'!
divideAFraccion: aDividend
	"aDividend / self"
	^(aDividend numerator)/(aDividend denominator * self).
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:36:20'!
divideAnInteger: aDividend
	^Fraccion with: aDividend over: self. ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/3/2022 09:05:47'!
fibonacci
	^self calculateFibonacci.
	
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:30:02'!
multiplyFraccion: aMultiplicand
	^Fraccion with: self * aMultiplicand numerator over: aMultiplicand denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:15:35'!
multiplyInteger: aMultiplicand
	^self class with: value * aMultiplicand integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:28:07'!
subtractMyselfFromAFraccion: aMinuend
	"aminuend - self"
	| newNumerator newDenominator |
	newNumerator := (aMinuend numerator) - (self * aMinuend denominator).
	newDenominator := aMinuend denominator.
	^newNumerator / newDenominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:52:32'!
subtractMyselfFromAnInteger: aMinuend
	^self class with: aMinuend integerValue - value.! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'rd 10/3/2022 08:42:16'!
isPositive
	^value > 0.! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'rd 10/3/2022 11:26:12'!
isMyType: aValue
	self subclassResponsibility! !

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'rd 10/3/2022 11:29:13'!
with: aValue 
	| selectedSubclass |
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	selectedSubclass := Entero subclasses detect: [:enteroSubclass | enteroSubclass isMyType: aValue].
	
	^selectedSubclass new initializeWith: aValue.
	! !


!classDefinition: #Cero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Cero methodsFor: 'fibonacci' stamp: 'rd 10/3/2022 09:00:44'!
calculateFibonacci
	| one |
	one := Entero with: 1.
	^one.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numeros-Parte2-Ejercicio'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'instance creation' stamp: 'rd 10/3/2022 11:26:25'!
isMyType: aValue
	^aValue = 0.! !


!classDefinition: #EnteroNegativo category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroNegativo methodsFor: 'fibonacci' stamp: 'rd 10/3/2022 08:59:44'!
calculateFibonacci
	^self error: Entero negativeFibonacciErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numeros-Parte2-Ejercicio'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'instance creation' stamp: 'rd 10/3/2022 11:26:35'!
isMyType: aValue
	^aValue < 0.! !


!classDefinition: #EnteroPositivo category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroPositivo methodsFor: 'fibonacci' stamp: 'rd 10/3/2022 09:04:51'!
calculateFibonacci
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	^ (self - one) calculateFibonacci + (self - two) calculateFibonacci.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivo class' category: 'Numeros-Parte2-Ejercicio'!
EnteroPositivo class
	instanceVariableNames: ''!

!EnteroPositivo class methodsFor: 'instance creation' stamp: 'rd 10/3/2022 11:26:45'!
isMyType: aValue
	^aValue > 0 and: [aValue ~= 1].
	! !


!classDefinition: #Uno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Uno methodsFor: 'fibonacci' stamp: 'rd 10/3/2022 09:01:07'!
calculateFibonacci
	| one |
	one := Entero with: 1.
	^one.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numeros-Parte2-Ejercicio'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'instance creation' stamp: 'rd 10/3/2022 11:26:53'!
isMyType: aValue
	^aValue = 1.! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:30:43'!
* aMultiplier
	^aMultiplier multiplyFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:47:30'!
+ anAdder 
	^anAdder addMyselfToAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:12:54'!
- aSubtrahend 
	^ aSubtrahend subtractMyselfFromAFraccion: self.

! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:50:59'!
/ aDivisor 
	^aDivisor divideAFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:44:56'!
addMyselfToAFraccion: anAugend
	| newNumerator newDenominator |
	newNumerator := (numerator * anAugend denominator) + (denominator * anAugend numerator).
	newDenominator := denominator * anAugend denominator.
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:40:35'!
addMyselfToAnInteger: anAugend
	| newNumerator newDenominator|
	newNumerator := (numerator + denominator * anAugend).
	newDenominator := denominator.
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:50:04'!
divideAFraccion: aDividend
	^(aDividend numerator * denominator) / (aDividend denominator * numerator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:40:32'!
divideAnInteger: aDividend.
	^(aDividend * denominator) / (numerator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:27:58'!
multiplyFraccion: aMultiplicand
	^(numerator * aMultiplicand numerator) / (denominator * aMultiplicand denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:20:01'!
multiplyInteger: aMultiplicand
	^Fraccion with: aMultiplicand * numerator over: denominator. ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 11:05:22'!
subtractMyselfFromAFraccion: aMinuend
	| newDenominator newNumerator |
	newNumerator := (denominator * aMinuend numerator) - (numerator * aMinuend denominator).
	newDenominator := denominator * aMinuend denominator.
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rd 10/2/2022 10:57:56'!
subtractMyselfFromAnInteger: aMinuend
	| newNumerator newDenominator |
	
	newNumerator := (aMinuend*denominator) - numerator.
	newDenominator := denominator.
	
	^newNumerator / newDenominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'rd 10/3/2022 11:46:14'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	"aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ]."
	"numerator := aNumerator.
	denominator := aDenominator"
	self subclassResponsibility.
! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'rd 10/3/2022 12:44:27'!
with: aDividend over: aDivisor
	| selectedSubclass |
	selectedSubclass := Fraccion subclasses detect: [:fraccionSubclass | fraccionSubclass isMyTypeaDividend:  aDividend aDivisor: aDivisor ].
	
	^selectedSubclass new initializeWith: aDividend over: aDivisor.
	! !


!classDefinition: #FraccionCero category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #FraccionCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!FraccionCero methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 11:47:45'!
initializeWith: aNumerator over: aDenominator
	^Entero with: 0.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionCero class' category: 'Numeros-Parte2-Ejercicio'!
FraccionCero class
	instanceVariableNames: ''!

!FraccionCero class methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:32:59'!
isMyTypeaDividend: aDividend aDivisor: aDivisor
	^aDividend isZero.! !


!classDefinition: #FraccionEntero category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #FraccionEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!FraccionEntero methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:36:22'!
initializeWith: aNumerator over: aDenominator
	| greatestCommonDivisor numeratorInteger|
	greatestCommonDivisor := aNumerator greatestCommonDivisorWith: aDenominator. 
	numeratorInteger := aNumerator // greatestCommonDivisor.
	^numeratorInteger.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionEntero class' category: 'Numeros-Parte2-Ejercicio'!
FraccionEntero class
	instanceVariableNames: ''!

!FraccionEntero class methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:33:51'!
isMyTypeaDividend: aDividend aDivisor: aDivisor
	| denominator greatestCommonDivisor |
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	denominator := aDivisor // greatestCommonDivisor.
	^denominator isOne.
	! !


!classDefinition: #FraccionIndeterminada category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #FraccionIndeterminada
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!FraccionIndeterminada methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:11:36'!
initializeWith: aDividend over: aDivisor
	^self error: FraccionIndeterminada canNotDivideByZeroErrorDescription. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionIndeterminada class' category: 'Numeros-Parte2-Ejercicio'!
FraccionIndeterminada class
	instanceVariableNames: ''!

!FraccionIndeterminada class methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:34:02'!
isMyTypeaDividend: aDividend aDivisor: aDivisor
	^aDivisor isZero.! !


!classDefinition: #FraccionNegativa category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #FraccionNegativa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!FraccionNegativa methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:00:51'!
initializeWith: aDividend over: aDivisor
	numerator := aDividend negated.
	denominator :=aDivisor negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionNegativa class' category: 'Numeros-Parte2-Ejercicio'!
FraccionNegativa class
	instanceVariableNames: ''!

!FraccionNegativa class methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:39:16'!
isMyTypeaDividend: aDividend aDivisor: aDivisor
	^aDivisor isNegative or: [aDividend isNegative].
	! !


!classDefinition: #FraccionPositiva category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #FraccionPositiva
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!FraccionPositiva methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 11:58:58'!
initializeWith: aDividend over: aDivisor
	| greatestCommonDivisor|
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionPositiva class' category: 'Numeros-Parte2-Ejercicio'!
FraccionPositiva class
	instanceVariableNames: ''!

!FraccionPositiva class methodsFor: 'as yet unclassified' stamp: 'rd 10/3/2022 12:41:08'!
isMyTypeaDividend: aDividend aDivisor: aDivisor
	| denominator greatestCommonDivisor |
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	denominator := aDivisor // greatestCommonDivisor.
	^((aDividend isPositive and: [aDivisor isPositive ]) or: [aDividend isNegative and: [aDivisor isNegative]])  and: [denominator isOne not].! !
