#!/usr/bin/env bash

cd "/Users/sl31/ergodox/ergodox_config"


mkdir tmp
ergodox_config="$(find $HOME/Downloads -name 'ergodox_ez_*.zip' | head -n 1)"
mv "$ergodox_config" ./tmp
cd tmp
unzip -o *.zip -d ./
cd -

rm -rf ergodox_ez_sean-ergodox-custom-fork_source
mv -fv tmp/ergodox_ez_sean-ergodox-custom-fork_source ./
git add ergodox_ez_sean-ergodox-custom-fork_source/*

# from https://scriptingosx.com/2018/08/user-interaction-from-bash-scripts/
displayfortext() { # $1: message
	message=${1:-"Message"}
	    /usr/bin/osascript <<-EndOfScript
			text returned of ¬
				(display dialog "$message" ¬
					default answer "" ¬
					buttons {"OK"} ¬
					default button "OK")
			EndOfScript
}

commit_msg=$(displayfortext "What is the commit message for new layout?")

git commit -m "$commit_msg"
git push

rm -rf tmp/
