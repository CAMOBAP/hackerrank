package common

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"runtime/pprof"
)

func StartProfile() {
	f, _ := os.Create(fmt.Sprintf("%s_cpu.pprof", os.Args[0]))
	pprof.StartCPUProfile(f)
	go func() {
		c := make(chan os.Signal, 1)
		signal.Notify(c, os.Interrupt, os.Kill, syscall.SIGTERM)
		for range c {
			pprof.StopCPUProfile()
		}
	}()
}

func StopProfile() {
	defer pprof.StopCPUProfile()
}
