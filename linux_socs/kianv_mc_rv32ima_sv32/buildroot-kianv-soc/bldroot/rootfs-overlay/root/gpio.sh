#!/bin/sh

BASE_GPIO=512
END_GPIO=$((512 + 7))
DELAY=1  # Delay in seconds

# Function to initialize GPIOs
init_gpios() {
    gpio=$BASE_GPIO
    while [ $gpio -le $END_GPIO ]; do
        # Check if GPIO is already exported
        if [ ! -e /sys/class/gpio/gpio$gpio ]; then
            echo $gpio > /sys/class/gpio/export
        fi

        echo "out" > /sys/class/gpio/gpio$gpio/direction
        echo "0" > /sys/class/gpio/gpio$gpio/value
        gpio=$((gpio + 1))
    done
}

init_gpios

while true; do
    gpio=$BASE_GPIO
    while [ $gpio -lt $END_GPIO ]; do
        echo "1" > /sys/class/gpio/gpio$gpio/value
       sleep $DELAY
        echo "0" > /sys/class/gpio/gpio$gpio/value
        gpio=$((gpio + 1))
    done

    gpio=$END_GPIO
    while [ $gpio -gt $BASE_GPIO ]; do
        echo "1" > /sys/class/gpio/gpio$gpio/value
        sleep $DELAY
        echo "0" > /sys/class/gpio/gpio$gpio/value
        gpio=$((gpio - 1))
    done
done

