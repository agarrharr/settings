#!/usr/bin/env /usr/local/bin/node

// <bitbar.title>Battery</bitbar.title>
// <bitbar.version>v1.0</bitbar.version>
// <bitbar.author>Adam Harris</bitbar.author>
// <bitbar.author.github>aharris88</bitbar.author.github>
// <bitbar.desc>Battery level</bitbar.desc>
// <bitbar.dependencies>node.js osx-battery</bitbar.dependencies>

const osxBattery = require('./battery/node_modules/osx-battery');
const chargingBatteryImage = `iVBORw0KGgoAAAANSUhEUgAAABwAAAAOCAYAAAA8E3wEAAAAoUlEQVQ4jbWUUQ7DIAxD7aj3P8NusBvG++iyUZRRyNonIRVBbeIgKAmBmX0nF+DubOckYXeZ/dSUBEkgKQAr4zlaJymSCv1IkvFhZmrjnYBv8XyRe5ptrIdIF+H5lh0zUxttxXDaLD3A4v5HYr50gNUeZuLpT9HDwN1Z6WHcwqHZiOqlKZkBwPaH4RT9a1OtsPwqHSrsG30Hnwr70q8g03wBgjhUVyy5xQAAAAAASUVORK5CYII=`;
const emptyBatteryImage = `iVBORw0KGgoAAAANSUhEUgAAABwAAAAOCAYAAAA8E3wEAAAAYUlEQVQ4je2UwQrAMAhDjfT/P9nsso6i66EjZTD2TiLFaMXATkiau9OEkETOXQkAUrGZaMsPIqJ09YTZb7mi+FIjuwUAcFzX9yb8BbdT7lBNPvz3J1T7aanfA5WljdyZ9wE/vRshu8KLmwAAAABJRU5ErkJggg==`;
const halfBatteryImage = `iVBORw0KGgoAAAANSUhEUgAAABwAAAAOCAYAAAA8E3wEAAAAXklEQVQ4je2USwrAIAxEZ4L3P3LGTZES8EMbXZS+ZRQfk2CIC0kwMyERSYy1ViCZKutJSzh8/FCk1y1bNiSxXUhS93F9L+Ev3E6ZX3lH/K/HEx5fbS2huw9XVYYMACoE+CEZZcQSvAAAAABJRU5ErkJggg==`;
const fullBatteryImage = `iVBORw0KGgoAAAANSUhEUgAAABwAAAAOCAYAAAA8E3wEAAAAXklEQVQ4je2UUQqAMAxDk7L7H7nxR4ZUhwMzBPF9toVHKC2xIwkRIRiRxFrrBZJW2UjaStMmIk/hAABhM0yyXEhSx3V9L+EvXE67H3lGPfx3E46+g5OeMDPttqvnvQGMURkfaZ3g1AAAAABJRU5ErkJggg==`;

osxBattery().then((res) => {
  const level = parseFloat(res.currentCapacity / res.maxCapacity * 100);
  const roundedLevel = level > 99 | level < 2 ? level.toFixed(2) : level.toFixed(0);
  const batteryImage = res.isCharging
    ? chargingBatteryImage
    : level < 75
      ? halfBatteryImage
      : level < 10
        ? emptyBatteryImage
        : fullBatteryImage;

  console.log(`| image=${batteryImage}`);
  console.log('---');
  console.log(roundedLevel + '%');
});
