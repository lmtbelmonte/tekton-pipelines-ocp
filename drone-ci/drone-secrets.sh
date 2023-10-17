#!/bin/bash

drone secret add --name image_registry \
--data quay.io https://github.com/lmt-cbs/pacman-kikd.git
drone secret add --name image_registry_user \
--data USER https://github.com/lmt-cbs/pacman-kikd.git
drone secret add --name image_registry_password \
--data PASSWORD https://github.com/lmt-cbs/pacman-kikd.git
drone secret add --name destination_image \
--data quay.io/lmtbelmonte01/pacman-kikd.git https://github.com/lmt-cbs/pacman-kikd.git
