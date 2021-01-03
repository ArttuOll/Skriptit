#!/bin/bash

NETWORK="wlp2s0"

ifconfig $NETWORK down

macchanger --random --bia $NETWORK

ifconfig $NETWORK up
