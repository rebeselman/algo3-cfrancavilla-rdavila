!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: 'anElement anElementOne anElementTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'stack-tests' stamp: 'rd 10/6/2022 21:01:09'!
setUp
	anElementOne := 'An element for testing one'.
	anElementTwo := 'An element fot testing two'.
	! !

!StackTest methodsFor: 'stack-tests' stamp: 'rd 10/6/2022 19:55:56'!
test01StackShouldBeEmptyWhenCreated
	| stack |
	stack := Stack new.
	self assert: stack isEmpty! !

!StackTest methodsFor: 'stack-tests' stamp: 'rd 10/6/2022 20:35:44'!
test02AnElementCanBePushIntoStack
	| stack |
	stack := Stack new.
	stack push: anElement.
	self deny: stack isEmpty.
! !

!StackTest methodsFor: 'stack-tests' stamp: 'rd 10/6/2022 20:39:42'!
test03AnElementCanbePoppedFromStack
	| stack |
	stack := Stack new.
	stack push: anElement.
	stack pop.
	self assert: stack isEmpty.
	! !

!StackTest methodsFor: 'stack-tests' stamp: 'rd 10/7/2022 08:18:51'!
test04StackIsLIFO
	| stack  poppedElement |
	stack := Stack new.
	stack push: anElementOne.
	stack push: anElementTwo.
	poppedElement := stack pop.
	self assert: poppedElement = anElementTwo.! !

!StackTest methodsFor: 'stack-tests' stamp: 'rd 10/6/2022 20:43:36'!
test05LastPushedElementCanBeObtainedWithoutRemovingIt
	| stack lastPushedElement |
	stack := Stack new.
	stack push: anElement.
	lastPushedElement := stack top.
	self assert: (lastPushedElement = anElement & stack isEmpty not).
	! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'stack firstItemIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'adding' stamp: 'rd 10/7/2022 08:16:19'!
push: anObject
	stack addFirst: anObject! !


!Stack methodsFor: 'removing' stamp: 'rd 10/7/2022 08:14:33'!
pop
	| removedLastItem |
	stack isEmpty not ifTrue: [ removedLastItem := stack removeFirst. ^removedLastItem]
	! !


!Stack methodsFor: 'accessing' stamp: 'rd 10/7/2022 08:16:00'!
isEmpty
	^stack isEmpty.! !

!Stack methodsFor: 'accessing' stamp: 'rd 10/7/2022 08:17:20'!
top
	stack isEmpty not ifTrue: [^stack at: firstItemIndex].! !


!Stack methodsFor: 'initialization' stamp: 'rd 10/7/2022 08:16:58'!
initialize
	super initialize.
	stack := OrderedCollection new.
	firstItemIndex := 1.
! !
