#!/usr/bin/env io 
		
doFile("Builder.io")

Builder Book(
	{
		"author" : "Tate",
		"isbn" : "9781934356593"
	},
	"Seven Language in Seven Weeks",
	Translation(
		{
			"language" : "Chinese",
			"isbn" : "9787115276117"
		},
		"Qi Zhou Qi Yue Yan"
	),
	Tag(
		"Programe Languages"
	),
	Tag(
		"General"
	)
)
