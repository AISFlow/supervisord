package main

import "fmt"

var VERSION = "v1.0.0"

type VersionCommand struct{}

func (v VersionCommand) Execute(args []string) error {
	fmt.Println(VERSION)
	return nil
}

func init() {
	parser.AddCommand("version",
		"show the version of supervisor",
		"display the supervisor version",
		&VersionCommand{})
}
