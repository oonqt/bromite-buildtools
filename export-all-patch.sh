#!/bin/bash

VERSION=$(cat ~/bromite/build/RELEASE)
CURRENT_RELEASE=$(git -C ~/chromium/src/ rev-parse --verify refs/tags/$VERSION)

ALLPATCHS_E=$(git -C ~/chromium/src/ rev-list HEAD...$CURRENT_RELEASE)

mkdir ~/bromite/build/patches-new

NO_NAME=1

for patch in $ALLPATCHS_E; do

	PATCH_FILE=$(git -C ~/chromium/src/ show -s $patch | grep FILE: | sed 's/FILE://g' | sed 's/^[ \t]*//;s/[ \t]*$//')
	if [ -z "$PATCH_FILE" ]
	then
		#git -C ~/chromium/src/ show -s $patch
		PATCH_FILE=$(git -C ~/chromium/src/ show -s $patch | tail -n 1)
		if [[ "$PATCH_FILE" != *".patch" ]]; then
			PATCH_FILE=$NO_NAME.patch
			NO_NAME=$NO_NAME.1
			echo No Name ${NO_NAME}, press return
		fi

		read  -n 1
	fi

	bash ~/buildtools/export-single-patch.sh $patch $PATCH_FILE

done
