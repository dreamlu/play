package main

import (
	"fmt"
	"os/exec"
)

func gitCmd(args ...string) ([]byte, error) {

	cmd := exec.Command("git", args...)

	////创建获取命令输出管道
	//stdout, err := cmd.StdoutPipe()
	//if err != nil {
	//	fmt.Printf("Error:can not obtain stdout pipe for command:%s\n", err)
	//	return nil, err
	//}
	//
	////执行命令
	//if err := cmd.Start(); err != nil {
	//	fmt.Println("Error:The command is err,", err)
	//	return nil, err
	//}

	//读取所有输出
	bytes, err := cmd.Output()
	if err != nil {
		fmt.Println("ReadAll Stdout:", err.Error())
		return nil, err
	}

	//if err := cmd.Wait(); err != nil {
	//	fmt.Println("wait:", err.Error())
	//	return nil, err
	//}
	return bytes, nil
}
