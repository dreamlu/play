package main

import (
	"github.com/xanzy/go-gitlab"
	"log"
	"os/exec"
)

func main() {
	// gitlab
	git, err := gitlab.NewClient("ykjxJCh7fzSYQu34hbEi")
	if err != nil {
		log.Println(err)
		return
	}
	b := true
	opt := &gitlab.ListProjectsOptions{Owned: &b, ListOptions: gitlab.ListOptions{
		PerPage: 200,
	}}
	projects, _, err := git.Projects.ListProjects(opt)
	if err != nil {
		log.Println(err)
		return
	}
	for _, v := range projects {
		//log.Println(v.Name, v.PathWithNamespace)
		pullUrl := "https://gitlab.com/" + v.PathWithNamespace
		res, err := exec.Command("bash", "-c", "cd repository && mkdir "+v.Path).Output()
		log.Println(res, err)
		res, err = exec.Command("bash", "-c", "./git.sh "+v.Path+" "+pullUrl).Output()
		log.Println(string(res), err)
	}
}
