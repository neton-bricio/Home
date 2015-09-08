#!/bin/bash

SELECTED_PATHS="${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}"
NB_SELECTED_PATHS=`echo -n "${SELECTED_PATHS}" | wc -l | awk '{print $1}'`

ATTACHMENTS=""

for ((i=${NB_SELECTED_PATHS}; i>0; i--)) ; do
	CURRENT_PATH=`echo -n "${SELECTED_PATHS}" | head -n${i} | tail -n1`
	if test -d "${CURRENT_PATH}" ; then
		FILES_FOUND=`find "${CURRENT_PATH}" -type f`
		NB_FILES_FOUND=`echo "${FILES_FOUND}" | wc -l | awk '{print $1}'`
		for ((j=${NB_FILES_FOUND}; j>0; j--)) ; do
			CURRENT_FILE=`echo "${FILES_FOUND}" | head -n${j} | tail -n1`
			ATTACHMENTS="${ATTACHMENTS} \"${CURRENT_FILE}\""
		done
	else
		ATTACHMENTS="${ATTACHMENTS} \"${CURRENT_PATH}\""
	fi
done

echo "-----------"
echo ${ATTACHMENTS}

eval "thunderbird --compose --attach ${ATTACHMENTS}"

