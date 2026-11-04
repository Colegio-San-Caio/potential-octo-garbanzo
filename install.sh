#!/bin/bash
# BOA84 install.sh - Linux + Mac + Termux - ONE COMMAND SETUP
# Usage: bash install.sh
echo "BOA84 INSTALL - Linux/Mac/Termux - Starting..."
# Copy boa84.bashrc lines into ~/.bashrc if not already there
grep -q "BOA84 AUTO-PILOT" ~/.bashrc 2>/dev/null || cat boa84.bashrc >> ~/.bashrc
echo "BOA84 - .bashrc installed - OK"
bash autoexec.sh
echo "BOA84 INSTALL - OK - Reopen terminal to test AUTO-PILOT"
