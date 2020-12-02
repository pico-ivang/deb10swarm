#!/bin/bash

iptables -t nat -A POSTROUTING -o kvmbr0 -j MASQUERADE
