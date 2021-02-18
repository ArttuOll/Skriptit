#!/usr/bin/env bash

# Lopeta suorittaminen, jos jokin komento epäonnistuu
set -e

# Tätä skriptiä käytetään käynnistämään tmux-sessioita, jotka liittyvät tiettyyn projektiin. Ideana
# on käynnistää kerralla kaikki projektin tarvitsemat pääteikkunat (esim. palvelinohjelmisto,
# asiakasohjelmisto) ja laittaa ne taustalle, avaten samalla yhden ikkunan projektin parissa
# työskentelyä varten. Vähemmän turhia ikkunoita ja ohjelmien käynnistelyä, enemmän keskittymistä
# olennaiseen.

FOOD_COMPONENT_DASHBOARD="$HOME/ohjelmistoprojektit/food_component_dashboard/food_component_dashboard"
FINER_ELI="$HOME/ohjelmistoprojektit/finer_eli"

session=$1
case "$session" in
    "--fcd")
        readonly session_name="FCD"
        tmux new-session -s "$session_name" -d -n primary -c "$FOOD_COMPONENT_DASHBOARD/src"
        tmux new-window -t "$session_name": -n server -d -c "$FINER_ELI" "npm start"
        tmux new-window -t "$session_name": -n client -d -c "$FOOD_COMPONENT_DASHBOARD" "npm start"
        tmux new-window -t "$session_name": -n chromium -d -c "$FOOD_COMPONENT_DASHBOARD" "chromium --remote-debugging-port=9222 --disable-gpu --disable-web-security --user-data-dir=/tmp/chromium_dev 127.0.0.1:3000"
        tmux new-window -t "$session_name": -n git -d -c "$FOOD_COMPONENT_DASHBOARD/src"

        tmux a -t "$session_name"
        ;;

    *) echo "Unavailable command... $session"
esac
