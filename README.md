#  To-do list

### Description
*To-do list* is an application for showing list of tasks. Tasks can be to checked as completed or uncompleted. Tasks splits on prioritets.

# Features
	
	* Realized OOP conception,created single service for managering tasks. This service has a functionality:
		
		- getting list of all tasks
		- getting list of completed tasks
		- getting list of uncompleted tasks
		- add a task to list
		- delete a task from list

	Added opportunity to store 2 types of tasks: Regular and Important. For important tasks added prioritets of execution: high, medium and low. Also added automatic calculation deadlines for tasks with important prioritets.
	
	* Realized MVC conception. Created user interfase with opportunity to check a task. Overdue tasks stand out in list.
	
	* Realized MVP conception
	
	* Added autorization screen
	
	* Realized Clean Swift conception
	
	* Realized UNIT Tests for business logic in project
	
	* Business Logic is separated and connected as separate package "ToDoListBusinessLogic"
	
# Project build

	##Swiftlint
	
	* Project using *swiftlint* for code style control. All adding moduls must correspond rules.
	For install *swiftlint* use Brew in your terminal. Do the following steps:
	- brew install
	- brew install swiftlint
	Then in buld phases of your project you need to add new script (with name "Run Swiftlint") and fill the text place with:
	
		export PATH="$PATH:/opt/homebrew/bin"
		if which swiftlint > /dev/null; then
			swiftlint
		else
			echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
			exit 1
		fi
		
	Checkbox "Based on dependancy analysis" must be false.
	
	## PinLayout
	
	* Project using *PinLayout* for screen layout.
		For install *PinLayout*:
		- from Xcode, select from the menu File > Swift Packages > Add Package Dependency
		- specify the URL https://github.com/layoutBox/PinLayout
