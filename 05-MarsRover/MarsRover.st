!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'initialPoint initialCardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'auxiliar' stamp: 'rd 11/3/2022 11:14:37'!
assertMarsRover: marsRover receivesThisCommands: aPacketOfCommands itsFinalPointIs: pointWhereMarsRoverShouldBe andIsPointingTo: directionWhereMarsRoverShouldPoint
	marsRover executeCommands: aPacketOfCommands.
	self assert: pointWhereMarsRoverShouldBe equals: marsRover currentPoint.
	self assert: (marsRover cardinalPoint isKindOf: directionWhereMarsRoverShouldPoint class).! !

!MarsRoverTest methodsFor: 'auxiliar' stamp: 'rd 11/1/2022 11:56:33'!
blockToFail: aBlockThatIsGonnaFail assertError: aBlockThatAssertsTheError
	self 
		should: aBlockThatIsGonnaFail 
		raise: Error
		withExceptionDo: aBlockThatAssertsTheError.! !


!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 10:49:02'!
setUp
	initialPoint := 0 @ 0.
	initialCardinalPoint := NorthDirection new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:05:37'!
test01MarsRoverDoesNothingIfThePacketOfCommandsIsEmpty
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := ''.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: initialPoint andIsPointingTo: initialCardinalPoint. 
	
	
	
	
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:07:57'!
test02MarsRoverCanMoveForward
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'F'.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: 0 @ 1 andIsPointingTo: initialCardinalPoint. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:16:46'!
test03MarsRoverCanMoveBackwards
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'B'.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: 0 @ -1 andIsPointingTo: initialCardinalPoint.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:17:52'!
test04MarsRoverCanChangeDirectionToWest
	| marsRover  commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'l'.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: 0 @ 0 andIsPointingTo: WestDirection new	.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:18:33'!
test05MarsRoverCanChangeDirectionToEast
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'r'.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: 0 @ 0 andIsPointingTo: EastDirection new	.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:19:01'!
test06MarsRoverCanChangeDirectionManyTimes
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'rrrlr'.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: 0 @ 0 andIsPointingTo: WestDirection new	.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 11:19:59'!
test07MarsRoverCanExecuteAPacketsOfCommandsPropperly
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'FBrrFFlFF'.
	self assertMarsRover: marsRover receivesThisCommands: commands itsFinalPointIs: 2 @ -2 andIsPointingTo: EastDirection new	.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rd 11/3/2022 10:49:02'!
test08MarsRoverCanNotExecuteInvalidCommands
	| marsRover commands|	
	marsRover := MarsRover initialPoint: initialPoint cardinalPoint: initialCardinalPoint.
	commands := 'Ñ'.

	self blockToFail: [ marsRover executeCommands: commands. ] assertError:  [ :anError |
			self assert: MarsRover marsRoverInvalidCommandErrorDescription equals: anError messageText ].
	
	
! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPoint cardinalPoint validCommands'
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


!MarsRover methodsFor: 'change direction' stamp: 'rd 11/3/2022 09:36:28'!
changeDirectionToLeft
	cardinalPoint := self cardinalPoint cardinalPointToLeftBasedOnMyDirection.! !

!MarsRover methodsFor: 'change direction' stamp: 'rd 11/3/2022 09:41:24'!
changeDirectionToRight
	cardinalPoint := self cardinalPoint cardinalPointToRightBasedOnMyDirection.! !


!MarsRover methodsFor: 'command processing' stamp: 'rd 11/3/2022 11:24:50'!
executeCommands: aPacketOfCommands
	|counter character |
	counter := 1.
	[counter <= aPacketOfCommands size] whileTrue: 
		[character := aPacketOfCommands at: counter.
			(validCommands identityIncludes: character) ifFalse: [^self error: MarsRover marsRoverInvalidCommandErrorDescription].
			character = $F ifTrue: [self moveForward].
			character = $B ifTrue: [self moveBackwards].
			character = $l ifTrue: [self changeDirectionToLeft].
			character = $r ifTrue: [self changeDirectionToRight].	
			counter := counter + 1].
	
	! !


