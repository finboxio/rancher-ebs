#! /bin/sh

if [[ "$EBS_VOLUME_NAME" != "" ]]; then
  ebs-volume-setup
fi
