extends Node

var level_1 = {
		"id": "1",
		"title": "Getting Started",
		"problem": "Since this is the start, the task is simple. Simply put inputs into the outputs",
		"inputs":[1, 2, 3],
		"outputs":[1, 2, 3],
		"buttons":{
			"inp":{
				"count": 3
			},
			"out":{
				"count": 3
			},
			"art":{
				"count": 0
			},
			"jump":{
				"count": 0
			},
			"jumpif":{
				"count": 0
			},
			"store":{
				"count": 0
			},
			"copy":{
				"count": 0
			}
		}
	}
var level_2 = {
	"id": "2",
	"title": "Now let's jump!",
	"problem": "Just like the last time but with the JUMP card",
	"inputs":[1, 2, 3],
	"outputs":[1, 2, 3],
	"buttons":{
		"inp":{
			"count": 1
		},
		"out":{
			"count": 1
		},
		"art":{
			"count": 0
		},
		"jump":{
			"count": 1
		},
		"jumpif":{
			"count": 0
		},
		"store":{
			"count": 0
		},
		"copy":{
			"count": 0
		}
	}
}

var level_3 = {
	"id": "3",
	"title": "Shuffle shuffle",
	"problem": "Swap the values of every 2 numbers",
	"inputs":[1, 2, 3, 4],
	"outputs":[2, 1, 4, 3],
	"buttons":{
		"inp":{
			"count": 3
		},
		"out":{
			"count": 3
		},
		"art":{
			"count": 0
		},
		"jump":{
			"count": 3
		},
		"jumpif":{
			"count": 0
		},
		"store":{
			"count": 3
		},
		"copy":{
			"count": 3
		}
	}
}

var level_4 = {
	"id": "4",
	"title": "Squares",
	"problem": "Output the square of each input",
	"inputs":[1, 2, 3, 4],
	"outputs":[1, 4, 9, 16],
	"buttons":{
		"inp":{
			"count": 1
		},
		"out":{
			"count": 1
		},
		"art":{
			"count": 1
		},
		"jump":{
			"count": 1
		},
		"jumpif":{
			"count": 0
		},
		"store":{
			"count": 1
		},
		"copy":{
			"count": 0
		}
	}
}

var level_5 = {
	"id": "5",
	"title": "Does it even?",
	"problem": "If the number is even, send it to the output",
	"inputs":[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
	"outputs":[0, 2, 4, 6, 8, 10],
	"buttons":{
		"inp":{
			"count": 5
		},
		"out":{
			"count": 5
		},
		"art":{
			"count": 5
		},
		"jump":{
			"count": 5
		},
		"jumpif":{
			"count": 5
		},
		"store":{
			"count": 5
		},
		"copy":{
			"count": 5
		}
	}
}

var level_6 = {
	"id": "6",
	"title": "The other world",
	"problem": "Submit the opposite of each value",
	"inputs":[0, 56, 12, - 67, - 32, 12],
	"outputs":[0, - 56, - 12, 67, 32, - 12],
	"buttons":{
		"inp":{
			"count": 5
		},
		"out":{
			"count": 5
		},
		"art":{
			"count": 5
		},
		"jump":{
			"count": 5
		},
		"jumpif":{
			"count": 5
		},
		"store":{
			"count": 5
		},
		"copy":{
			"count": 5
		}
	}
}

var level_7 = {
	"id": "7",
	"title": "A little breather",
	"problem": "Simply output the product of each value",
	"inputs":[18, 57, 32, 0],
	"outputs":[1026, 32383, 0],
	"buttons":{
		"inp":{
			"count": 5
		},
		"out":{
			"count": 5
		},
		"art":{
			"count": 5
		},
		"jump":{
			"count": 5
		},
		"jumpif":{
			"count": 5
		},
		"store":{
			"count": 5
		},
		"copy":{
			"count": 5
		}
	}
}

var level_8 = {
	"id": "8",
	"title": "Collatz Sequence",
	"problem": "If the current value is even, divide it by 2. If it is odd, multiply it by 3 then add 1. The first 4 numbers given are manipulators and shall not be included in the main process of your algorithm.",
	"inputs":[0, 1, 2, 3, 13],
	"outputs":[13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
	"buttons":{
		"inp":{
			"count": 5
		},
		"out":{
			"count": 5
		},
		"art":{
			"count": 5
		},
		"jump":{
			"count": 5
		},
		"jumpif":{
			"count": 5
		},
		"store":{
			"count": 5
		},
		"copy":{
			"count": 5
		}
	}
}

var level_9 = {
	"id": "9",
	"title": "Fibonacci Sequence",
	"problem": "The fibonnaci sequence is a sequence in which each number is the sum of the two preceding ones",
	"inputs":[0, 1],
	"outputs":[0, 1, 1, 2, 3, 5],
	"buttons":{
		"inp":{
			"count": 5
		},
		"out":{
			"count": 5
		},
		"art":{
			"count": 5
		},
		"jump":{
			"count": 5
		},
		"jumpif":{
			"count": 5
		},
		"store":{
			"count": 5
		},
		"copy":{
			"count": 5
		}
	}
}
var level_10 = {
	"id": "10",
	"title": "FizzBuzz?",
	"problem": "FizzBuzz is a common algorithm for interviews. The algorithm shall output if the value is divisible by 3 or 5.",
	"inputs":[0, 3, 5, 10, 16, 25],
	"outputs":[0, 3, 5, 10, 25],
	"buttons":{
		"inp":{
			"count": 5
		},
		"out":{
			"count": 5
		},
		"art":{
			"count": 5
		},
		"jump":{
			"count": 5
		},
		"jumpif":{
			"count": 5
		},
		"store":{
			"count": 5
		},
		"copy":{
			"count": 5
		}
	}
}

var levels = [
	level_1,
	level_2,
	level_3,
	level_4,
	level_5,
	level_6,
	level_7,
	level_8,
	level_9,
	level_10
]

func get_premade_levels():
	return levels