!MarsRover methodsFor: 'initialization' stamp: 'rd 11/3/2022 11:23:49'!
initialize
	super initialize.
	validCommands := {$F. $B. $r. $l}.! !


!MarsRover methodsFor: 'moving' stamp: 'rd 11/3/2022 10:13:20'!
moveBackwards
	currentPoint := self cardinalPoint increaseOnePointBackwardsOnMyDirection: self currentPoint.
	! !

!MarsRover methodsFor: 'moving' stamp: 'rd 11/3/2022 10:12:27'!
moveForward
	currentPoint := self cardinalPoint increaseOnePointForwardOnMyDirection: self currentPoint.
	! !

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


!classDefinition: #PlaneOfMars category: 'MarsRover'!
Object subclass: #PlaneOfMars
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PlaneOfMars methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:14:20'!
increaseOnePointBackwardsOnMyDirection: aPoint
	^self subclassResponsibility.! !

!PlaneOfMars methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:04:45'!
increaseOnePointForwardOnMyDirection: anObject
	self subclassResponsibility.! !


!PlaneOfMars methodsFor: 'rotate' stamp: 'rd 11/3/2022 09:32:13'!
cardinalPointToLeftBasedOnMyDirection
	^self subclassResponsibility.! !

!PlaneOfMars methodsFor: 'rotate' stamp: 'rd 11/3/2022 09:41:08'!
cardinalPointToRightBasedOnMyDirection
	^self subclassResponsibility.! !


!classDefinition: #EastDirection category: 'MarsRover'!
PlaneOfMars subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:15:18'!
increaseOnePointBackwardsOnMyDirection: aPoint
	^((aPoint x) -1) @ (aPoint y)! !

!EastDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:06:02'!
increaseOnePointForwardOnMyDirection: aPoint
	^((aPoint x) +1) @ (aPoint y).! !


!EastDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:21:01'!
cardinalPointToLeftBasedOnMyDirection
	^NorthDirection new.! !

!EastDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:21:17'!
cardinalPointToRightBasedOnMyDirection
	^SouthDirection new.! !


!classDefinition: #NorthDirection category: 'MarsRover'!
PlaneOfMars subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:21:34'!
cardinalPointToLeftBasedOnMyDirection
	^WestDirection new.! !

!NorthDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:20:31'!
cardinalPointToRightBasedOnMyDirection
	^EastDirection new.! !


!NorthDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:16:08'!
increaseOnePointBackwardsOnMyDirection: aPoint
	^(aPoint x) @ ((aPoint y) - 1)! !

!NorthDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:06:49'!
increaseOnePointForwardOnMyDirection: aPoint
	^ (aPoint x) @ ((aPoint y) + 1)! !


!classDefinition: #SouthDirection category: 'MarsRover'!
PlaneOfMars subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:20:31'!
cardinalPointToLeftBasedOnMyDirection
	^EastDirection new.! !

!SouthDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:21:34'!
cardinalPointToRightBasedOnMyDirection
	^WestDirection new.! !


!SouthDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:17:13'!
increaseOnePointBackwardsOnMyDirection: aPoint
	^(aPoint x) @ ((aPoint y) + 1)! !

!SouthDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:07:29'!
increaseOnePointForwardOnMyDirection: aPoint
	^ (aPoint x) @ ((aPoint y) - 1)! !


!classDefinition: #WestDirection category: 'MarsRover'!
PlaneOfMars subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:21:17'!
cardinalPointToLeftBasedOnMyDirection
	^SouthDirection new.! !

!WestDirection methodsFor: 'rotate' stamp: 'rd 11/3/2022 10:21:01'!
cardinalPointToRightBasedOnMyDirection
	^NorthDirection new.! !


!WestDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:17:47'!
increaseOnePointBackwardsOnMyDirection: aPoint
	^((aPoint x) +1) @ (aPoint y)! !

!WestDirection methodsFor: 'move a point' stamp: 'rd 11/3/2022 10:08:05'!
increaseOnePointForwardOnMyDirection: aPoint
	^ ((aPoint x) -1) @ (aPoint y)! !
