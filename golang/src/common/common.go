package common

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"runtime/pprof"
	"runtime"
	"path/filepath"
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

func Relative(file string) string {
	_, filename, _, _ := runtime.Caller(1)
	return filepath.Join(filepath.Dir(filename), file)
}