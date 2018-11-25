#!/bin/bash

while true; do

  choice=$(zenity  --list  --text "Leaving so soon?"\
    --list --column "Action:"\
    --title="Leaving how? " \
    Logoff\
    Shutdown\
    Restart);

  case "${choice}" in

    "Shutdown" )
    #!/bin/bash
    zenity --question --text "Poweroff now?" echo $?
    case $? in
        0)sudo /sbin/shutdown -h now;;
        1) exit;;
    esac
    ;;

    "Restart" )
    #!/bin/bash
    zenity --question --text "Restart now?" echo $?
    case $? in
      0)sudo /sbin/shutdown -r now;;
      1) exit;;
    esac
    ;;

    "Logoff" )
    #!/bin/bash
    zenity --question --text "Quit i3 and return to gdm?" echo $?
    case $? in
      0) i3-msg exit;;
      1) exit;;
    esac
    ;;

    *)

    break
    ;;

  esac

done
