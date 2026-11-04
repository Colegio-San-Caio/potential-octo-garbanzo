cd ~/kai; python3 holla_proxy.py > /dev/null 2>&1 &
cd ~/potential-octo-garbanzo && bash autoexec.sh

# --- BOA84 AUTO-PILOT - OneEyeMail + HOLLA + BOA84 ---
# Runs ONCE per Termux open, never blocks you if no internet
if [ -d "$HOME/potential-octo-garbanzo" ] && [ -z "$BOA84_RAN" ]; then
  export BOA84_RAN=1
  cd "$HOME/potential-octo-garbanzo" 2>/dev/null && {
    echo "BOA84 AUTO-PILOT - Starting..."
    bash autoexec.sh 2>/dev/null | tail -3
    # Auto-push ONLY if something changed
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
      git add -A 2>/dev/null
      git commit -m "AUTO-PILOT - ns sync on Termux open - $(date '+%Y-%m-%d %H:%M')" 2>/dev/null
      git pull --rebase 2>/dev/null
      git push origin HEAD 2>/dev/null && echo "BOA84 AUTO-PILOT - PUSHED - OK"
    else
      echo "BOA84 AUTO-PILOT - Nothing new - OK"
    fi
    cd "$HOME" 2>/dev/null
  }
fi
# --- END BOA84 AUTO-PILOT ---

# --- BOA84 TERMUX AUTO-PILOT ---
if [ -z "$BOA84_RAN" ]; then
  export BOA84_RAN=1
  bash "$HOME/potential-octo-garbanzo/boa84-termux.sh" 2>/dev/null | tail -5
fi
# --- END BOA84 TERMUX ---
