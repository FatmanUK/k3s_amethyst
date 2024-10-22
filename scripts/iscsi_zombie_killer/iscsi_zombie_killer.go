package main

// Use to delete zombified iSCSI sessions.

import (
	"os"
	"fmt"
	"strconv"
	"github.com/u-root/iscsinl"
)

func die_if(e error, s string) {
	if e != nil {
		fmt.Println(s + ": %s\n", e)
		os.Exit(1)
	}
}

func main() {
	ipc, err := iscsinl.ConnectNetlink()
	die_if(err, "Error connecting to netlink")

	sid, _ := strconv.Atoi(os.Args[1])
	err = ipc.StopConnection(uint32(sid), 0)
	die_if(err, "Error stopping connection")

	err = ipc.DestroyConnection(uint32(sid), 0)
	die_if(err, "Error destroying connection")

	err = ipc.DestroySession(uint32(sid))
	die_if(err, "Error destroying session")
}
