PS1="\W $ "
alias ls='ls -G'

alias p="pushd"
alias o="popd"
alias d="dirs"

alias gc='git commit'
alias gco='git checkout'
alias gaa='git add -A'
alias gap='git add -p'
alias ga='git add'
alias gl='git lg'
alias gp='git push'
alias gpnew='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias gpu='git pull'
alias gpur='git pull --rebase'
alias grb='git rebase'
alias gs='git status'
alias gb='git branch'
alias gai='git add -i'
alias gd='git diff'
alias gdc='git diff --cached'
alias gr='git reset'
alias grs1='git reset --soft HEAD~1'
alias gf='git fetch'
alias gsu='git submodule update'
alias gitcount='git rev-list HEAD --count'
alias gitdeletemerged='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

alias glate='gaa; gc -m "latest"; gp;'
alias glat='gaa; gc -m "latest";'

alias ber='bundle exec rake'



export PATH="~/bin:/usr/local/bin:/usr/local/Cellar/ruby/2.0.0-p247/bin:$PATH"


function gcon() {

    if [ -z "${1}" ] 
        then
        echo "missing name argument"
        return 0
    fi

    name=${1}
    branch_output=$(git branch | grep ${name})
    branches=(${branch_output//$'\n'/ })
    branch=${branches[i]}
    git checkout ${branch}
}

function gbs() {

    if [ -z "${1}" ] 
        then
        echo "missing name argument"
        return 0
    fi

    name=${1}
    branch_output="$(git branch | grep ${name})"
    echo "${branch_output}"
}

_git_branches() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`git branch`

	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
	return 0
}

complete -F _git_branches gco
complete -F _git_branches gb
