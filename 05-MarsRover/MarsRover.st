!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'auxiliar' stamp: 'rd 11/1/2022 11:56:33'!
blockToFail: aBlockThatIsGonnaFail assertError: aBlockThatAssertsTheError
	self 
		should: aBlockThatIsGonnaFail 
		raise: Error
		withExceptionDo: aBlockThatAssertsTheError.! !


!MarsRoverTest methodsFor: 'testing' stamp: 'rd 10/31/2022 12:33:06'!
test01MarsRoverisInitializedInTheRightPosition
	| marsRover initialPoint cardinalPoint|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	self assert: initialPoint equals: marsRover currentPoint.
	self assert: cardinalPoint equals: marsRover cardinalPoint.
	
	
	
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 10/31/2022 12:29:14'!
test02MarsRoverCanMoveForward
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'F'.
	marsRover executeCommands: commands.
	self assert:  0 @ 1 equals: marsRover currentPoint.
	self assert: $N equals: marsRover cardinalPoint .
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 10/31/2022 12:31:01'!
test03MarsRoverCanMoveBackwards
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'B'.
	marsRover executeCommands: commands.
	self assert: 0 @ -1 equals: marsRover currentPoint.
	self assert: $N equals: marsRover cardinalPoint .
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/1/2022 11:30:05'!
test04MarsRoverCanChangeDirectionToWest
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'l'.
	marsRover executeCommands: commands.
	self assert: 0 @ 0 equals: marsRover currentPoint.
	self assert: $O equals: marsRover cardinalPoint .
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 10/31/2022 12:49:35'!
test05MarsRoverCanChangeDirectionToEast
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'r'.
	marsRover executeCommands: commands.
	self assert: 0 @ 0 equals: marsRover currentPoint.
	self assert: $E equals: marsRover cardinalPoint .
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/1/2022 11:30:13'!
test06MarsRoverCanChangeDirectionManyTimes
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'rrrlr'.
	marsRover executeCommands: commands.
	self assert: 0 @ 0 equals: marsRover currentPoint.
	self assert: $O equals: marsRover cardinalPoint .
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/1/2022 11:32:58'!
test07MarsRoverCanExecuteAPacketsOfCommandsPropperly
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'FBrrFFlFF'.
	marsRover executeCommands: commands.
	self assert: 2 @ -2 equals: marsRover currentPoint.
	self assert: $E equals: marsRover cardinalPoint .
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/1/2022 11:57:20'!
test08MarsRoverCanNotExecuteInvalidCommands
	| marsRover initialPoint cardinalPoint commands|	
	initialPoint := 0 @ 0.
	cardinalPoint := $N.
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: cardinalPoint.
	commands := 'Ñ'.

	self blockToFail: [ marsRover executeCommands: commands. ] assertError:  [ :anError |
			self assert: MarsRover marsRoverInvalidCommandErrorDescription equals: anError messageText ].
	
	
! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPoint cardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'instance creation' stamp: 'rd 10/31/2022 12:23:03'!
initializeWithInitialPoint: aPoint andACardinalPoint: aCardinalPoint.
	currentPoint := aPoint.
	cardinalPoint := aCardinalPoint.! !


!MarsRover methodsFor: 'accessing' stamp: 'rd 10/31/2022 12:22:26'!
cardinalPoint
	^cardinalPoint! !

!MarsRover methodsFor: 'accessing' stamp: 'rd 10/31/2022 11:24:34'!
currentPoint
	^currentPoint! !


!MarsRover methodsFor: 'change direction' stamp: 'rd 10/31/2022 13:37:00'!
changeDirectionToLeft
	self cardinalPoint = $N ifTrue: [cardinalPoint := $O.^self].
	self cardinalPoint = $S ifTrue: [cardinalPoint := $E.^self].
	self cardinalPoint = $E ifTrue: [cardinalPoint := $N.^self].
	self cardinalPoint = $O ifTrue: [cardinalPoint := $S.^self]	.! !

!MarsRover methodsFor: 'change direction' stamp: 'rd 10/31/2022 13:37:41'!
changeDirectionToRight
	self cardinalPoint = $N ifTrue: [cardinalPoint := $E.^self].
	self cardinalPoint = $S ifTrue: [cardinalPoint := $O.^self].
	self cardinalPoint = $E ifTrue: [cardinalPoint := $S.^self].
	self cardinalPoint = $O ifTrue: [cardinalPoint := $N.^self]	.! !


!MarsRover methodsFor: 'command processing' stamp: 'rd 11/1/2022 12:21:30'!
executeCommands: aPacketOfCommands
	|counter character validCommands|
	validCommands :={$F. $B. $l. $r}.
	counter := 1.
	[counter <= aPacketOfCommands size] whileTrue: 
		[character := aPacketOfCommands at: counter.
			(validCommands identityIncludes: character) ifFalse: 
			[^self error: MarsRover marsRoverInvalidCommandErrorDescription].
			character = $F ifTrue: [self moveForward].
			character = $B ifTrue: [self moveBackwards].
			character = $l ifTrue: [self changeDirectionToLeft].
			character = $r ifTrue: [self changeDirectionToRight].
			
			counter := counter + 1].
	
	! !



!MarsRover methodsFor: 'moving' stamp: 'rd 11/1/2022 11:24:51'!
moveBackwards
	self cardinalPoint = $N ifTrue: [currentPoint := (currentPoint x) @ ((currentPoint y) - 1).^self].
	self cardinalPoint = $S ifTrue: [currentPoint := (currentPoint x) @ ((currentPoint y) + 1).^self].
	self cardinalPoint = $E ifTrue: [currentPoint := ((currentPoint x) -1) @ (currentPoint y).^self].
	self cardinalPoint = $O ifTrue: [currentPoint := ((currentPoint x) +1) @ (currentPoint y).^self]	.! !

!MarsRover methodsFor: 'moving' stamp: 'rd 11/1/2022 11:25:13'!
moveForward
	self cardinalPoint = $N ifTrue: [currentPoint := currentPoint x @ ((currentPoint y) + 1).^self].
	self cardinalPoint = $S ifTrue: [currentPoint := currentPoint x @ ((currentPoint y) - 1).^self].
	self cardinalPoint = $E ifTrue: [currentPoint := ((currentPoint x) +1) @ (currentPoint y).^self].
	self cardinalPoint = $O ifTrue: [currentPoint := ((currentPoint x) -1) @ (currentPoint y).^self]	.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: 'initialPoint'!

!MarsRover class methodsFor: 'class initialization' stamp: 'rd 10/31/2022 12:15:16'!
initialPoint: aPoint cardinalPoint: aCardinalPoint
	^self new initializeWithInitialPoint: aPoint andACardinalPoint: aCardinalPoint.! !


!MarsRover class methodsFor: 'error messages' stamp: 'rd 11/1/2022 11:59:54'!
marsRoverInvalidCommandErrorDescription
	^'Invalid command'! !
